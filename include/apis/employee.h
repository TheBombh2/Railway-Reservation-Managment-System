#pragma once
#include "crow/app.h"
#include "middleware.h"
#include "permissions.h"

void AddEmployeeGETRequests(crow::App<AUTH_MIDDLEWARE>& app);
void AddEmployeePOSTRequests(crow::App<AUTH_MIDDLEWARE>& app);
void AddEmployeeDELETERequests(crow::App<AUTH_MIDDLEWARE>& app);
void AddEmployeePATCHRequests(crow::App<AUTH_MIDDLEWARE>& app);

const inline unsigned short MAX_DEPARTMENTS_RETURNED = 255;
const inline unsigned short MAX_APPRAISALS_RETURNED = 255;
const inline unsigned short MAX_CITATIONS_RETURNED = 255;
const inline unsigned short MAX_TASKS_RETURNED = 64;
const inline unsigned short MAX_EMPLOYEES_RETURNED = 255;

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

const inline std::string CREATE_TASK_QUERY = 
"INSERT INTO Task "
"(Title, Description, Deadline, AssignedEmployee, CreatorEmployee) "
"VALUES (:Title, :Desc, :Deadline, :AssignedEmp, :CreatorEmp); ";

//To-Do: Add manager ID and name!
const inline std::string GET_DEPARTMENTS_QUERY =
"SELECT Title, Description, Location, DepartmentID FROM Department";

const inline std::string GET_DEPARTMENT_TITLE_QUERY =
"SELECT Title FROM Department WHERE DepartmentID = :ID; ";

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

const inline std::string GET_TASKS_QUERY = 
"SELECT Title, Description, Deadline, CompletionDate, EBI.FirstName AS CreatorFirstName, EB"
"I.LastName AS CreatorLastname FROM `Task` T "
"JOIN `EmployeeBasicInformation` EBI ON EBI.`EmployeeID` = T.`CreatorEmployee` "
"WHERE T.`AssignedEmployee` = :ID;";

const inline std::string GET_ALL_IDS_QUERY =
"SELECT DepartmentID, JobID, ManagerID, ManagerAppointmentDate FROM `EmployeeBasicInformation` "
"WHERE EmployeeID = :ID; ";

const inline std::string GET_MANAGER_INFORMATION_QUERY =
"SELECT FirstName, MiddleName, LastName, Gender, J.`Title`, J.`Description` FROM `EmployeeBasicInformation` EBI "
"JOIN `Job` J ON J.`JobID` = EBI.`JobID` "
"WHERE EBI.EmployeeID = :ID;";

const inline std::string GET_DEPARTMENT_INFORMATION_QUERY =
"SELECT Title, Description, Location, ManagerHiringDate,EBI.FirstName, EBI.MiddleName ,EBI.LastName, EBI.Gender FROM `Department` DP "
"JOIN `EmployeeBasicInformation` EBI ON EBI.`EmployeeID` = DP.`ManagerID` "
"WHERE DP.DepartmentID = :ID; ";

const inline std::string GET_EMPLOYEE_INFORMATION_QUERY = 
"SELECT FirstName, MiddleName, LastName, Gender, Salary, PhoneNumber, Email "
"FROM `EmployeeBasicInformation` EBI "
"JOIN `EmployeeContactInformation` ECI ON EBI.`EmployeeID` = ECI.`ID` "
"WHERE EBI.EmployeeID = :ID; ";

const inline std::string GET_ALL_EMPLOYEES_INFORMATION_QUERY =
"SELECT EBI.`FirstName` AS EmployeeFirstName, EBI.`MiddleName` AS EmployeeMiddleName, EBI.`LastName` AS EmployeeLastName, "
"EBI.Gender AS EmployeeGender, EBI.EmployeeID, "
"EBI2.`FirstName` AS ManagerFirstName, EBI2.MiddleName AS ManagerMiddleName, EBI2.LastName AS ManagerLastName, "
"J.Title as JobTitle "
"FROM `EmployeeBasicInformation` EBI "
"JOIN `EmployeeBasicInformation` EBI2 ON EBI.`ManagerID` = EBI2.`EmployeeID` "
"JOIN `Job` J ON J.`JobID` = EBI.`JobID`; ";

const inline std::string GET_EMPLOYEE_NAME = 
"SELECT FirstName FROM EmployeeBasicInformation WHERE EmployeeID = :ID; ";

const inline std::string DELETE_EMPLOYEE_BASIC_INFORMATION = 
"DELETE FROM EmployeeBasicInformation WHERE ID = :ID; ";

const inline std::string DELETE_EMPLOYEE_CONTACT_INFORMATION = 
"DELETE FROM EmployeeContactInformation WHERE ID = :ID";

const inline std::string DELETE_EMPLOYEE_SECURITY_INFORMATION = 
"DELETE FROM EmployeeSecurityInformation WHERE ID = :ID; ";

const inline std::string DELETE_EMPLOYEE_PREVIOUS_PASSWORDS = 
"DELETE FROM EmployeePreviousPasswords WHERE ID = :ID; ";

//These are queries for department deletion
const inline std::string DELETE_DEPARTMENT_QUERY =
"DELETE FROM Department WHERE DepartmentID = :ID; ";

//Warning: O(N) query
const inline std::string SET_EMPLOYEE_MANAGERS_TO_NULL = 
"UPDATE EmployeeBasicInformation SET ManagerID = NULL, ManagerAppointmentDate = NULL "
"WHERE ManagerID = :ID; ";

//Warning: O(N) query
const inline std::string SET_DEPARTMENT_MANGERS_TO_NULL =
"UPDATE Department SET ManagerID = NULL, ManagerHiringDate = NULL "
"WHERE ManagerID = :ID; ";

const inline std::string FORCE_UPDATE_PASSWORD_QUERY = 
"UPDATE `EmployeeSecurityInformation` SET PasswordSalt = :Salt, PasswordHash = :Hash, FirstLogin = 1 "
"WHERE ID = :ID; ";
