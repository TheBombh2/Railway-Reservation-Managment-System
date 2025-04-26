#include <yaml-cpp/yaml.h>
#include "middleware.h"
#include "misc_functions.h"

void InitializeAuthURL()
{
    YAML::Node root = LoadSecretsFile();
    std::string possibleIP = root["services"]["AUTHORIZATION_IP"].as<std::string>();
    unsigned short portNum = root["services"]["AUTHORIZATION_PORT_NUMBER"].as<unsigned short>();
    bool result = std::regex_match(possibleIP, IPv4Regex);
    bool useSSL = root["services"]["AUTHORIZATION_USE_SSL"].as<bool>();
    if(result)
    {
        std::string url;
        if(useSSL)
            url += "https://";
        else 
            url += "http://";
        url += possibleIP + ':';
        url += std::to_string(portNum);
        authServiceURL = url;
    }
    else
    {
        //This means the IP address section contained what we can only assume to be a valid URL.
        authServiceURL = possibleIP + ':' + std::to_string(portNum);
    }
}
