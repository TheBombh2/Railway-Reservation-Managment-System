#pragma once
#include <soci/soci.h>
#include <soci/mysql/soci-mysql.h>

inline std::string connectionString;
void InitializeConnectionString();
