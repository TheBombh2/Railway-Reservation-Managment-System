#include <filesystem>
#include <iostream>
#include <soci/session.h>
#include <unistd.h>
#include <vector>
#include <soci/soci.h>
#include <soci/mysql/soci-mysql.h>
#include "authorization.h"
#include "crow/app.h"
#include "global_variables.h"
#include "misc_functions.h"

int main(int argc, char** argv)
{
  soci::session mariadb(soci::mysql, "db=DatabaseProject user=DatabaseProjectUser password=123456aA# host=192.168.1.7 port=3306");
  std::vector<std::string> names(100);
  const std::string stm = "SELECT Name FROM AdminInformation;";
  mariadb << stm, soci::into(names);
  for(const auto& elm : names)
  {
    std::cout << "Name: " << elm << '\n';
  }

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
  
  YAML::Node root = LoadSecretsFile();
  crow::SimpleApp authorizationApp;

  AddGETRequests(authorizationApp); 

  unsigned short portNum = root["services"]["AUTHORIZATION_PORT_NUMBER"].as<unsigned short>();
  authorizationApp.multithreaded().port(portNum).run();
}
