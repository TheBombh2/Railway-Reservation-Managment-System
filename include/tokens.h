#pragma once
#include <cstdint>
#include <string>

class SessionTokenInfo
{
  public:
    SessionTokenInfo(uint8_t permission, uint8_t subPermission, std::string uuid);
    SessionTokenInfo(const std::string& inputString);
    uint8_t GetPermission();
    uint8_t GetSubPermission();
    std::string GetUUID();
    std::string GetData();
    void AddPermission(uint8_t perm);
    void AddSubPermission(uint8_t perm);
    void RemovePermission(uint8_t perm);
    void RemoveSubPermission(uint8_t perm);
    bool HasPermission(uint8_t perm);
    bool HasSubPermission(uint8_t perm);

  private:
    uint8_t permission;
    uint8_t subPermission;
    std::string uuid;
};

class ServiceTokenInfo
{

};
