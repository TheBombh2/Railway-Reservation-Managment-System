#include <format>
#include <iostream>
#include <soci/mysql/soci-mysql.h>
#include <soci/session.h>
#include "global_variables.h"
#include "misc_functions.h"
#include "database_connector.h"

//One could make the argument to make sure that those values exist in the first place
//I agree. I should also check if they are initialized but not now. 
//Host is the only optional parameter from secrets.yaml
void InitializeConnectionString()
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
    std::cerr << SECRETS_LOCATION << " does not contain either a database name, username, password, or port number. Please revise those values";
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

void InitializeConnectionPool()
{
  for(unsigned int i = 0; i < THREADS_NUMBER; i++)
  {
    soci::session& temp = pool.at(i);
    temp.open(soci::mysql, connectionString);
  }
}
