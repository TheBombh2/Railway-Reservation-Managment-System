#include "crypto.h"
#include "crow/common.h"
#include "employee.h"
#include "middleware.h"
#include "database_connector.h"
#include "permissions.h"
#include <chrono>
#include <soci/soci-backend.h>

void AddEmployeePATCHRequests(crow::App<AUTH_MIDDLEWARE>& app)
{
    CROW_ROUTE(app, "/users/<string>/employee/password-reset").methods(crow::HTTPMethod::PATCH)
        ([&](const crow::request& req, const std::string& employeeUUID)
         {
         AUTH_INIT(PERMISSIONS::INFORMATION_TECHNOLOGY, SUB_PERMISSIONS::CHANGE_PASSWORD)
         soci::session db(pool);
         std::string tempName;
         try
         {
            db << GET_EMPLOYEE_NAME, soci::into(tempName), soci::use(employeeUUID);
         }
         catch(const std::exception& e)
         {
            CHECK_DATABASE_DISCONNECTION
            std::cerr << "DATABASE ERROR(/users/<string>/employee/password-reset): " << e.what() << '\n';
            std::cerr << "<string> value: " << employeeUUID << '\n';
            return crow::response(500, "database error");
         }
         if(tempName.empty())
            return crow::response(404, "not found");
         std::string newSalt, newPassword, newHash;
         newSalt = GetRandomSalt(SALT_LENGTH);
         newPassword = GetRandomSalt(10);
         newHash = GetSHA256Digest(newPassword + newSalt);
         try
         {
            db << FORCE_UPDATE_PASSWORD_QUERY, soci::use(newSalt), soci::use(newHash), soci::use(employeeUUID); 
         }
         catch(const std::exception& e)
         {
            CHECK_DATABASE_DISCONNECTION
            std::cerr << "DATABASE ERROR(/users/<string>/employee/password-reset): " << e.what() << '\n';
            std::cerr << "<string> value: " << employeeUUID << '\n';
            return crow::response(500, "database error");
         }
         return crow::response(200, "password successfully updated: " + newPassword);
         });

    CROW_ROUTE(app, "/tasks/<int>/complete").methods(crow::HTTPMethod::PATCH)
        ([&](const crow::request& req, const int taskID)
         {
         AUTH_INIT(PERMISSIONS::NONE_PERM, SUB_PERMISSIONS::NONE_SUBPERM)
         try
         {
            soci::session db(pool);
            std::string assignedEmployee;
            soci::indicator assignedEmployeeInd;
            db << GET_TASK_ASSIGNEE_QUERY, soci::into(assignedEmployee, assignedEmployeeInd),
            soci::use(taskID);
            if(assignedEmployeeInd == NULL_INDICATOR)
                return crow::response(404, "not found");
            if(assignedEmployee != tokenInfo.GetUUID())
                return crow::response(403, "forbidden");
            //If the task exists AND we were assigned the task, then we shall now mark it as
            //complete by giving it a completion date
            //Now, we need to get the current time
            const std::chrono::time_point now = std::chrono::system_clock::now();
            std::time_t now_C_style = std::chrono::system_clock::to_time_t(now);
            std::tm* finalTm = std::localtime(&now_C_style);
            
            db << COMPLETE_TASK_QUERY, soci::use(*finalTm), soci::use(taskID);
         }
         catch(const std::exception& e)
         {
            CHECK_DATABASE_DISCONNECTION
            std::cerr << "DATABASE ERROR (/tasks/<int>/complete): " << e.what() << '\n';
            std::cerr << "<int> value: " << taskID << '\n';
            return crow::response(500, "database error");
         }
         return crow::response(200, "task marked as completed successfully");
         });
}
