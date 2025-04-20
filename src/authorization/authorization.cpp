#include <filesystem>
#include <iostream>
#include <unistd.h>
#include "authorization.h"
#include "crow/app.h"
#include "global_variables.h"
#include "misc_functions.h"

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
  
  YAML::Node root = LoadSecretsFile();
  crow::SimpleApp authorizationApp;

  AddGETRequests(authorizationApp); 

  unsigned short portNum = root["services"]["AUTHORIZATION_PORT_NUMBER"].as<unsigned short>();
  authorizationApp.multithreaded().port(portNum).run();
}
