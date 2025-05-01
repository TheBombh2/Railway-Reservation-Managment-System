#include <vector>
#include "database_connector.h"
#include "employee.h"
#include "middleware.h"
#include "permissions.h"

void AddEmployeeGETRequests(crow::App<AUTH_MIDDLEWARE> &app)
{
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
}
