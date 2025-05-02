#include <cstdint>
#include <sstream>
#include "tokens.h"
#include "permissions.h"

SessionTokenInfo::SessionTokenInfo(uint8_t permission, uint8_t subPermission, std::string uuid)
{
  this->uuid.reserve(36);
  this->uuid = uuid;
  this->permission = permission;
  this->subPermission = subPermission;
}

SessionTokenInfo::SessionTokenInfo()
{
    //No-op
}

SessionTokenInfo::SessionTokenInfo(const std::string& inputString)
{
    std::istringstream sts(inputString);
    this->uuid.reserve(36);
    uint8_t permission, subPermission;
    std::string uuid;
    sts >> permission >> subPermission >> uuid;
}

uint8_t SessionTokenInfo::GetPermission()
{
  return this->permission;
}

uint8_t SessionTokenInfo::GetSubPermission()
{
  return this->subPermission;
}

std::string SessionTokenInfo::GetUUID()
{
  return this->uuid;
}

std::string SessionTokenInfo::GetData()
{
    return std::to_string(this->permission) + ' ' + 
    std::to_string(this->subPermission) + ' ' + this->uuid;
}

void SessionTokenInfo::AddPermission(uint8_t perm)
{
    this->permission |= perm;
}

void SessionTokenInfo::AddSubPermission(uint8_t perm)
{
    this->subPermission |= perm;
}

void SessionTokenInfo::RemoveSubPermission(uint8_t perm)
{
    uint8_t mask = ~perm;
    this->subPermission &= mask;
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

bool SessionTokenInfo::HasSubPermission(uint8_t perm)
{
    if(subPermission == SUB_PERMISSIONS::NONE_SUBPERM) return true;
    return this->subPermission & perm;
}
