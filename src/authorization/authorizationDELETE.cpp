#include <soci/transaction.h>
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
}
