#pragma once
#include <soci/soci-backend.h>
#include <soci/soci.h>
#include <soci/mysql/soci-mysql.h>
#include <soci/connection-pool.h>
#include <soci/transaction.h>
#include <sw/redis++/connection.h>
#include <sw/redis++/connection_pool.h>
#include <sw/redis++/redis++.h>
#include <mutex>
#include "global_variables.h"

const inline std::string DATABASE_CONNECTION_ERROR_STRING = 
"WARNING: A DISCONNECTED SESSION HAS BEEN DETECTED. ALL DATABASE CONNECTIONS "
"FOR THIS MICROSERVICE WILL BE RECONNECTED NOW\n";

#define CHECK_DATABASE_DISCONNECTION \
std::string temp = e.what();\
if(temp.find("Server has gone away") != std::string::npos)\
{ \
    std::cerr << DATABASE_CONNECTION_ERROR_STRING;\
    ReconnectEntireConnectionPool();\
} 

using namespace sw;

//Pointer for deferred initialization
inline redis::Redis* dbRedis;
inline std::string connectionString;
inline std::string redisString;
void InitializeConnectionStrings();
void InitializeConnectionPool();
void ReconnectEntireConnectionPool();
void InitializeRedisString();
inline redis::ConnectionOptions redisConnectionOptions;
inline redis::ConnectionPoolOptions redisPoolOptions;
inline std::mutex poolMutex;
inline soci::connection_pool pool(THREADS_NUMBER * 1.5);

inline soci::indicator NULL_INDICATOR = soci::indicator::i_null;
inline soci::indicator OK_INDICATOR = soci::indicator::i_ok;

//Maybe we need another one for setting the value?
//Ah well, maybe in the future! I am on a tight schedule now
redis::OptionalString RedisGetValue(const std::string& key);
const inline int MAX_REDIS_RETRIES = 3;
