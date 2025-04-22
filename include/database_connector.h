#pragma once
#include <soci/soci.h>
#include <soci/mysql/soci-mysql.h>

inline soci::session dbConnector;
void InitializeConnector();
