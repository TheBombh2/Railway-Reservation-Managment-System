#pragma once
#include <soci/soci.h>
#include <soci/mysql/soci-mysql.h>
#include <soci/connection-pool.h>
#include <soci/transaction.h>
#include <sw/redis++/connection.h>
#include <sw/redis++/connection_pool.h>
#include <sw/redis++/redis++.h>
#include "global_variables.h"

using namespace sw;

inline std::string connectionString;
inline std::string redisString;
void InitializeConnectionStrings();
void InitializeConnectionPool();
void InitializeRedisString();
inline redis::ConnectionOptions redisConnectionOptions;
inline redis::ConnectionPoolOptions redisPoolOptions;
inline soci::connection_pool pool(THREADS_NUMBER);
