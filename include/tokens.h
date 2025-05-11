#pragma once
#include <cstdint>
#include <string>
#include <array>

int GetSubPermissionIndex(uint8_t permission);

class SessionTokenInfo
{
  public:
    SessionTokenInfo(uint8_t permission, std::string subPermissionsString, std::string uuid);
    SessionTokenInfo(const std::string& inputString);
    SessionTokenInfo();
    uint8_t GetPermission();
    std::array<uint8_t, 8> GetSubPermissions();
    std::string GetUUID();
    std::string GetData();
    void AddPermission(uint8_t perm);
    void AddSubPermission(uint8_t perm, uint8_t subPerm);
    void RemovePermission(uint8_t perm);
    void RemoveSubPermission(uint8_t perm, uint8_t subPerm);
    bool HasPermission(uint8_t perm);
    bool HasSubPermission(uint8_t perm, uint8_t subPerm);

  private:
    uint8_t permission;
    std::array<uint8_t, 8> subPermissions;
    std::string uuid;
};
