#pragma once
#include <string>

const inline std::string GET_CUSTOMER_UUID_QUERY =
"SELECT ID FROM CustomerContactInformation WHERE Email=:Email;";

std::string GetCustomerUUID(const std::string& email);

