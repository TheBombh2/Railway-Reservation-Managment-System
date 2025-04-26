#include <cpr/auth.h>
#include <cpr/bearer.h>
#include <cpr/cprtypes.h>
#include <cpr/response.h>
#include <yaml-cpp/yaml.h>
#include <cpr/cpr.h>
#include "middleware.h"
#include "crow/json.h"
#include "misc_functions.h"
#include "tokens.h"

void InitializeAuthURL()
{
    YAML::Node root = LoadSecretsFile();
    std::string possibleIP = root["services"]["AUTHORIZATION_IP_ADDRESS"].as<std::string>();
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

SessionTokenInfo GetSessionTokenInfo(const std::string& authHeader)
{
    std::string sessionToken = authHeader.substr(7);
    cpr::Response r = cpr::Get(cpr::Url(authTokenPath), cpr::Bearer(sessionToken));
    if(r.status_code == 200)
    {
        crow::json::rvalue body = crow::json::load(r.text); 
        return SessionTokenInfo(static_cast<uint8_t>(body["permission"].i())
                                , static_cast<uint8_t>(body["subPermission"].i())
                                , body["uuid"].s());
    }
    else
    {
        return SessionTokenInfo(0,0,"0");
    }
}
