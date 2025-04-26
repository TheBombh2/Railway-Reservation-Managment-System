#pragma once
#include <soci/session.h>
#include <soci/soci.h>
#include <sw/redis++/redis.h>
#include "crow/app.h"
#include "database_connector.h"

void AddAuthorizationGETRequests(crow::App<>& app);
void AddAuthorizationPOSTRequests(crow::SimpleApp& app);
void AddAuthorizationDELETERequests(crow::SimpleApp& app);

const inline std::string CREATE_CUSTOMER_QUERY_BASIC_INFO = 
"INSERT INTO CustomerBasicInformation "
"(ID, FirstName, MiddleName, LastName, Gender) "
"VALUES " 
"(:ID, :FirstName, :MiddleName, :LastName, :Gender);";

const inline std::string CREATE_CUSTOMER_QUERY_SECURITY_INFO = 
"INSERT INTO CustomerSecurityInformation "
"(ID, PasswordSalt, PasswordHash) "
"VALUES "
"(:ID, :PasswordSalt, :PasswordHash);";

const inline std::string CREATE_CUSTOMER_QUERY_CONTACT_INFO =
"INSERT INTO CustomerContactInformation "
"(ID, Email, PhoneNumber) "
"VALUES "
"(:ID, :Email, :PhoneNumber);";

const inline std::string DELETE_CUSTOMER_QUERY_BASIC_INFO = 
"DELETE FROM CustomerBasicInformation WHERE ID=:ID;";

const inline std::string DELETE_CUSTOMER_QUERY_CONTACT_INFO =
"DELETE FROM CustomerContactInformation WHERE ID=:ID;";

const inline std::string DELETE_CUSTOMER_QUERY_SECURITY_INFO =
"DELETE FROM CustomerSecurityInformation WHERE ID=:ID;";

//WARNING:: THIS QUERY IS NOT OPTIMIZED. IT IS O(N).
const inline std::string DELETE_CUSTOMER_SEAT_RESERVATION = 
"DELETE FROM CustomerSeatReservation WHERE CustomerID=:ID";

const inline std::string DELETE_CUSTOMER_PREVIOUS_PASSWORDS = 
"DELETE FROM CustomerPreviousPasswords WHERE ID=:ID;";

const inline std::string SELECT_CUSTOMER_PASSWORD_SALT_QUERY = 
"SELECT PasswordSalt FROM CustomerSecurityInformation WHERE ID=:ID;";

const inline std::string GET_CUSTOMER_PASSWORD_HASH =
"SELECT PasswordHash FROM CustomerSecurityInformation WHERE ID=:ID";
