#include "crypto.h"
#include "database_connector.h"
#include "crow/common.h"
#include "global_variables.h"
#include "middleware.h"
#include "permissions.h"
#include "reservation.h"
#include <soci/soci-backend.h>

std::pair<std::string, std::string> GetStationIDs(const std::pair<std::string, std::string>& stationNames)
{
    soci::session db(pool);
    std::string id1, id2;
    db << GET_STATION_ID_QUERY, soci::into(id1), soci::use(stationNames.first);
    db << GET_STATION_ID_QUERY, soci::into(id2), soci::use(stationNames.second);
    return std::make_pair(id1, id2);
}

void AddReservationPOSTRequests(crow::App<AUTH_MIDDLEWARE> &app)
{
  CROW_ROUTE(app, "/users/create/customer").methods(crow::HTTPMethod::POST)
  ([&](const crow::request& req)
   {
      const auto body = crow::json::load(req.body);
      std::string firstName = body["firstName"].s();
      std::string middleName = body["middleName"].s();
      std::string lastName = body["lastName"].s();
      std::string gender = body["gender"].s();

      std::string phoneNumber = body["phoneNumber"].s();
      std::string email = body["email"].s();
      
      std::string passwordHash = body["passwordHash"].s();
      std::string passwordSalt = body["passwordSalt"].s();
      std::string ID = GetUUIDv7();
      
      soci::session db(pool);
      soci::transaction trans(db);
      db << CREATE_CUSTOMER_QUERY_BASIC_INFO, soci::use(ID), soci::use(firstName), soci::use(middleName), 
      soci::use(lastName), soci::use(gender);
      db << CREATE_CUSTOMER_QUERY_CONTACT_INFO, soci::use(ID, "ID"), soci::use(email, "Email")
      ,soci::use(phoneNumber, "PhoneNumber");
      db << CREATE_CUSTOMER_QUERY_SECURITY_INFO, soci::use(ID, "ID"), soci::use(passwordHash, "PasswordHash"),
      soci::use(passwordSalt, "PasswordSalt");
      trans.commit();

      return crow::response(201, "customer user created successfully");
   });

    
    CROW_ROUTE(app, "/stations/create-station").methods(crow::HTTPMethod::POST)
        ([&](const crow::request& req)
         {
         AUTH_INIT(PERMISSIONS::TRAIN_MANAGEMENT, SUB_PERMISSIONS::ADD_STATION)
         const crow::json::rvalue body = crow::json::load(req.body);
         std::string name, description, location;
         double latitude, longitude;
         try
         {
            name = body["name"].s();
            description = body["description"].s();
            location = body["location"].s();
            latitude = body["latitude"].d();
            longitude = body["longitude"].d();
         }
         catch(const std::exception& e)
         {
            std::cerr << "ERROR (/stations/create-station): bad request " << e.what() << '\n';
            return crow::response(400, "bad request");
         }
         try
         {
            soci::session db(pool); 
            std::string uuid = GetUUIDv7();
            db << CREATE_STATION_QUERY, soci::use(uuid), soci::use(name), soci::use(description),
            soci::use(location), soci::use(longitude), soci::use(latitude);
         }
         catch(const std::exception& e)
         {
            std::cerr << "DATABASE ERROR(/stations/create-station): " << e.what() << '\n';
            return crow::response(500, "database error");
         }
         return crow::response(201, "station successfully created");
         });

    CROW_ROUTE(app, "/stations/add-connection").methods(crow::HTTPMethod::POST)
        ([&](const crow::request& req)
         {
         AUTH_INIT(PERMISSIONS::TRAIN_MANAGEMENT, SUB_PERMISSIONS::ADD_STATION)
         const crow::json::rvalue body = crow::json::load(req.body);
         std::string sourceName, destinationName;
         double distance;
         try
         {
            sourceName = body["source"].s();
            destinationName = body["destination"].s();
            distance = body["distance"].d();
         }
         catch(const std::exception& e)
         {
            std::cerr << "ERROR (/stations/add-connection): " << e.what() << '\n';
            return crow::response(400, "bad request");
         }
         //We will now need the stations IDs for insertion
         std::pair<std::string, std::string> temp;
         temp = GetStationIDs(std::make_pair(sourceName, destinationName));
         if(temp.first.empty() || temp.second.empty())
         {
            std::cerr << "ERROR(/stations/add-connection): failed to get ID of station\n";
            std::cerr << temp.first << ' ' << temp.second << '\n';
            return crow::response(400, "bad request");
         }
         try
         {
            soci::session db(pool);
            db << ADD_STATION_CONNECTION_QUERY, soci::use(temp.first), soci::use(temp.second), soci::use(distance);
         }
         catch(const std::exception& e)
         {
            std::cerr << "DATABASE ERROR(/stations/add-connection): " << e.what() << '\n';
            return crow::response(500, "database error");
         }
         return crow::response(201, "station connection successfully created");
         });

    CROW_ROUTE(app, "/trains/create").methods(crow::HTTPMethod::POST)
        ([&](const crow::request& req)
         {
         AUTH_INIT(PERMISSIONS::TRAIN_MANAGEMENT, SUB_PERMISSIONS::ADD_TRAIN)
         const crow::json::rvalue body = crow::json::load(req.body);
         std::string name, tempPurchaseDate;
         double speed;
         int routeID, trainTypeID;
         std::tm purchaseDate;
         try
         {
            name = body["name"].s();
            speed = body["speed"].d();
            routeID = body["routeID"].i();
            trainTypeID = body["trainTypeID"].i();
            tempPurchaseDate = body["purchaseDate"].s();
            if(!strptime(tempPurchaseDate.c_str(), TIME_FORMAT_STRING, &purchaseDate))
                return crow::response(400, "invalid purchase date");
         }
         catch(const std::exception& e)
         {
            std::cerr << "JSON ERROR (/trains/crate): " << e.what() << '\n';
            return crow::response(400, "bad request");
         }

         try
         {
            soci::session db(pool);
            soci::transaction trans(db);
            std::string uuid = GetUUIDv7();
            db << CREATE_TRAIN_QUERY, soci::use(uuid), soci::use(name),
            soci::use(speed), soci::use(trainTypeID), soci::use(purchaseDate);
            db << ADD_ROUTE_TO_TRAIN_QUERY, soci::use(uuid), soci::use(routeID);
            trans.commit();
         }
         catch(const std::exception& e)
         {
            std::cerr << "DATABASE ERROR: (/trains/create) " << e.what() << '\n';
            return crow::response(500, "database error");
         }
         return crow::response(201, "train successfully created");
         });

    CROW_ROUTE(app, "/routes/create").methods(crow::HTTPMethod::POST)
        ([&](const crow::request& req)
         {
         AUTH_INIT(PERMISSIONS::TRAIN_MANAGEMENT, SUB_PERMISSIONS::ADD_STATION)
         const crow::json::rvalue body = crow::json::load(req.body);
         std::string name, description, firstStationID;
         try
         {
            name = body["title"].s();
            description  = body["description"].s();
            firstStationID = body["firstStationID"].s();
         }
         catch(const std::exception& e)
         {
            std::cerr << "JSON ERROR (/routes/create): " << e.what() << '\n';
            return crow::response(400, "bad request");
         }
         
         try
         {
            soci::session db(pool);
            db << CREATE_ROUTE_QUERY, soci::use(name), soci::use(description),
            soci::use(firstStationID);
         }
         catch(const std::exception& e)
         {
            std::cerr << "DATABASE ERROR (/routes/create): " << e.what() << '\n';
            return crow::response(500, "database error");
         }
         return crow::response(201, "successfully created route");
         });
    
    CROW_ROUTE(app, "/routes/add-connection").methods(crow::HTTPMethod::POST)
        ([&](const crow::request& req)
         {
         AUTH_INIT(PERMISSIONS::TRAIN_MANAGEMENT, SUB_PERMISSIONS::ADD_STATION)
         const crow::json::rvalue body = crow::json::load(req.body);
         std::string routeID, sourceStationName, destinationStationName;
         int travelTime, departureDelay;

         try
         {
            routeID = body["routeID"].s();
            sourceStationName = body["sourceStationID"].s();
            destinationStationName = body["destinationStationID"].s();
            travelTime = body["travelTime"].i();
            departureDelay = body["departureDelay"].i();
         }
         catch(const std::exception& e)
         {
            std::cerr << "JSON ERROR: " << e.what() << '\n';
            return crow::response(400, "bad request");
         }

         //Now, we need to make sure that those stationqs are actually connected
         //If they are connected, then add the route connection
         double distance;
         soci::indicator distanceInd;
         try
         {
            soci::session db(pool);
            db << VERIFY_STATION_CONNECTION_QUERY, soci::use(sourceStationName) ,soci::use(destinationStationName),
            soci::into(distance, distanceInd);
            
            if(distanceInd == NULL_INDICATOR)
            {
                std::cerr << "ERROR (/routes/add-connection): stations are not connected\n";
                return crow::response(400);
            }
            
            db << CREATE_ROUTE_CONNECTION_QUERY, soci::use(routeID),soci::use(sourceStationName),
            soci::use(destinationStationName), soci::use(departureDelay), soci::use(travelTime);
         }
         catch(const std::exception& e)
         {
            std::cerr << "DATABASE ERROR (/routes/add-connection): " << e.what() << '\n';
            return crow::response(500, "database error");
         }
         return crow::response(201, "route connection added successfully");
         });

    CROW_ROUTE(app, "/trains/types/create").methods(crow::HTTPMethod::POST)
        ([&](const crow::request& req)
        {
        AUTH_INIT(PERMISSIONS::TRAIN_MANAGEMENT, SUB_PERMISSIONS::ADD_TRAIN)
        const crow::json::rvalue body = crow::json::load(req.body);
        std::string title, description;
        try
        {
            title = body["title"].s();
            description = body["description"].s();
        }
        catch(const std::exception& e)
        {
            std::cerr << "JSON ERROR (/trains/types/create): " << e.what() << '\n';
            return crow::response(400, "bad request");
        }

        try
        {
            soci::session db(pool);
            db << CREATE_TRAIN_TYPE_QUERY, soci::use(title), soci::use(description);
        }
        catch(const std::exception& e)
        {
            std::cerr << "DATABASE ERROR (/trains/types/create): " << e.what() << '\n'; 
            return crow::response(500, "database error");
        }
        return crow::response(201, "train type successfully created");
        });

    CROW_ROUTE(app, "/trains/<int>/send").methods(crow::HTTPMethod::POST)
        ([&](const crow::request& req, const int trainID)
         {
         AUTH_INIT(PERMISSIONS::TRAIN_MANAGEMENT, SUB_PERMISSIONS::UPDATE_TRAIN_LOCATION)
         return crow::response(200, "not ok");
         });
}
