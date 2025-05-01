#pragma once
#include <soci/soci-backend.h>
#include <soci/soci.h>
#include <soci/mysql/soci-mysql.h>
#include <soci/connection-pool.h>
#include <soci/transaction.h>
#include <sw/redis++/connection.h>
#include <sw/redis++/connection_pool.h>
#include <sw/redis++/redis++.h>
#include <sw/redis++/utils.h>
#include "global_variables.h"

using namespace sw;

//Pointer for deferred initialization
inline redis::Redis* dbRedis;
inline std::string connectionString;
inline std::string redisString;
void InitializeConnectionStrings();
void InitializeConnectionPool();
void InitializeRedisString();
inline redis::ConnectionOptions redisConnectionOptions;
inline redis::ConnectionPoolOptions redisPoolOptions;
inline soci::connection_pool pool(THREADS_NUMBER * 1.5);

inline soci::indicator NULL_INDICATOR = soci::indicator::i_null;
inline soci::indicator OK_INDICATOR = soci::indicator::i_ok;

//Maybe we need another one for setting the value?
//Ah well, maybe in the future! I am on a tight schedule now
redis::OptionalString RedisGetValue(const std::string& key);
