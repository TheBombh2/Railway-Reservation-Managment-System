#include "crow/common.h"
#include "database_common.h"
#include "database_connector.h"
#include "middleware.h"
#include "permissions.h"
#include "reservation.h"
#include <soci/soci-backend.h>
#include <sw/redis++/redis.h>
#include <sw/redis++/utils.h>

void RouteGraph::PopulateGraph(const std::vector<std::string>& src, const std::vector<std::string>& dst, 
                               const std::vector<int>& departureDelay, const std::vector<int>& travelTime)
{
    for(unsigned int i = 0; i < src.size(); i++)
    {
        std::tuple<std::string, int, int> temp(dst[i], departureDelay[i], travelTime[i]); 
        this->map.insert_or_assign(src[i], temp);
    }
}

void AddReservationGETRequests(crow::App<AUTH_MIDDLEWARE> &app)
{
  CROW_ROUTE(app, "/users/<string>/salt").methods(crow::HTTPMethod::GET)
    ([&](const crow::request& req, const std::string& uuid)
     {
        AUTH_INIT(PERMISSIONS::NONE_PERM, SUB_PERMISSIONS::NONE_SUBPERM)
        if(tokenInfo.GetUUID() != uuid)
            return crow::response(403, "forbidden");
        try
        {
            soci::session db(pool); 
            soci::transaction trans(db);
            soci::indicator ind;
            std::string saltResult;
            db << SELECT_CUSTOMER_PASSWORD_SALT_QUERY, soci::use(uuid), soci::into(saltResult, ind);
            trans.commit();
            if(db.got_data())
            {
                switch(ind)
                {
                    case soci::i_ok:
                        return crow::response(200, saltResult);
                        break;
                    case soci::i_null:
                        return crow::response(404, "user not found");
                        break;
                    case soci::i_truncated:
                        return crow::response(500);
                }
            }
        }
        catch(const std::exception& e)
        {
            CHECK_DATABASE_DISCONNECTION
            std::cerr << "DATABASE ERROR (/users/<string>/salt): " << e.what() << '\n'; 
            std::cerr << "<string> value: " << uuid << '\n';
            return crow::response(500, "database error");
        }
        return crow::response(500, "database error");
     });
    
    CROW_ROUTE(app, "/users/customer/all-info").methods(crow::HTTPMethod::GET)
        ([&](const crow::request& req)
         {
         AUTH_INIT(PERMISSIONS::NONE_PERM, SUB_PERMISSIONS::NONE_SUBPERM)
         std::string uuid = tokenInfo.GetUUID();
         soci::session db(pool);
         std::string firstName, middleName, lastName, gender, email, phoneNumber; 
         soci::indicator middleNameInd;
         try
         {
            db << GET_CUSTOMER_INFORMATION_QUERY, soci::use(uuid), soci::into(firstName),
            soci::use(middleName, middleNameInd), soci::use(lastName), soci::use(gender),
            soci::use(email), soci::use(phoneNumber);
         }
         catch(const std::exception& e)
         {
            CHECK_DATABASE_DISCONNECTION
            std::cerr << "DATABASE ERROR(/users/customer/all-info): " << e.what() << '\n';
            return crow::response(500, "database error");
         }
         crow::json::wvalue result;
         result["firstName"] = firstName;
         result["middleName"] = middleName;
         result["lastName"] = lastName;
         result["gender"] = gender;
         result["email"] = email;
         result["phoneNumber"] = phoneNumber;
         return crow::response(200, result);
         });

    //Train station endpoints go here
    CROW_ROUTE(app, "/stations/all-stations").methods(crow::HTTPMethod::GET)
        ([&](const crow::request& req)
         {
         AUTH_INIT(PERMISSIONS::NONE_PERM, SUB_PERMISSIONS::NONE_SUBPERM)
         soci::session db(pool);
         std::vector<std::string> ids(MAX_STATIONS_RETURNED),titles(MAX_STATIONS_RETURNED),
         descriptions(MAX_STATIONS_RETURNED),
         locations(MAX_STATIONS_RETURNED), longitudes(MAX_STATIONS_RETURNED), latitudes(MAX_STATIONS_RETURNED);
         std::vector<std::vector<std::string>> connectionNames(ids.size(),std::vector<std::string>(MAX_STATION_CONNECTIONS));
         std::vector<std::vector<double>> connectionDistances(ids.size(), std::vector<double>(MAX_STATION_CONNECTIONS));
         try
         {
            db << GET_STATIONS_QUERY, soci::into(ids), soci::into(titles), soci::into(descriptions),
            soci::into(locations), soci::into(longitudes), soci::into(latitudes);
            for(unsigned int i = 0; i < ids.size(); i++)
            {
                db << GET_STATION_CONNECTIONS_QUERY, soci::use(ids[i]), soci::into(connectionNames[i]),
                soci::into(connectionDistances[i]);
            }
         }
         catch(const std::exception& e)
         {
            CHECK_DATABASE_DISCONNECTION
            std::cerr << "DATABASE ERROR(/stations/all-stations): " << e.what() << '\n';
            return crow::response(500, "database error");
         }
         crow::json::wvalue result;
         for(unsigned int i = 0; i < ids.size(); i++)
         {
            result["stations"][i]["name"] = titles[i];
            result["stations"][i]["id"] = ids[i];
            result["stations"][i]["description"] = descriptions[i];
            result["stations"][i]["location"] = locations[i];
            result["stations"][i]["latitude"] = latitudes[i];
            result["stations"][i]["longitude"] = longitudes[i];
            for(unsigned int j = 0; j < connectionNames[i].size(); j++)
            {
                result["stations"][i]["connections"][j]["name"] = connectionNames[i][j];
                result["stations"][i]["connections"][j]["distance"] = connectionDistances[i][j];
            }
         }
         return crow::response(200, result);
         });
    
    CROW_ROUTE(app, "/users/<string>/customer/uuid").methods(crow::HTTPMethod::GET)
        ([&](const crow::request& req, const std::string& email)
         {
         AUTH_INIT(PERMISSIONS::NONE_PERM, SUB_PERMISSIONS::NONE_SUBPERM)
         std::string customerUUID = GetCustomerUUID(email);
         if(customerUUID.empty())
            return crow::response(404, "not found");
         if(tokenInfo.GetUUID() != customerUUID)
            return crow::response(403, "forbidden");
         return crow::response(200, customerUUID);
         });

    CROW_ROUTE(app, "/trains/all-info").methods(crow::HTTPMethod::GET)
        ([&](const crow::request& req)
         {
         AUTH_INIT(PERMISSIONS::NONE_PERM, SUB_PERMISSIONS::NONE_SUBPERM)
         std::vector<std::string> trainNames(MAX_TRAINS_RETURNED), trainIDs(MAX_TRAINS_RETURNED);
         std::vector<double> trainSpeeds(MAX_TRAINS_RETURNED);
         try
         {
            soci::session db(pool);
            db << GET_ALL_TRAINS_INFO, soci::into(trainIDs), soci::into(trainNames), soci::into(trainSpeeds);
         }
         catch(const std::exception& e)
         {
            CHECK_DATABASE_DISCONNECTION
            std::cerr << "DATABASE ERROR (/trains/all-info): " << e.what() << '\n';
            return crow::response(500, "database error");
         }

         crow::json::wvalue result;
         result["size"] = trainIDs.size();
         for(unsigned int i = 0; i < trainIDs.size(); i++)
         {
            result["trains"][i]["id"] = trainIDs[i];
            result["trains"][i]["name"] = trainNames[i];
            result["trains"][i]["speed"] = trainSpeeds[i];
         }
         return crow::response(200, result);
         });

    CROW_ROUTE(app, "/routes/all-info").methods(crow::HTTPMethod::GET)
        ([&](const crow::request& req)
         {
         AUTH_INIT(PERMISSIONS::TRAIN_MANAGEMENT, SUB_PERMISSIONS::VIEW_TRAIN_DATA)
         std::vector<std::string> ids(MAX_ROUTES_RETURNED), titles(MAX_ROUTES_RETURNED), descriptions(MAX_ROUTES_RETURNED),
         firstStations(MAX_ROUTES_RETURNED);
         std::vector<double> totalDistances(MAX_ROUTES_RETURNED);
         try
         {
            soci::session db(pool);
            db << GET_ALL_ROUTES_INFO_QUERY, soci::into(ids), soci::into(titles), soci::into(descriptions),
            soci::into(firstStations);
         }
         catch(const std::exception& e)
         {
            CHECK_DATABASE_DISCONNECTION
            std::cerr << "DATABASE ERROR (/routes/all-info): " << e.what() << '\n';
            return crow::response(500, "database error");
         }

         crow::json::wvalue result;
         result["size"] = ids.size();
         for(unsigned int i = 0; i < ids.size(); i++)
         {
            result["routes"][i]["id"] = ids[i];
            result["routes"][i]["title"] = titles[i];
            result["routes"][i]["description"] = descriptions[i];
            result["routes"][i]["firstStationID"] = firstStations[i];
            result["routes"][i]["totalDistance"] = totalDistances[i];
         }
         return crow::response(200, result);
         });

    CROW_ROUTE(app, "/routes/<int>/connections").methods(crow::HTTPMethod::GET)
        ([&](const crow::request& req, const int routeID)
         {
         AUTH_INIT(PERMISSIONS::TRAIN_MANAGEMENT, SUB_PERMISSIONS::VIEW_TRAIN_DATA)
         int routeIDTest;
         soci::indicator routeIDTestInd;
         std::vector<std::string> sourceStationIDs(MAX_STATION_CONNECTIONS),
         destinationStationIDS(MAX_STATION_CONNECTIONS);
         std::vector<int> travelTimes(MAX_STATION_CONNECTIONS), departureDelays(MAX_STATION_CONNECTIONS);
         try
         {
            soci::session db(pool);
            db << VERIFY_ROUTE_QUERY, soci::use(routeID), soci::into(routeIDTest, routeIDTestInd);
            if(routeIDTestInd == NULL_INDICATOR)
            {
                std::cerr << "ERROR: Route does not exist\n";
                std::cerr << "<int> value: " << routeID << '\n';
                return crow::response(404, "not found");
            }

            db << GET_ALL_ROUTE_CONNECTIONS_QUERY, soci::use(routeID), soci::into(sourceStationIDs),
            soci::into(destinationStationIDS), soci::into(departureDelays), soci::into(travelTimes);
         }
         catch(const std::exception& e)
         {
            CHECK_DATABASE_DISCONNECTION
            std::cerr << "DATABASE ERROR (/routes/<int>/connections): " << e.what() << '\n';
            std::cerr << "<int> value: " << routeID << '\n';
         }
         
         crow::json::wvalue result;
         result["size"] = sourceStationIDs.size();
         for(unsigned int i = 0; i < sourceStationIDs.size(); i++)
         {
            result["connections"][i]["sourceStationID"] = sourceStationIDs[i];
            result["connections"][i]["destinationStationID"] = destinationStationIDS[i];
            result["connections"][i]["departureDelay"] = departureDelays[i];
            result["connections"][i]["travelTime"] = travelTimes[i];
         }
         return crow::response(200, result);
         });

    CROW_ROUTE(app, "/trains/all-types").methods(crow::HTTPMethod::GET)
        ([&](const crow::request& req)
        {
        AUTH_INIT(PERMISSIONS::TRAIN_MANAGEMENT, SUB_PERMISSIONS::VIEW_TRAIN_DATA)
        std::vector<std::string> titles(MAX_TRAINS_RETURNED), descriptions(MAX_TRAINS_RETURNED);
        std::vector<int> ids(MAX_TRAINS_RETURNED);
        try
        {
           soci::session db(pool); 
           db << GET_TRAIN_TYPES_QUERY, soci::into(ids), soci::into(titles), soci::into(descriptions);
        }
        catch(const std::exception& e)
        {
            CHECK_DATABASE_DISCONNECTION
            std::cerr << "DATABASE ERROR (/trains/all-types): " << e.what() << '\n';
            return crow::response(500, "database error");
        }

        crow::json::wvalue result;
        result["size"] = ids.size();
        for(unsigned int i = 0; i < ids.size(); i++)
        {
            result["types"][i]["title"] = titles[i];
            result["types"][i]["description"] = descriptions[i];
            result["types"][i]["id"] = ids[i];
        }
        return crow::response(200, result);
        });

    CROW_ROUTE(app, "/trains/get-states").methods(crow::HTTPMethod::GET)
        ([&](const crow::request& req)
         {
         AUTH_INIT(PERMISSIONS::TRAIN_MANAGEMENT, SUB_PERMISSIONS::VIEW_TRAIN_DATA)
         std::vector<std::string> trainIds(MAX_TRAINS_RETURNED);
         try
         {
            soci::session db(pool);
            db << GET_ALL_TRAINS_INFO, soci::into(trainIds);
         }
         catch(const std::exception& e)
         {
            CHECK_DATABASE_DISCONNECTION
            std::cerr << "DATABASE ERROR (/trains/get-states): " << e.what() << '\n';
            return crow::response(500, "database error");
         }

         //Now we must check database entries for each of those trainIDs
         std::vector<redis::OptionalString> trainSendTimes(trainIds.size());
         for(unsigned int i = 0; i < trainSendTimes.size(); i++)
         {
            trainSendTimes[i] = RedisGetValue(trainIds[i]);
         }

         crow::json::wvalue result;
         result["size"] = trainSendTimes.size();
         for(unsigned int i = 0; i < trainSendTimes.size(); i++)
         {
            result["trains"][i]["id"] = trainIds[i];
            result["trains"][i]["state"] = 
            (trainSendTimes[i] ? "sent" : "stationary");
         }
         return crow::response(200, result);
         });

    CROW_ROUTE(app, "/trains/<string>/get-state").methods(crow::HTTPMethod::GET)
        ([&](const crow::request& req, const std::string& uuid)
         {
         AUTH_INIT(PERMISSIONS::TRAIN_MANAGEMENT, SUB_PERMISSIONS::VIEW_TRAIN_DATA)
         try
         {
            std::string trainName;
            soci::session db(pool);
            db << GET_TRAIN_NAME, soci::use(uuid), soci::into(trainName);
            if(trainName.empty())
                return crow::response(404, "not found");
         }
         catch(const std::exception& e)
         {
            CHECK_DATABASE_DISCONNECTION
            std::cerr << "DATABASE ERROR (/trains/<string>/get-state): " << e.what() << '\n';
            std::cerr << "<string> value: " << uuid << '\n';
            return crow::response(500, "database error");
         }
         redis::OptionalString result = RedisGetValue(uuid);
         if(result)
            return crow::response(200, "sent");
         return crow::response(200, "stationary");
         });

    CROW_ROUTE(app, "/reservations/get-reservations").methods(crow::HTTPMethod::GET)
        ([&](const crow::request& req)
         {
         AUTH_INIT(PERMISSIONS::NONE_PERM, SUB_PERMISSIONS::NONE_SUBPERM)
         /*
          * The solution is as follows:
          * FIRSTLY, search valkey for any 'sent' trains
          * FOR EACH 'sent' TRAIN, calculate their arrival time at each station in the route
          * THIRDLY, look for the routes which contain the 'source' station,
          * FOURTHLY, get the arrival time at the 'destination' stationA
          */
         std::vector<std::string> trainIds(MAX_TRAINS_RETURNED);
         std::vector<int> trainRouteIDs(MAX_TRAINS_RETURNED);
         std::unordered_map<std::string, std::pair<std::string, int>> sentTrains;
         try
         {
            soci::session db(pool);
            db << GET_ALL_TRAINS_INFO, soci::into(trainIds), soci::into(trainRouteIDs);
         }
         catch(const std::exception& e)
         {
            CHECK_DATABASE_DISCONNECTION
            std::cerr << "DATABASE ERROR (/reservations/get-reservations): " << e.what() << '\n';
            return crow::response(500, "database error");
         }
            
         //Find out which trains have been 'sent' and where their routes are
         for(unsigned int i = 0; i < trainIds.size(); i++)
         {
            redis::OptionalString temp = RedisGetValue(trainIds[i]);
            if(temp)
                sentTrains[trainIds[i]] = std::make_pair(*temp, trainRouteIDs[i]);
         }
         //For each train that has been 'sent', calculate their arrival time at each station in
         //their route
         //Key: Train ID | Value: pair<station id, arrival time>
         std::unordered_map<std::string, std::vector<std::pair<std::string, std::string>>> result;
         for(auto it = sentTrains.begin(); it != sentTrains.end(); it++)
         {
            std::vector<std::string> sources(MAX_STATION_CONNECTIONS), destinations(MAX_STATION_CONNECTIONS);
            std::vector<int> departureDelays(MAX_STATION_CONNECTIONS), travelTimes(MAX_STATION_CONNECTIONS);
            soci::session db(pool);
            db << GET_ALL_ROUTE_CONNECTION_IDS_QUERY, soci::into(sources), soci::into(destinations),
            soci::into(departureDelays), soci::into(travelTimes);
            
            RouteGraph rg;
            rg.PopulateGraph(sources, destinations, departureDelays, travelTimes);
            std::string firstStation, tempStation;
            std::string tempTime = it->second.first;
            //First station is from the Route entity itself
            db << GET_ROUTE_FIRST_STATION_QUERY, soci::use(it->second.second), soci::into(firstStation);
            tempStation = firstStation;
            while(true)
            {
                std::tuple<std::string, int, int> currentStation(rg.map[tempStation]);
                tempStation = std::get<0>(currentStation);
                if(tempStation == firstStation)
                    break;
                //result[it->first]
            }
         }
         });

}
