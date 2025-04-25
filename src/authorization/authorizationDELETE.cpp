#include <soci/transaction.h>
#include <sw/redis++/command.h>
#include "authorization.h"
#include "crow/app.h"
#include "crow/common.h"
#include "database_connector.h"

void AddDELETERequests(crow::SimpleApp &app)
{
  CROW_ROUTE(app, "/users/<string>/delete").methods(crow::HTTPMethod::DELETE)
    ([](const crow::request& req, const std::string& uuid)
     {
        soci::session db(pool);
        soci::transaction trans(db);
        db << DELETE_CUSTOMER_QUERY_CONTACT_INFO, soci::use(uuid);
        db << DELETE_CUSTOMER_QUERY_SECURITY_INFO, soci::use(uuid);
        db << DELETE_CUSTOMER_QUERY_BASIC_INFO, soci::use(uuid);
        db << DELETE_CUSTOMER_SEAT_RESERVATION, soci::use(uuid);
        db << DELETE_CUSTOMER_PREVIOUS_PASSWORDS, soci::use(uuid);
        trans.commit();
        return crow::response(200, "successfully deleted user");
     });

    CROW_ROUTE(app, "/logout").methods(crow::HTTPMethod::DELETE)
    ([](const crow::request& req)
    {
        auto authorizationHeader = req.get_header_value("Authorization");
        if(authorizationHeader.empty())
            return crow::response(400, "no authorization header");
        std::string token = authorizationHeader.substr(7);
        int res = dbRedis->del(token);
        std::cout << "AUTH TOKEN: "  << authorizationHeader << '\n';
        if(res == 0)
            return crow::response(400, "invalid authorization");
        return crow::response(204, "logged out successfully");
     });
}
