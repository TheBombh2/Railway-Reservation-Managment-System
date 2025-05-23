#include <strstream>
#include <sw/redis++/utils.h>
#include "crow/app.h"
#include "authorization.h"
#include "database_connector.h"
#include "database_common.h"
#include "crow/common.h"
#include "crypto.h"

void AddAuthorizationGETRequests(crow::SimpleApp &app)
{
  //Utility Section
  CROW_ROUTE(app, "/utility/salt").methods(crow::HTTPMethod::GET)
    ([](const crow::request& req)
     {
        std::string salt = GetRandomSalt(SALT_LENGTH);
        if(salt.empty())
          return crow::response(500);
        return crow::response(200, salt);
     });

    CROW_ROUTE(app, "/users/token-info").methods(crow::HTTPMethod::GET)
         ([](const crow::request& req)
          {
            auto authorizationHeader = req.get_header_value("Authorization");
            if(authorizationHeader.empty())
                return crow::response(403, "no session token");
            std::string sessionToken = authorizationHeader.substr(7);
            redis::OptionalString tokenInfo = RedisGetValue(sessionToken);
            if(tokenInfo)
            {
                std::istrstream iss(tokenInfo->c_str());
                std::string permission, subPermission, uuid;
                iss >> permission;
                std::string temp;
                for(int i = 0; i < 8; i++)
                {
                    iss >> temp;
                    subPermission += temp;
                }
                iss >> uuid; 
                crow::json::wvalue jsonReply;
                jsonReply["permission"] = permission;
                jsonReply["subPermission"] = subPermission;
                jsonReply["uuid"] = uuid;
                return crow::response(200, jsonReply);
            }
            else
            {
                return crow::response(404, "token not found");
            }
          });

    CROW_ROUTE(app, "/users/uuid").methods(crow::HTTPMethod::GET)
        ([](const crow::request& req)
         {
            auto authorizationHeader = req.get_header_value("Authorization");
            if(authorizationHeader.empty())
                return crow::response(403, "no session token");
            std::string sessionToken = authorizationHeader.substr(7);
            redis::OptionalString tokenInfo = RedisGetValue(sessionToken);
            if(tokenInfo)
            {
                int pos = tokenInfo->find_last_of(' ');
                std::string uuid = tokenInfo->substr(pos + 1);
                return crow::response(200, uuid);
            }
            else
            {
                return crow::response(404, "token not found");
            }
         });

    CROW_ROUTE(app, "/users/<string>/employee/salt").methods(crow::HTTPMethod::GET)
        ([](const crow::request& req, const std::string& emailInput)
         {
         std::string uuid = GetEmployeeUUID(emailInput);
         if(uuid.empty())
            return crow::response(404, "not found");
         std::string salt;
         soci::indicator ind;
         try
         {
            soci::session db(pool);
            db << GET_EMPLOYEE_SALT_QUERY, soci::use(uuid), soci::into(salt, ind);
            if(ind != soci::indicator::i_ok)
                return crow::response(404, "not found");
         }
         catch(const std::exception& e)
         {
            CHECK_DATABASE_DISCONNECTION
            std::cerr << "DATABASE ERROR (/users/<string>/employee/salt): " << e.what() << '\n'; 
            std::cerr << "<string> value: " << emailInput << '\n';
            return crow::response(500, "database error");
         }
         return crow::response(200, salt);
         });

  CROW_ROUTE(app, "/users/<string>/customer/salt").methods(crow::HTTPMethod::GET)
    ([](const crow::request& req, const std::string& email)
     {
        std::string uuid = GetCustomerUUID(email);
        if(uuid.empty())
            return crow::response(404, "not found");
        try
        {
            soci::session db(pool); 
            soci::transaction trans(db);
            soci::indicator ind;
            std::string saltResult;
            db << GET_CUSTOMER_PASSWORD_SALT_QUERY, soci::use(uuid), soci::into(saltResult, ind);
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
            std::cerr << "<string> value: " << email << '\n';
            return crow::response(500, "database error");
        }
        return crow::response(500, "database error");
     });

}

