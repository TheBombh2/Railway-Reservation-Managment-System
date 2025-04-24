#pragma once
#include <soci/soci.h>
#include <soci/mysql/soci-mysql.h>
#include <soci/connection-pool.h>
#include <soci/transaction.h>
#include "global_variables.h"

inline std::string connectionString;
void InitializeConnectionString();
void InitializeConnectionPool();
inline soci::connection_pool pool(THREADS_NUMBER);
