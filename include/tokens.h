#pragma once
#include <cstdint>
#include <string>

class SessionTokenInfo
{
  public:
    SessionTokenInfo(uint8_t permission, uint8_t subPermission, std::string uuid);
    uint8_t GetPermission();
    uint8_t GetSubPermission();
    std::string GetUUID();

  private:
    uint8_t permission;
    uint8_t subPermission;
    std::string uuid;
};

class ServiceTokenInfo
{

};
