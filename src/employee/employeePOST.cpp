#include <ctime>
#include <exception>
#include <soci/mysql/soci-mysql.h>
#include "database_connector.h"
#include "crow/common.h"
#include "global_variables.h"
#include "middleware.h"
#include "crypto.h"
#include "employee.h"
#include "tokens.h"
#include "permissions.h"

void AddEmployeePOSTRequests(crow::App<AUTH_MIDDLEWARE> &app)
{
    CROW_ROUTE(app, "/jobs/create").methods(crow::HTTPMethod::POST)
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
            try
            {
            std::string uuid = GetUUIDv7();
            db << CREATE_JOB_QUERY, soci::use(uuid), soci::use(title), soci::use(description);
            }
            catch(const soci::mysql_soci_error& e)
            {
                std::cerr << "DATABASE ERROR: " << e.what() << '\n';
                return crow::response(500, "database error");
            }
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
         crow::json::rvalue jsonBody = crow::json::load(req.body);
         std::string firstName = jsonBody["firstName"].s();
         std::string middleName = jsonBody["middleName"].s();
         std::string lastName = jsonBody["lastName"].s();
         std::string gender = jsonBody["gender"].s();
         double salary = jsonBody["salary"].d();
         std::string departmentID = jsonBody["departmentID"].s();
         std::string jobID = jsonBody["jobID"].s();
         std::string managerID = jsonBody["managerID"].s();
         std::string tempManagerHireDate = jsonBody["managerHireDate"].s();
         std::tm managerHireDate;
         if(!strptime(tempManagerHireDate.c_str(), TIME_FORMAT_STRING, &managerHireDate))
            return crow::response(400, "invalid manager hire date");
         std::string id = GetUUIDv7();
         soci::session db(pool);
         db << CREATE_EMPLOYEE_QUERY, 
         soci::use(id), soci::use(firstName),
         soci::use(middleName, middleName.empty() ? NULL_INDICATOR : OK_INDICATOR),
         soci::use(lastName),
         soci::use(gender, gender.empty() ? NULL_INDICATOR : OK_INDICATOR),
         soci::use(salary),
         soci::use(departmentID, departmentID.size() ? NULL_INDICATOR : OK_INDICATOR),
         soci::use(jobID, jobID.size() ? NULL_INDICATOR : OK_INDICATOR),
         soci::use(managerID, managerID.size() ? NULL_INDICATOR : OK_INDICATOR),
         soci::use(managerHireDate, managerID.size() ? NULL_INDICATOR : OK_INDICATOR);
         return crow::response(201, "user successfully created");
         });
}
