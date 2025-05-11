#pragma once
#include <soci/session.h>
#include <soci/soci.h>
#include <sw/redis++/redis.h>
#include "crow/app.h"
#include "middleware.h"

void AddReservationGETRequests(crow::App<AUTH_MIDDLEWARE>& app);
void AddReservationPOSTRequests(crow::App<AUTH_MIDDLEWARE>& app);
    void AddReservationDELETERequests(crow::App<AUTH_MIDDLEWARE>& app);
