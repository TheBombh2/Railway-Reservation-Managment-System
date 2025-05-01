#pragma once
#include "crow/app.h"
#include "middleware.h"

void AddEmployeeGETRequests(crow::App<AUTH_MIDDLEWARE>& app);
void AddEmployeePOSTRequests(crow::App<AUTH_MIDDLEWARE>& app);
void AddEmployeeDELETERequests(crow::App<AUTH_MIDDLEWARE>& app);

const inline unsigned short MAX_DEPARTMENTS_RETURNED = 255;

const inline std::string CREATE_JOB_QUERY =
"INSERT INTO Job (JobID, Title, Description) VALUES (:ID, :Title, :Description);";

const inline std::string CREATE_EMPLOYEE_QUERY =
"INSERT INTO EmployeeBasicInformation "
"(EmployeeID, FirstName, MiddleName, LastName, Gender"
"Salary, DepartmentID, JobID, ManagerID, ManagerAppointmentDate)"
"VALUES (:ID, :FirstName, :MiddleName, :LastName, :Gender, :Salary"
":DeptID, :JobID, :ManagerID, :ManagerDate)";

const inline std::string CREATE_DEPARTMENT_QUERY = 
"INSERT INTO Department "
"(DepartmentID, Title, Description, Location, Permission, SubPermission, "
"ManagerID, ManagerHiringDate) "
"VALUES (:ID, :Title, :Description, :Location, :Perm, :SubPerm, :ManagerID, :ManagerHireDate); ";

//To-Do: Add manager ID and name!
const inline std::string GET_DEPARTMENTS_QUERY =
"SELECT Title, Description, Location FROM Department";
