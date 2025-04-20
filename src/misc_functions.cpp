#include <filesystem>
#include <iostream>
#include <yaml-cpp/yaml.h>
#include <initializer_list>
#include <fstream>
#include "misc_functions.h"
#include "global_variables.h"

std::string GetExecutableDirectory(char *argvInput)
{
  std::filesystem::path launchPath = std::filesystem::current_path() / std::filesystem::path(argvInput);
  try
  {
    return std::filesystem::canonical(launchPath.parent_path()).string();
  }
  catch(const std::filesystem::filesystem_error& e)
  {
    std::cerr << "ERROR: Failed to determine pwd of running program\n";
    throw;
  }
}

std::string ConcatenatePaths(std::initializer_list<std::string> input)
{
  std::filesystem::path toReturn;
  for(const auto& path : input)
  {
    toReturn /= path;
  }
  return toReturn.string();
}

void WriteInitialSecretsFile()
{
  YAML::Node root;
  YAML::Node database;
  YAML::Node application; 
  YAML::Node services;

  database["DB_IP"] = "";
  database["DB_NAME"] = "";
  database["DB_USER"] = "";
  database["DB_PASSWORD"] = "";
  database["DB_SSL_CERT"] = "";

  application["DB_LOG_LOCATION"] = "/var/log/rrms/database/";

  services["AUTHORIZATION_PORT_NUMBER"] = 5450;
  services["AUTHORIZATION_IP_ADDRESS"] = "127.0.0.1";
  services["RESERVATION_PORT_NUMBER"] = 5451;
  services["AUTHORIZATION_IP_ADDRESS"] = "127.0.0.1";
  services["MANAGEMENT_PORT_NUMBER"] = 5452;
  services["MANAGEMENT_IP_ADDRESS"] = "127.0.0.1";
  services["EMPLOYEE_PORT_NUMBER"] = 5453;
  services["EMPLOYEE_IP_ADDRESS"] = "127.0.0.1";
  services["FINANCIAL_PORT_NUMBER"] = 5454;
  services["FINANCIAL_IP_ADDRESS"] = "127.0.0.1";

  root["database"] = database;
  root["application"] = application;
  root["services"] = services;
  
  std::ofstream outputFile(ConcatenatePaths({PROGRAM_ROOT_DIRECTORY, "secrets.yaml"}));
  outputFile << root;
  outputFile.close();
}

