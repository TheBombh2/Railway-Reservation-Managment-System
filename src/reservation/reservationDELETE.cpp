#include "database_connector.h"
#include "crow/common.h"
#include "middleware.h"
#include "permissions.h"
#include "reservation.h"

void AddReservationDELETERequests(crow::App<AUTH_MIDDLEWARE> &app)
{
    CROW_ROUTE(app, "/trains/<string>/delete").methods(crow::HTTPMethod::DELETE)
        ([&](const crow::request& req, const std::string& trainUUID)
         {
         AUTH_INIT(PERMISSIONS::TRAIN_MANAGEMENT, SUB_PERMISSIONS::DELETE_TRAIN)
         try
         {
            soci::session db(pool);
            std::string tempName;
            db << GET_TRAIN_NAME, soci::use(trainUUID), soci::into(tempName);
            if(tempName.empty())
                return crow::response(404, "not found");
            db << DELETE_TRAIN_QUERY, soci::use(trainUUID);
         }
         catch(const std::exception& e)
         {
            std::cerr << "DATABASE ERROR (/trains/<string>/delete): " << e.what() << '\n';
            std::cerr << "<string> value: " << trainUUID << '\n'; 
            return crow::response(500, "database error");
         }
         return crow::response(204, "train successfully deleted");
         });

    CROW_ROUTE(app, "/stations/<string>/delete").methods(crow::HTTPMethod::DELETE)
        ([&](const crow::request& req, const std::string& stationUUID)
         {
         AUTH_INIT(PERMISSIONS::TRAIN_MANAGEMENT, SUB_PERMISSIONS::DELETE_STATION)
         try
         {
            std::string tempName;
            soci::session db(pool);
            db << GET_STATION_NAME_QUERY, soci::use(stationUUID), soci::into(tempName);
            if(tempName.empty())
                return crow::response(404, "not found");
            db << DELETE_STATION_QUERY, soci::use(stationUUID);
         }
         catch(const std::exception& e)
         {
            std::cerr << "DATABASE ERROR (/stations/<string>/delete): " << e.what() << '\n';
            std::cerr << "<string> value: " << stationUUID << '\n';
            return crow::response(500, "database error");
         }
         return crow::response(204, "successfully deleted station");
         });
}
