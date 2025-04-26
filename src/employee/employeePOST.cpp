#include "database_connector.h"
#include "crow/common.h"
#include "middleware.h"
#include "crypto.h"
#include "employee.h"
#include "tokens.h"
#include "permissions.h"

void AddEmployeePOSTRequests(crow::SimpleApp &app)
{
    CROW_ROUTE(app, "/jobs/create").methods(crow::HTTPMethod::GET)
        ([](const crow::request& req)
         {
         const std::string& authorizationHeader = req.get_header_value("Authorization");
         if(authorizationHeader.length() == 6)
            return crow::response(404, "no authorization");

         //A session token whose UUID is 0 means it is an error because no information was found for
         //it. In other words, the user is using an expired session token
         SessionTokenInfo tokenInfo = GetSessionTokenInfo(authorizationHeader);
         if(tokenInfo.GetUUID() == "0")
            return crow::response(401, "invalid session token");

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
}
