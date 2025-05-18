#include <chrono>
#include <format>
#include <iostream>
#include <soci/mysql/soci-mysql.h>
#include <soci/session.h>
#include <sw/redis++/errors.h>
#include <sw/redis++/utils.h>
#include "global_variables.h"
#include "misc_functions.h"
#include "database_connector.h"

//One could make the argument to make sure that those values exist in the first place
//I agree. I should also check if they are initialized but not now. 
//Host is the only optional parameter from secrets.yaml
void InitializeConnectionStrings()
{
  YAML::Node root = LoadSecretsFile();
  std::string dbName = root["database"]["DB_NAME"].as<std::string>();
  std::string dbUser = root["database"]["DB_USER"].as<std::string>();
  std::string dbPassword = root["database"]["DB_PASSWORD"].as<std::string>();
  std::string dbIP = root["database"]["DB_IP"].as<std::string>();
  unsigned short dbPort = 0;
  dbPort = root["database"]["DB_PORT"].as<unsigned short>();
  if(dbName.empty() || dbUser.empty() || dbPassword.empty() || dbPort == 0)
  {
    std::cerr << SECRETS_LOCATION << " does not contain either a MariaDB/MySQL database name, username, password, or port number. Please revise those values";
    return;
  }
  
  if(dbIP.empty())
  {
    connectionString = std::format(
    "db={} "
    "user={} "
    "password={} "
    "host=127.0.0.1 "
    "port={} ",
    dbName, dbUser, dbPassword, dbIP, dbPort
    );  
    return;
  }

  connectionString = std::format(
      "db={} "
      "user={} "
      "password={} "
      "host={} "
      "port={} ",
      dbName, dbUser, dbPassword, dbIP, dbPort
      );
  std::cout << "Sizeof soci session: " << sizeof(soci::session) << '\n';
  //dbConnector = soci::session(soci::mysql, connectionString);
}

void InitializeRedisString()
{
  YAML::Node root = LoadSecretsFile();
  std::string redisIP = root["database"]["REDIS_IP"].as<std::string>();
  std::string redisPassword = root["database"]["REDIS_PASSWORD"].as<std::string>();
  unsigned short redisPort = 0;
  redisPort = root["database"]["REDIS_PORT"].as<unsigned short>();
  
  if(redisIP.empty())
    redisConnectionOptions.host = "127.0.0.1";
  redisConnectionOptions.host = redisIP;
  redisConnectionOptions.password = redisPassword;
  redisConnectionOptions.port = redisPort;
  redisConnectionOptions.socket_timeout = std::chrono::milliseconds(600);
  redisConnectionOptions.connect_timeout = std::chrono::milliseconds(600);
  redisConnectionOptions.db = 0;
  redisPoolOptions.size = THREADS_NUMBER;
  redisPoolOptions.wait_timeout = std::chrono::milliseconds(600);
  redisPoolOptions.connection_lifetime = std::chrono::minutes(10);
  std::cout << "Size of redis object: " << sizeof(redis::Redis) << '\n';
  std::cout << "HOST: " << redisIP << '\n';
  std::cout << "Redis Pool size: " << redisPoolOptions.size << '\n';
}

void InitializeConnectionPool()
{
  for(unsigned int i = 0; i < THREADS_NUMBER; i++)
  {
    soci::session& temp = pool.at(i);
    temp.open(soci::mysql, connectionString);
  }
}

void ReconnectEntireConnectionPool()
{
    //I think this will work but will need further testing to prove so
    //I currently don't have enough time
    for(unsigned int i = 0; i < THREADS_NUMBER; i++)
    {
        std::lock_guard<std::mutex> lock(poolMutex);
        soci::session& temp = pool.at(i);
        temp.reconnect();
    }
}
redis::OptionalString RedisGetValue(const std::string& key)
{
    redis::OptionalString result;
    int retries = 0;
    while(true)
    {
        try
        {
            result = dbRedis->get(key);
            break;
        }
        catch(const redis::TimeoutError& te)
        {
            if(retries == MAX_REDIS_RETRIES)
            {
                std::cerr << "REDIS ERROR: REDIS RETRIES EXCEEDED\n";
                return "";
            }
            std::cerr << "REDIS TIMEOUT ERROR: Due to unknown black magic reasons, the connection has timed out. We will try again until it succeeds. In the meantime, please check your network!\n";
            std::cerr << te.what() << '\n';
            retries++;
            continue;
        }
    }
    return result;
}
