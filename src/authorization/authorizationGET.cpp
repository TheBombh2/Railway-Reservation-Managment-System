#include <soci/session.h>
#include <soci/soci-backend.h>
#include <soci/transaction.h>
#include "database_connector.h"
#include "authorization.h"
#include "crow/common.h"
#include "crypto.h"

void AddGETRequests(crow::SimpleApp &app)
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

