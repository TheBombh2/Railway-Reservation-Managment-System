#pragma once
#include <soci/session.h>
#include <soci/soci.h>
#include "crow/app.h"

void AddGETRequests(crow::SimpleApp& app);
void AddPOSTRequests(crow::SimpleApp& app);
void AddDELETERequests(crow::SimpleApp& app);

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
"DELETE FROM CustomerSecurityInformation WHERE ID=:ID";

const inline std::string SELECT_CUSTOMER_PASSWORD_SALT_QUERY = 
"SELECT PasswordSalt FROM CustomerSecurityInformation WHERE ID=:ID;";
