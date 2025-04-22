#include <soci/session.h>
#include "authorization.h"
#include "crypto.h"

void AddGETRequests(crow::SimpleApp &app, const soci::session& db)
{
  CROW_ROUTE(app, "/")([](const crow::request& req)
      {
        return "Hello, World!";
      });

  //Utility Section
  CROW_ROUTE(app, "/utility/salt").methods(crow::HTTPMethod::GET)
    ([](const crow::request& req)
     {
        std::string salt = GetRandomSalt(SALT_LENGTH);
        if(salt.empty())
          return crow::response(500);
        return crow::response(200, salt);
     });
}

void AddPOSTRequest(crow::SimpleApp &app, const soci::session &db)
{

}
