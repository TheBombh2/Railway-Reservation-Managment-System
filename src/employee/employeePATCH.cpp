#include "crypto.h"
#include "crow/common.h"
#include "employee.h"
#include "middleware.h"
#include "database_connector.h"

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
            std::cerr << "DATABASE ERROR(/users/<string>/employee/password-reset): " << e.what() << '\n';
            std::cerr << "<string> value: " << employeeUUID << '\n';
            return crow::response(500, "database error");
         }
         return crow::response(200, "password successfully updated: " + newPassword);
         });
}
