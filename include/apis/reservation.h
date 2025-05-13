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
std::pair<std::string, std::string> GetStationIDs(const std::pair<std::string, std::string>& stationNames);

const inline std::string CREATE_CUSTOMER_QUERY_BASIC_INFO = 
"INSERT INTO CustomerBasicInformation "
"(ID, FirstName, MiddleName, LastName, Gender) "
"VALUES " 
"(:ID, :FirstName, :MiddleName, :LastName, :Gender);";

const inline std::string CREATE_CUSTOMER_QUERY_SECURITY_INFO = 
"INSERT INTO CustomerSecurityInformation "
"(ID, PasswordSalt, PasswordHash) "
"VALUES "
"(:ID, :PasswordSalt, :PasswordHash);";

const inline std::string CREATE_CUSTOMER_QUERY_CONTACT_INFO =
"INSERT INTO CustomerContactInformation "
"(ID, Email, PhoneNumber) "
"VALUES "
"(:ID, :Email, :PhoneNumber);";

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
"SELECT TS.Name, TSCS.Distance FROM TrainStationConnectedStations TSCS "
"JOIN TrainStation TS ON TSCS.Destination = TS.ID "
"WHERE TSCS.Source = :ID; ";

const inline std::string GET_STATION_ID_QUERY = 
"SELECT ID FROM `TrainStation` WHERE Name = :Name; ";

const inline std::string ADD_STATION_CONNECTION_QUERY =
"INSERT INTO `TrainStationConnectedStations` "
"(Source, Destination, Distance) "
"VALUES (:Source, :Destination, :Distance); ";

