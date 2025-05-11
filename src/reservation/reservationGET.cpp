#include "database_connector.h"
#include "middleware.h"
#include "permissions.h"
#include "reservation.h"

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

}
