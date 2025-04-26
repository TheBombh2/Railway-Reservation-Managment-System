#pragma once
#include "crow/app.h"

void AddEmployeeGETRequests(crow::SimpleApp& app);
void AddEmployeePOSTRequests(crow::SimpleApp& app);
void AddEmployeeDELETERequests(crow::SimpleApp& app);

const inline std::string CREATE_JOB_QUERY =
"INSERT INTO Job (JobID, Title, Description) VALUES (:ID, :Title, :Description);";
