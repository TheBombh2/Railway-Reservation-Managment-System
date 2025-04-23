#include <soci/session.h>
#include "authorization.h"
#include "crow/common.h"
#include "crow/json.h"
#include "crypto.h"

void AddGETRequests(crow::SimpleApp &app, soci::session& db)
{
  CROW_ROUTE(app, "/")([](const crow::request& req)
      {
        return "Hello, World!";
      });

  //Utility Section
  CROW_ROUTE(app, "/utility/salt").methods(crow::HTTPMethod::GET)
    ([](const crow::request& req)
     {
        std::string salt = GetRandomSalt(SALT_LENGTH);
        if(salt.empty())
          return crow::response(500);
        return crow::response(200, salt);
     });
}

void AddPOSTRequest(crow::SimpleApp &app, soci::session &db)
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
      std::string ID = body["ID"].s();

      db << CREATE_CUSTOMER_QUERY_BASIC_INFO, soci::use(ID), soci::use(firstName), soci::use(middleName), 
      soci::use(lastName), soci::use(gender);
      db << CREATE_CUSTOMER_QUERY_CONTACT_INFO, soci::use(ID, "ID"), soci::use(email, "Email")
      ,soci::use(phoneNumber, "PhoneNumber");
      db << CREATE_CUSTOMER_QUERY_SECURITY_INFO, soci::use(ID, "ID"), soci::use(passwordHash, "PasswordHash"),
      soci::use(passwordSalt, "PasswordSalt");

      return crow::response(201, "customer user created succesfully");
   });
}
