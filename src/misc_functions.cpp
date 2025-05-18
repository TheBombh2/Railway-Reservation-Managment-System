#include <chrono>
#include <filesystem>
#include <iostream>
#include <stdexcept>
#include <yaml-cpp/yaml.h>
#include <initializer_list>
#include <fstream>
#include "misc_functions.h"
#include "date.h"
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

  database["DB_IP"] = "127.0.0.1";
  database["DB_PORT"] = 3306;
  database["DB_NAME"] = "";
  database["DB_USER"] = "";
  database["DB_PASSWORD"] = "";
  database["DB_SSL_CERT"] = "";
  database["REDIS_IP"] = "";
  database["REDIS_PORT"] = 6379;
  database["REDIS_PASSWORD"] = "";

  application["DB_LOG_LOCATION"] = "/var/log/rrms/database/";

  services["AUTHORIZATION_PORT_NUMBER"] = 5450;
  services["AUTHORIZATION_IP_ADDRESS"] = "127.0.0.1";
  services["AUTHORIZATION_USE_SSL"] = false;
  services["RESERVATION_PORT_NUMBER"] = 5451;
  services["RESERVATION_IP_ADDRESS"] = "127.0.0.1";
  services["RESERVATION_USE_SSL"] = false;
  services["MANAGEMENT_PORT_NUMBER"] = 5452;
  services["MANAGEMENT_IP_ADDRESS"] = "127.0.0.1";
  services["MANAGEMENT_USE_SSL"] = false;
  services["EMPLOYEE_PORT_NUMBER"] = 5453;
  services["EMPLOYEE_IP_ADDRESS"] = "127.0.0.1";
  services["EMPLOYEE_USE_SSL"] = false;
  services["FINANCIAL_PORT_NUMBER"] = 5454;
  services["FINANCIAL_IP_ADDRESS"] = "127.0.0.1";
  services["FINANCIAL_USE_SSL"] = false;

  root["database"] = database;
  root["application"] = application;
  root["services"] = services;
  
  std::ofstream outputFile(SECRETS_LOCATION);
  outputFile << root;
  outputFile.close();
}

YAML::Node LoadSecretsFile()
{
  YAML::Node root = YAML::LoadFile(SECRETS_LOCATION);
  if(!root)
  {
    std::cerr << "ERROR: Failed to load " << SECRETS_LOCATION << "/secrets.yaml. This is a fatal error. Program will now terminate\n";
    throw std::runtime_error("Failed to load secrets.yaml");
  }
  return root;
}

std::string FormatTimeToString(const std::tm& time)
{
    //A good C developer always allocates a lot more memory than is actually needed just in case ;)
    //That was meant to be a joke but I don't have enough time to think about the theoretical
    //maximum needed
    //Thus, 128 is more than enough!
    char buffer[128];
    strftime(buffer, sizeof(buffer), TIME_FORMAT_STRING, &time);
    return std::string(buffer);
}

std::tm GetEmptyTMObject()
{
    std::tm result;
    result.tm_year = 9999;
    return result;
}

date::sys_time<std::chrono::seconds> LoadTimeFromString(const std::string& input)
{
    std::istringstream iss(input);
    int year, month, day, hour, minute, second;
    char dash1, dash2, colon1, colon2;
    iss >> year >> dash1 >> month >> dash2 >> day >> hour >> colon1 >> minute >> colon2 >> second;
    date::year_month_day ymd{date::year(year), date::month(month), date::day(day)};
    date::sys_time<std::chrono::seconds> result = date::sys_days(ymd);
    result += std::chrono::hours(hour);
    result += std::chrono::minutes(minute);
    result += std::chrono::seconds(second);
    return result;
}
