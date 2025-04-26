#include <unistd.h>
#include <filesystem>
#include <iostream>
#include "middleware.h"
#include "crow/app.h"
#include "global_variables.h"
#include "misc_functions.h"
#include "database_connector.h"
#include "employee.h"

int main(int argc, char** argv)
{
  if(setuid(getuid()) != 0)
  {
    std::cerr << "ERROR: failed to set effective uid. This means the authorization module won't be able to write its own data in its own directory!. Aborting program...\n";
    return -1;
  }

  if(!std::filesystem::exists(SECRETS_LOCATION))
  {
    std::cout << "secrets.yaml was not found and has been recreated. Please make sure it contains accurate values. The program will now terminate\n";
    WriteInitialSecretsFile();
    return -2;
  }

  InitializeConnectionStrings();
  InitializeConnectionPool();
  InitializeRedisString();
  InitializeAuthURL();
  dbRedis = new redis::Redis(redisConnectionOptions, redisPoolOptions);
  YAML::Node root = LoadSecretsFile();

  crow::App<AUTH_MIDDLEWARE> employeeApp;
  AddEmployeeGETRequests(employeeApp); 
  AddEmployeePOSTRequests(employeeApp);
  AddEmployeeDELETERequests(employeeApp);

    unsigned short portNum = root["services"]["EMPLOYEE_PORT_NUMBER"].as<unsigned short>();
  employeeApp.multithreaded().port(portNum).run();
  return 0;
}
