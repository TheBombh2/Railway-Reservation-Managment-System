#include <strstream>
#include <sw/redis++/utils.h>
#include "crow/app.h"
#include "database_connector.h"
#include "authorization.h"
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
}

