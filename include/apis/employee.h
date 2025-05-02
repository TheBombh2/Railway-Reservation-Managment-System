#pragma once
#include "crow/app.h"
#include "middleware.h"

void AddEmployeeGETRequests(crow::App<AUTH_MIDDLEWARE>& app);
void AddEmployeePOSTRequests(crow::App<AUTH_MIDDLEWARE>& app);
void AddEmployeeDELETERequests(crow::App<AUTH_MIDDLEWARE>& app);

const inline unsigned short MAX_DEPARTMENTS_RETURNED = 255;
const inline unsigned short MAX_APPRAISALS_RETURNED = 255;
const inline unsigned short MAX_CITATIONS_RETURNED = 255;

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

const inline std::string CREATE_APPRAISAL_QUERY = 
"INSERT INTO EmployeeAppraisal "
"(Title, Description, SalaryImprovement, "
"AssignedEmployee, CreatedEmployee) "
"VALUES (:Title, :Description, :SalaryImprovement, :AssignedEmployee, :CreatedEmployee);";

const inline std::string CREATE_CITATION_QUERY = 
"INSERT INTO EmployeeCitation "
"(Title, Description, SalaryDeduction, "
"AssignedEmployee, CreatedEmployee) "
"VALUES (:Title, :Description, :SalaryDeduction, :AssignedEmployee, :CreatedEmployee);";

//To-Do: Add manager ID and name!
const inline std::string GET_DEPARTMENTS_QUERY =
"SELECT Title, Description, Location FROM Department";

const inline std::string GET_JOB_INFO_QUERY = 
"SELECT Title, Description FROM Job WHERE JobID=:ID;";

const inline std::string GET_EMPLOYEE_SALT_QUERY =
"SELECT PasswordSalt FROM EmployeeSecurityInformation WHERE ID=:ID;";

const inline std::string GET_APPRAISALS_QUERY = 
"SELECT Title, Description, IssueDate, SalaryImprovement, EBI.FirstName AS ManagerFirstName, EBI.LastName AS ManagerLastName FROM EmployeeAppraisal EA "
"JOIN EmployeeBasicInformation EBI ON EBI.EmployeeID = EA.CreatedEmployee "
"WHERE EA.AssignedEmployee = :ID; ";

const inline std::string GET_CITATIONS_QUERY = 
"SELECT Title, Description, IssueDate, SalaryDeduction, EBI.FirstName AS ManagerFirstName, EBI.LastName AS ManagerLastName FROM EmployeeCitation EA "
"JOIN EmployeeBasicInformation EBI ON EBI.EmployeeID = EA.CreatedEmployee "
"WHERE EA.AssignedEmployee = :ID; ";
