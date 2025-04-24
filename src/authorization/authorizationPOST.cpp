#include "crow/common.h"
#include "database_common.h"
#include "database_connector.h"
#include "authorization.h"
#include "tokens.h"
#include "crypto.h"

void AddPOSTRequests(crow::SimpleApp &app)
{
  CROW_ROUTE(app, "/users/create/customer").methods(crow::HTTPMethod::POST)
  ([&](const crow::request& req)
   {
      const auto body = crow::json::load(req.body);
      std::string firstName = body["firstName"].s();
      std::string middleName = body["middleName"].s();
      std::string lastName = body["lastName"].s();
      std::string gender = body["gender"].s();

      std::string phoneNumber = body["phoneNumber"].s();
      std::string email = body["email"].s();
      
      std::string passwordHash = body["passwordHash"].s();
      std::string passwordSalt = body["passwordSalt"].s();
      std::string ID = GetUUIDv7();
      
      soci::session db(pool);
      soci::transaction trans(db);
      db << CREATE_CUSTOMER_QUERY_BASIC_INFO, soci::use(ID), soci::use(firstName), soci::use(middleName), 
      soci::use(lastName), soci::use(gender);
      db << CREATE_CUSTOMER_QUERY_CONTACT_INFO, soci::use(ID, "ID"), soci::use(email, "Email")
      ,soci::use(phoneNumber, "PhoneNumber");
      db << CREATE_CUSTOMER_QUERY_SECURITY_INFO, soci::use(ID, "ID"), soci::use(passwordHash, "PasswordHash"),
      soci::use(passwordSalt, "PasswordSalt");
      trans.commit();

      return crow::response(201, "customer user created successfully");
   });

    CROW_ROUTE(app, "/login").methods(crow::HTTPMethod::POST)
    ([](const crow::request& req)
     {
        auto body = crow::json::load(req.body);
        std::string email = body["email"].s();
        std::string passwordHashRequest = body["passwordHash"].s();
        soci::session db(pool);
        std::string uuid = GetCustomerUUID(email);
        if(uuid.empty())
        {
            return crow::response(404, "user not found");
        }
        std::string passwordHashDB;
        db << GET_CUSTOMER_PASSWORD_HASH, soci::use(uuid), soci::into(passwordHashDB);
        if(passwordHashRequest != passwordHashDB)
            return crow::response(404, "authentication failure");

        std::string tokenNum = GetUUIDv4();
        SessionTokenInfo tokenInfo = SessionTokenInfo(0, 0, uuid);
        dbRedis->set(tokenNum, tokenInfo.GetData());
        return crow::response(201, tokenNum);
     });

   
}
