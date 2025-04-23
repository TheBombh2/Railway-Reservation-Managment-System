#pragma once
#include <soci/session.h>
#include <soci/soci.h>
#include "crow/app.h"

void AddGETRequests(crow::SimpleApp& app, soci::session& db);
void AddPOSTRequest(crow::SimpleApp& app, soci::session& db);

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
