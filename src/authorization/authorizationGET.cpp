#include "authorization.h"
#include "crow/app.h"

void AddGETRequests(crow::SimpleApp &app)
{
  CROW_ROUTE(app, "/")([](const crow::request& req)
      {
        return "Hello, World!";
      });
}
