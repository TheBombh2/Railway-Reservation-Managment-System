#include <format>
#include <iostream>
#include "global_variables.h"
#include "misc_functions.h"
#include "database_connector.h"

//One could make the argument to make sure that those values exist in the first place
//I agree. I should also check if they are initialized but not now. 
//Host is the only optional parameter
void InitializeConnector()
{
  YAML::Node root = LoadSecretsFile();
  std::string dbName = root["database"]["DB_NAME"].as<std::string>();
  std::string dbUser = root["database"]["DB_USER"].as<std::string>();
  std::string dbPassword = root["database"]["DB_PASSWORD"].as<std::string>();
  std::string dbHost = root["database"]["DB_HOST"].as<std::string>();
  unsigned short dbPort = 0;
  dbPort = root["database"]["DB_PORT"].as<unsigned short>();

  if(dbName.empty() || dbUser.empty() || dbPassword.empty() || dbPort == 0)
  {
    std::cerr << SECRETS_LOCATION << " does not contain either a database name, username, password, or port number. Please revise those values";
    return;
  }

  if(dbHost.empty())
  {
    connectionString = std::format(
    "db={} "
    "user={} "
    "password={} "
    "host=127.0.0.1 "
    "port={} ",
    dbName, dbUser, dbPassword, dbHost, dbPort
    );  
    return;
  }

  connectionString = std::format(
      "db={} "
      "user={} "
      "password={} "
      "host={} "
      "port={} ",
      dbName, dbUser, dbPassword, dbHost, dbPort
      );  
}

