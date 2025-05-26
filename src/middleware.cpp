#include <cpr/auth.h>
#include <cpr/bearer.h>
#include <cpr/cprtypes.h>
#include <cpr/response.h>
#include <cpr/session.h>
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

SessionTokenInfo GetSessionTokenInfo(const std::string& token)
{
    cpr::Response r = cpr::Get(cpr::Url(authServiceURL +  authTokenPath), cpr::Bearer(token));
    if(r.status_code == 200)
    {
        crow::json::rvalue body = crow::json::load(r.text); 
        return SessionTokenInfo(static_cast<uint8_t>(body["permission"].i())
                                , body["subPermission"].s()
                                , body["uuid"].s());
        }
    else
    {
        std::cerr << "auth service returned code: " << r.status_code << '\n';
        return SessionTokenInfo(0,"0 0 0 0 0 0 0 0","0");
    }
}


void AUTH_MIDDLEWARE::before_handle(crow::request& req, crow::response& res, context& ctx)
{
    std::string authHeader = req.get_header_value("Authorization");
    if(authHeader.length() < 7)
    {
        res.code = 401;
        res.body = "no authorization";
        res.end();
        return;
    }
    std::string token = authHeader.substr(7);
    SessionTokenInfo tokenInfo = GetSessionTokenInfo(token);
    if(tokenInfo.GetUUID() == "0")
    {
        res.code = 403;
        res.body = "invalid session token";
        std::cerr << "Session token UUID: " << tokenInfo.GetUUID() << '\n';
        res.end();
        return;
    }
    ctx.token = token;
    ctx.tokenInfo = tokenInfo;
}

void AUTH_MIDDLEWARE::after_handle(crow::request& req, crow::response& res, context& ctx)
{
    //no-op
}
