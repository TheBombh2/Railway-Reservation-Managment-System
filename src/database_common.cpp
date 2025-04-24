#include "database_connector.h"
#include "database_common.h"

std::string GetCustomerUUID(const std::string& email)
{
    soci::session db(pool);
    soci::indicator ind;
    std::string uuid;
    db << GET_CUSTOMER_UUID_QUERY, soci::use(email), soci::into(uuid, ind);
    return uuid;
}
