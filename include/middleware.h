#pragma once
#include <string>
#include <regex>
#include "permissions.h"
#include "crow/crow.h"
#include "tokens.h"

#define AUTH_INIT(perm, subPerm) \
auto& ctx = app.get_context<AUTH_MIDDLEWARE>(req); \
SessionTokenInfo& tokenInfo = ctx.tokenInfo; \
if(tokenInfo.HasPermission(perm) == false && tokenInfo.HasSubPermission(subPerm) == false) \
return crow::response(403, "forbidden");

inline std::string authServiceURL;
const inline std::string authTokenPath = "/users/token-info";
//Yes, this looks very ugly. Thank you for pointing that out
const inline std::regex IPv4Regex("(([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])");
const inline std::regex IPv6Regex("((([0-9a-fA-F]){1,4})\\:){7}([0-9a-fA-F]){1,4}");
void InitializeAuthURL();
SessionTokenInfo GetSessionTokenInfo(const std::string& token);

struct AUTH_MIDDLEWARE
{
    struct context
    {
        std::string token;
        SessionTokenInfo tokenInfo;
    };

    void before_handle(crow::request& req, crow::response& res, context& ctx);
    void after_handle(crow::request& req, crow::response& res, context& ctx);
};

