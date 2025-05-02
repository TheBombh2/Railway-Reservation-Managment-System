#include <soci/session.h>
#include <soci/soci-backend.h>
#include <vector>
#include "crow/common.h"
#include "database_connector.h"
#include "employee.h"
#include "middleware.h"
#include "permissions.h"

void AddEmployeeGETRequests(crow::App<AUTH_MIDDLEWARE> &app)
{
    CROW_ROUTE(app, "/users/<string>/employee/salt").methods(crow::HTTPMethod::GET)
        ([&](const crow::request& req, const std::string& uuidInput)
         {
         AUTH_INIT(PERMISSIONS::NONE_PERM, SUB_PERMISSIONS::NONE_SUBPERM)
         std::string uuid = tokenInfo.GetUUID();
         if(uuidInput != uuid)
            return crow::response(403, "forbidden");
         std::string salt;
         soci::indicator ind;
         soci::session db(pool);
         db << GET_EMPLOYEE_SALT_QUERY, soci::use(uuid), soci::into(salt, ind);
         if(ind != soci::indicator::i_ok)
            return crow::response(404, "not found");
         return crow::response(200, salt);
         });

    CROW_ROUTE(app, "/departments/info").methods(crow::HTTPMethod::GET)
        ([&](const crow::request& req)
         {
         AUTH_INIT(PERMISSIONS::HUMAN_RESOURCES, SUB_PERMISSIONS::VIEW_JOB)
         crow::json::wvalue returnBody;
         std::vector<std::string> titles(MAX_DEPARTMENTS_RETURNED);
         std::vector<std::string> descriptions(MAX_DEPARTMENTS_RETURNED);
         std::vector<std::string> locations(MAX_DEPARTMENTS_RETURNED);
         soci::session db(pool);
         db << GET_DEPARTMENTS_QUERY, soci::into(titles), soci::into(descriptions), soci::into(locations);
         returnBody["size"] = titles.size();
         for(unsigned int i = 0; i < titles.size(); i++)
         {
             returnBody["departments"][i]["title"] = titles[i];
             returnBody["departments"][i]["description"] = descriptions[i];
             returnBody["departments"][i]["location"] = locations[i];
         }
         return crow::response(200, returnBody);
         }
         );

    CROW_ROUTE(app, "/jobs/<string>/info").methods(crow::HTTPMethod::GET)
        ([&](const crow::request& req, const std::string& uuid)
         {
         AUTH_INIT(PERMISSIONS::JOBS, SUB_PERMISSIONS::VIEW_JOB)
         soci::indicator ind;
         soci::session db(pool);
         std::string title, description;
         db << GET_JOB_INFO_QUERY, soci::use(uuid), soci::into(title, ind), soci::into(description);
         if(ind == soci::indicator::i_null)
            return crow::response(404, "not found");
         crow::json::wvalue result;
         result["title"] = title;
         result["description"] = description;
         return crow::response(200, result);
         });
}
