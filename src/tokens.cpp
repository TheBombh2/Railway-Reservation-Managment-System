#include "tokens.h"
#include <cstdint>
#include <sys/types.h>

SessionTokenInfo::SessionTokenInfo(uint8_t permission, uint8_t subPermission, std::string uuid)
{
  this->uuid.reserve(36);
  this->uuid = uuid;
  this->permission = permission;
  this->subPermission = subPermission;
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
