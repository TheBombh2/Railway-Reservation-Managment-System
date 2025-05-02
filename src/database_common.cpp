#include "authorization.h"
#include "database_connector.h"
#include <soci/into.h>
#include <soci/soci-backend.h>
#include "database_common.h"

std::string GetCustomerUUID(const std::string& email)
{
    soci::session db(pool);
    std::string uuid;
    db << GET_CUSTOMER_UUID_QUERY, soci::use(email), soci::into(uuid);
    return uuid;
}

std::string GetEmployeeUUID(const std::string &email)
{
    soci::session db(pool);
    std::string uuid;
    db << GET_EMPLOYEE_UUID_QUERY, soci::use(email), soci::into(uuid);
    return uuid;
}

std::string GetEmployeeManagerUUID(const std::string& uuid)
{
    //"0" means null UUID
    soci::session db(pool);
    soci::indicator ind;
    std::string result;
    db << GET_EMPLOYEE_MANAGER_UUID_QUERY, soci::use(uuid, ind), soci::into(result);
    if(ind != soci::indicator::i_ok)
        return "0";
    return result;
}

std::pair<uint8_t, uint8_t> GetEmployeePermissions(const std::string& uuid)
{
    soci::session db(pool);
    uint8_t perm;
    uint8_t subPerm;
    soci::indicator permInd; 
    soci::indicator subPermInd;
    //No permissions can be returned if there is an error with the UUID or if the employee does not
    //have an associated department. We will now handle this case 
    db << GET_EMPLOYEE_PERMISSIONS_QUERY, soci::use(uuid), soci::into(perm, permInd), soci::into(subPerm, subPermInd);
    if(permInd == NULL_INDICATOR) perm = 0;
    if(subPermInd == NULL_INDICATOR) subPerm = 0;
    return std::make_pair(perm, subPerm);

}
