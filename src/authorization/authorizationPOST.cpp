#include "database_connector.h"
#include "authorization.h"
#include "crypto.h"
#include <soci/transaction.h>

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

      return crow::response(201, "customer user created succesfully");
   });

   
}
