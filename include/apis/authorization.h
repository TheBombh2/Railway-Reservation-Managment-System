#pragma once
#include <soci/session.h>
#include <soci/soci.h>
#include "crow/app.h"

void AddGETRequests(crow::SimpleApp& app, const soci::session& db);
void AddPOSTRequest(crow::SimpleApp& app, const soci::session& db);
