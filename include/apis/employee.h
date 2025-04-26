#pragma once
#include "crow/app.h"
#include "middleware.h"

void AddEmployeeGETRequests(crow::App<AUTH_MIDDLEWARE>& app);
void AddEmployeePOSTRequests(crow::App<AUTH_MIDDLEWARE>& app);
void AddEmployeeDELETERequests(crow::App<AUTH_MIDDLEWARE>& app);

const inline std::string CREATE_JOB_QUERY =
"INSERT INTO Job (JobID, Title, Description) VALUES (:ID, :Title, :Description);";

const inline std::string CREATE_EMPLOYEE_QUERY =
"INSERT INTO EmployeeBasicInformation "
"(EmployeeID, FirstName, MiddleName, LastName, Gender"
"Salary, DepartmentID, JobID, ManagerID, ManagerAppointmentDate)"
"VALUES (:ID, :FirstName, :MiddleName, :LastName, :Gender, :Salary"
":DeptID, :JobID, :ManagerID, :ManagerDate)";
;
