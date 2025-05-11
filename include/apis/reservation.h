#pragma once
#include <soci/session.h>
#include <soci/soci.h>
#include <sw/redis++/redis.h>
#include "crow/app.h"
#include "middleware.h"

const inline int MAX_STATIONS_RETURNED = 256;
//This is nothing but an ASSUMPTION
const inline int MAX_STATION_CONNECTIONS = 8;

void AddReservationGETRequests(crow::App<AUTH_MIDDLEWARE>& app);
void AddReservationPOSTRequests(crow::App<AUTH_MIDDLEWARE>& app);
void AddReservationDELETERequests(crow::App<AUTH_MIDDLEWARE>& app);

const inline std::string SELECT_CUSTOMER_PASSWORD_SALT_QUERY = 
"SELECT PasswordSalt FROM CustomerSecurityInformation WHERE ID=:ID;";

const inline std::string GET_CUSTOMER_INFORMATION_QUERY =
"SELECT FirstName, MiddleName, LastName, Gender, Email, PhoneNumber "
"FROM `CustomerBasicInformation` CBI "
"JOIN `CustomerContactInformation` CCI ON CBI.ID = CCI.ID "
"WHERE ID = :ID; ";

//Stations queries go here
const inline std::string CREATE_STATION_QUERY =
"INSERT INTO `TrainStation` "
"(ID, Name, Description, Location, Longitude, Latitude) "
"VALUES (:ID, :Name, :Description, :Location, :Latitude, :Longitude); ";

const inline std::string GET_STATIONS_QUERY =
"SELECT ID, Name, Description, Location, Longitude, Latitude FROM `TrainStation`; ";

const inline std::string GET_STATION_CONNECTIONS_QUERY = 
"SELECT TS.Name, tscs.Distance FROM TrainStationConnectedStations TSCS "
"JOIN TrainStation TS ON TSCS.Destination = TS.ID "
"WHERE TSCS.Source = :ID; ";
