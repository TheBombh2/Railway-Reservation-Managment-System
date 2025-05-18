#include "crow/common.h"
#include "database_common.h"
#include "database_connector.h"
#include "authorization.h"
#include "tokens.h"
#include "crypto.h"

void AddAuthorizationPOSTRequests(crow::SimpleApp &app)
{
    CROW_ROUTE(app, "/login/customer").methods(crow::HTTPMethod::POST)
    ([](const crow::request& req)
     {
        auto body = crow::json::load(req.body);
        std::string email, passwordHashRequest;
        try
        {
            email = body["email"].s();
            passwordHashRequest = body["passwordHash"].s();
        }
        catch(const std::exception& e)
        {
            std::cerr << "JSON ERROR (/login/customer): " << e.what() << '\n';
            return crow::response(400, "bad request");
        } 
        
        std::string uuid = GetCustomerUUID(email);
        if(uuid.empty())
        {
            return crow::response(404, "user not found");
        }
        std::string passwordHashDB;

        try
        {
            soci::session db(pool);
            db << GET_CUSTOMER_PASSWORD_HASH, soci::use(uuid), soci::into(passwordHashDB);
        }
        catch(const std::exception& e)
        {
            CHECK_DATABASE_DISCONNECTION
            std::cerr << "DATABASE ERROR (/login/customer): " << e.what() << '\n';
            return crow::response(500, "database error");
        }
        if(passwordHashRequest != passwordHashDB)
            return crow::response(404, "authentication failure");

        std::string tokenNum = GetUUIDv4();
        SessionTokenInfo tokenInfo = SessionTokenInfo(0, "0 0 0 0 0 0 0 0", uuid);
        dbRedis->set(tokenNum, tokenInfo.GetData());
        return crow::response(201, tokenNum);
     });

    CROW_ROUTE(app, "/login/employee").methods(crow::HTTPMethod::POST)
        ([](const crow::request& req)
         {
         const crow::json::rvalue body = crow::json::load(req.body);
         std::string email, passwordHashRequest;
         try
         {
            email = body["email"].s();
            passwordHashRequest = body["passwordHash"].s();
         }
         catch(const std::exception& e)
         {
            std::cerr << "JSON ERROR (bad request) (/login/employee):" << e.what() << '\n';
            return crow::response(400, "bad request");
         }
         soci::session db(pool);
         std::string uuid = GetEmployeeUUID(email);
         std::string hashDatabase;
         if(uuid.empty())
            return crow::response(404, "user not found");

         try
         {
            db << GET_EMPLOYEE_PASSWORD_HASH, soci::use(uuid), soci::into(hashDatabase);
         }
         catch(const std::exception& e)
         {
            CHECK_DATABASE_DISCONNECTION
            std::cerr << "DATABASE ERROR (/login/employee): " << e.what() << '\n';
            return crow::response(500, "database error");
         }
         
         if(hashDatabase != passwordHashRequest)
            return crow::response(401, "authentication failure");

         //Get Employee Permissions from their respective department
         std::pair<uint8_t, unsigned long long> perms = GetEmployeePermissions(uuid);
         std::string token = GetUUIDv4();
         std::string tokenInfo;
         tokenInfo += std::to_string(perms.first) + ' ';
         uint8_t* permsPointer = reinterpret_cast<uint8_t*>(&perms.second);
         for(int i = 0; i < 8; i++)
            tokenInfo += std::to_string(permsPointer[i]) + ' ';
         tokenInfo += uuid;
         dbRedis->set(token, tokenInfo);
         return crow::response(201, token);
         });

   
}
