#include "database_connector.h"
#include "crow/common.h"
#include "middleware.h"
#include "crypto.h"
#include "employee.h"
#include "tokens.h"
#include "permissions.h"

void AddEmployeePOSTRequests(crow::App<AUTH_MIDDLEWARE> &app)
{
    CROW_ROUTE(app, "/jobs/create").methods(crow::HTTPMethod::GET)
        ([&](const crow::request& req)
         {
         AUTH_INIT
         if(tokenInfo.HasPermission(PERMISSIONS::JOBS) && tokenInfo.HasSubPermission(SUB_PERMISSIONS::CREATE_JOB))
         {
            crow::json::rvalue body = crow::json::load(req.body);
            soci::session db(pool);
            std::string title = body["title"].s();
            std::string description = body["description"].s();
            if(title.empty() || description.empty())
                return crow::response(400, "invalid request");
            db << CREATE_JOB_QUERY, soci::use(GetUUIDv7()), soci::use(title), soci::use(description);
            return crow::response(201, "job created successfully");
         }

         else
         {
            return crow::response(403, "forbidden");
         }
         });

    CROW_ROUTE(app, "/users/create/employee").methods(crow::HTTPMethod::POST)
        ([&](const crow::request& req)
         {
         AUTH_INIT

         });
}
