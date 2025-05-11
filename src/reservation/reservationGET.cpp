#include "crow/common.h"
#include "database_connector.h"
#include "middleware.h"
#include "permissions.h"
#include "reservation.h"
#include <soci/soci-backend.h>

void AddReservationGETRequests(crow::App<AUTH_MIDDLEWARE> &app)
{
  CROW_ROUTE(app, "/users/<string>/salt").methods(crow::HTTPMethod::GET)
    ([&](const crow::request& req, const std::string& uuid)
     {
        AUTH_INIT(PERMISSIONS::NONE_PERM, SUB_PERMISSIONS::NONE_SUBPERM)
        if(tokenInfo.GetUUID() != uuid)
            return crow::response(403, "forbidden");
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
            std::cerr << "DATABASE ERROR(/stations/all-stations): " << e.what() << '\n';
            return crow::response(500, "database error");
         }
         crow::json::wvalue result;
         for(unsigned int i = 0; i < ids.size(); i++)
         {
            result["stations"][i]["name"] = titles[i];
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

}
