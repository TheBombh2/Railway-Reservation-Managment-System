#include <cstdint>
#include <sstream>
#include "tokens.h"
#include "permissions.h"

int GetSubPermissionIndex(uint8_t permission)
{
    if(permission == 0)
        return -1;

    switch(permission)
    {
        case PERMISSIONS::HUMAN_RESOURCES:
            return DEP_HUMAN_RESOURCES;
        case PERMISSIONS::INFORMATION_TECHNOLOGY:
            return DEPARTMENT_IDS::DEP_INFORMATION_TECHNOLOGY;
        case PERMISSIONS::ASSET_MANAGEMENT:
            return DEPARTMENT_IDS::DEP_ASSET_MANAGEMENT;
        case PERMISSIONS::TRAIN_MANAGEMENT:
            return DEPARTMENT_IDS::DEP_TRAIN_MANAGEMENT;
        case PERMISSIONS::MAINTENANCE:
            return DEPARTMENT_IDS::DEP_MAINTENANCE;
        case PERMISSIONS::TICKETING:
            return DEPARTMENT_IDS::DEP_TICKETING;
        case PERMISSIONS::MANAGEMENT:
            return DEPARTMENT_IDS::DEP_MANAGEMENT;
        case PERMISSIONS::JOBS:
            return DEPARTMENT_IDS::DEP_JOBS;
    }
    return -1;
}
SessionTokenInfo::SessionTokenInfo(uint8_t permission, std::string subPermissionsString, std::string uuid)
{
  this->uuid.reserve(36);
  this->uuid = uuid;
  this->permission = permission;
  std::istringstream sts(subPermissionsString);
  sts >> this->subPermissions[0] >> this->subPermissions[1] >> this->subPermissions[2] >> this->subPermissions[3] >>
  this->subPermissions[4] >> this->subPermissions[5] >> this->subPermissions[6] >> this->subPermissions[7];
}

SessionTokenInfo::SessionTokenInfo()
{
    //No-op
}

SessionTokenInfo::SessionTokenInfo(const std::string& inputString)
{
    std::istringstream sts(inputString);
    this->uuid.reserve(36);
    //YES, THIS IS UGLY.
    //YES, IT IS ALSO EASY TO IMEPLEMENT
    sts >> this->permission >> this->subPermissions[0] >> this->subPermissions[1] >> this->subPermissions[2] >>
    this->subPermissions[3] >> this->subPermissions[4] >> this->subPermissions[5] >> this->subPermissions[6] >>
    this->subPermissions[7] >> this->uuid;
}

uint8_t SessionTokenInfo::GetPermission()
{
  return this->permission;
}

std::array<uint8_t, 8> SessionTokenInfo::GetSubPermissions()
{
  return this->subPermissions;
}

std::string SessionTokenInfo::GetUUID()
{
  return this->uuid;
}

std::string SessionTokenInfo::GetData()
{
    std::string result;
    result += std::to_string(this->permission) + ' ';
    for(int i = 0; i < 8; i++)
        result += std::to_string(this->subPermissions[i]) + ' ';
    result += this->uuid;
    return result;
}

void SessionTokenInfo::AddPermission(uint8_t perm)
{
    this->permission |= perm;
}

void SessionTokenInfo::AddSubPermission(uint8_t perm, uint8_t subPerm)
{
    int idx = GetSubPermissionIndex(perm);
    this->subPermissions[idx] |= subPerm;
}

void SessionTokenInfo::RemoveSubPermission(uint8_t perm, uint8_t subPerm)
{
    int idx = GetSubPermissionIndex(perm);
    uint8_t mask = ~perm;
    this->subPermissions[idx] &= mask;
}

void SessionTokenInfo::RemovePermission(uint8_t perm)
{
    uint8_t mask = ~perm;
    this->permission &= mask;
}

bool SessionTokenInfo::HasPermission(uint8_t perm)
{
    if(perm == PERMISSIONS::NONE_PERM) return true;
    return this->permission & perm;
}

bool SessionTokenInfo::HasSubPermission(uint8_t perm, uint8_t subPerm)
{
    int idx = GetSubPermissionIndex(perm);
    if(idx == -1) return true;
    return this->subPermissions[idx] & perm;
}
