#include <exception>
#include <iostream>
#include "database_connector.h"
#include "database_common.h"

std::string GetCustomerUUID(const std::string& email)
{
    soci::session db(pool);
    std::string uuid;
    try
    {
        db << GET_CUSTOMER_UUID_QUERY, soci::use(email), soci::into(uuid);
    }
    catch(const std::exception& e)
    {
        std::cerr << "DATABASE ERROR (GetCustomerUUID(const std::string& email)): " << e.what() << '\n';
        std::cerr << "email: " << email << '\n';
        return "";
    }
    return uuid;
}

std::string GetEmployeeUUID(const std::string &email)
{
    soci::session db(pool);
    std::string uuid;
    try
    {
        db << GET_EMPLOYEE_UUID_QUERY, soci::use(email), soci::into(uuid);
    }
    catch (const std::exception& e)
    {
        std::cerr << "DATABASE ERROR (GetEmployeeUUID(const std::string& email)): " << e.what() << '\n';
        std::cerr << "email: " << email << '\n';
        return "";
    }
    return uuid;
}

std::string GetEmployeeManagerUUID(const std::string& uuid)
{
    //"0" means null UUID
    soci::session db(pool);
    soci::indicator ind;
    std::string result;
    try
    {
        db << GET_EMPLOYEE_MANAGER_UUID_QUERY, soci::use(uuid), soci::into(result, ind);
    }
    catch(const std::exception& e)
    {
        std::cerr << "DATABASE ERROR (GetEmployeeMangerUUID(const std::string& uuid)): " << e.what() << '\n';
        std::cerr << "uuid: " << uuid << '\n';
        return "0";
    }
    if(ind != soci::indicator::i_ok)
        return "0";
    return result;
}

std::pair<uint8_t, unsigned long long> GetEmployeePermissions(const std::string& uuid)
{
    soci::session db(pool);
    uint8_t perm;
    unsigned long long subPerm;
    soci::indicator permInd; 
    soci::indicator subPermInd;
    //No permissions can be returned if there is an error with the UUID or if the employee does not
    //have an associated department. We will now handle this case 
    try
    {
        db << GET_EMPLOYEE_PERMISSIONS_QUERY, soci::use(uuid), soci::into(perm, permInd), soci::into(subPerm, subPermInd);
    }
    catch(const std::exception& e)
    {
        std::cerr << "DATABASE ERROR (GetEmployeePermissions(const std::string& uuid)): " << e.what() << '\n';
        std::cerr << "uuid: " << uuid << '\n';
        return std::make_pair(0, 0);
    }
    if(permInd == NULL_INDICATOR) perm = 0;
    if(subPermInd == NULL_INDICATOR) subPerm = 0;
    return std::make_pair(perm, subPerm);

}
