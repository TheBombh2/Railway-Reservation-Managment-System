#pragma once
#include <cstdint>
#include <utility>
#include <string>

const inline std::string GET_CUSTOMER_UUID_QUERY =
"SELECT ID FROM CustomerContactInformation WHERE Email=:Email;";

const inline std::string GET_EMPLOYEE_UUID_QUERY =
"SELECT ID FROM EmployeeContactInformation WHERE Email=:Email;";

const inline std::string GET_EMPLOYEE_PERMISSIONS_QUERY =
"SELECT Permission, SubPermission FROM EmployeeBasicInformation EI "
"JOIN Department DP ON EI.DepartmentID=DP.DepartmentID "
"WHERE EmployeeID=:ID; ";

std::string GetCustomerUUID(const std::string& email);
std::string GetEmployeeUUID(const std::string& email);
std::pair<uint8_t, uint8_t> GetEmployeePermissions(const std::string& uuid);

