#pragma once
#include "tokens.h"
#include <string>
#include <regex>

inline std::string authServiceURL;
const inline std::string authTokenPath = "/users/token-info";
//Yes, this looks very ugly. Thank you for pointing that out
const inline std::regex IPv4Regex("(([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])");
const inline std::regex IPv6Regex("((([0-9a-fA-F]){1,4})\\:){7}([0-9a-fA-F]){1,4}");
void InitializeAuthURL();
SessionTokenInfo GetSessionTokenInfo(const std::string& authHeader);

