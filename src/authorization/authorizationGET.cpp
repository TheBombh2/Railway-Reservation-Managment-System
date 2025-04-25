#include <strstream>
#include "crow/app.h"
#include "database_connector.h"
#include "authorization.h"
#include "crow/common.h"
#include "crypto.h"

void AddGETRequests(crow::SimpleApp &app)
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
            std::cout << "tf?\n";
            auto authorizationHeader = req.get_header_value("Authorization");
            if(authorizationHeader.empty())
                return crow::response(403, "no session token");
            std::string sessionToken = authorizationHeader.substr(7);
            auto tokenInfo = dbRedis->get(sessionToken);
            if(tokenInfo)
            {
                std::istrstream iss(tokenInfo->c_str());
                std::string permission, subPermission, uuid;
                iss >> permission >> subPermission >> uuid;
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

  CROW_ROUTE(app, "/users/<string>/salt").methods(crow::HTTPMethod::GET)
    ([](const crow::request& req, const std::string& uuid)
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
        return crow::response(500, "database error");
     });

}

