#pragma once
#include <soci/session.h>
#include <soci/soci.h>
#include <tuple>
#include <sw/redis++/redis.h>
#include <chrono>
#include "date/date.h"
#include "crow/app.h"
#include "middleware.h"

class RouteGraph
{
public:
    void PopulateGraph();
    void PopulateGraph(const std::vector<std::string>& src, const std::vector<std::string>& dst, 
                                   const std::vector<int>& departureDelay, const std::vector<int>& travelTime);
    std::unordered_map<std::string, std::tuple<std::string, int, int>> map;
};

void DebugPrintRoutesDS(const std::unordered_map<std::string, 
                        std::vector<std::pair<std::string, date::sys_time<std::chrono::seconds>>>>& input);
int GetTicketCost(const int ticketType);

const inline int MAX_STATIONS_RETURNED = 256;
//This is nothing but an ASSUMPTION
const inline int MAX_STATION_CONNECTIONS = 16;
const inline int MAX_TRAINS_RETURNED = 8;
const inline int MAX_ROUTES_RETURNED = 16;

//YES, THIS IS AN EXTREMELY UGLY AND EXTREMELY UGLY HARD CODED SOLUTION
//   ;)
const inline int ROUTE_SIZE = 2;

void AddReservationGETRequests(crow::App<AUTH_MIDDLEWARE>& app);
void AddReservationPOSTRequests(crow::App<AUTH_MIDDLEWARE>& app);
void AddReservationDELETERequests(crow::App<AUTH_MIDDLEWARE>& app);
std::pair<std::string, std::string> GetStationIDs(const std::pair<std::string, std::string>& stationNames);

const inline std::string SAMPLE_PDF_PATH = "/external/data/rrms/12307afed.pdf";

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

const inline std::string VERIFY_STATION_CONNECTION_QUERY =
"SELECT Distance FROM TrainStationConnectedStations WHERE Source = :SourceID AND Destination = :Destination; ";

const inline std::string GET_STATION_ID_QUERY = 
"SELECT ID FROM `TrainStation` WHERE Name = :Name; ";

const inline std::string ADD_STATION_CONNECTION_QUERY =
"INSERT INTO `TrainStationConnectedStations` "
"(Source, Destination, Distance) "
"VALUES (:Source, :Destination, :Distance); ";

const inline std::string CREATE_TRAIN_QUERY = 
"INSERT INTO `Train` (ID, Name, Speed, TrainTypeID, PurchaseDate, RouteID) "
"VALUES (:ID, :Name, :Speed, :TypeID, :PurchaseDate, :RouteID); ";

const inline std::string GET_ALL_TRAINS_INFO =
"SELECT ID, Name, Speed FROM `Train`; ";

const inline std::string GET_TRAIN_AND_ROUTE_ID =
"SELECT ID, RouteID FROM `Train`; ";

const inline std::string GET_TRAIN_ROUTE_QUERY =
"SELECT ID, RouteID FROM `Train`; ";

const inline std::string GET_TRAIN_NAME =
"SELECT Name FROM Train WHERE ID = :ID; ";

const inline std::string DELETE_TRAIN_QUERY =
"DELETE FROM Train WHERE ID = :ID; ";

const inline std::string GET_STATION_NAME_QUERY =
"SELECT Name FROM TrainStation WHERE ID = :ID; ";

const inline std::string DELETE_STATION_QUERY =
"DELETE FROM TrainStation WHERE ID = :ID; ";

const inline std::string CREATE_ROUTE_QUERY = 
"INSERT INTO TrainRoute (Title, Description, FirstStation, TotalDistance) "
"VALUES (:Title, :Description, :FirstStation, 0); ";

const inline std::string CREATE_ROUTE_CONNECTION_QUERY =
"INSERT INTO TrainRouteStations "
"(ID, SourceStationID, DestinationStationID, DepartureDelay, TravelTime) "
"VALUES (:RouteID, :SrcStationID, :DstStationID, :DepartureDelay, :TravelTime); ";

const inline std::string GET_ALL_ROUTES_INFO_QUERY =
"SELECT ID, Title, Description, FirstStation, TotalDistance FROM TrainRoute; ";

const inline std::string GET_ALL_ROUTE_CONNECTIONS_QUERY = 
"SELECT TS.Name as SourceName, TS2.Name AS DestinationName, DepartureDelay, TravelTime "
"FROM TrainRouteStations TRS "
"JOIN `TrainStation` TS ON TS.`ID` = TRS.`SourceStationID` "
"JOIN `TrainStation` TS2 ON TS2.ID = TRS.`DestinationStationID` "
"WHERE TRS.ID = :ID; ";

const inline std::string GET_ALL_ROUTE_CONNECTION_IDS_QUERY = 
"SELECT SourceStationID, DestinationStationID, DepartureDelay, TravelTime FROM "
"TrainRouteStations WHERE ID = :ID; ";

const inline std::string GET_ROUTE_FIRST_STATION_QUERY =
"SELECT FirstStation FROM TrainRoute WHERE ID = :ID; ";

const inline std::string VERIFY_ROUTE_QUERY =
"SELECT ID FROM TrainRoute WHERE ID = :ID; ";

const inline std::string ADD_ROUTE_TO_TRAIN_QUERY = 
"INSERT INTO TrainAssignedRoutes (TrainID, RouteID) VALUES (:TrainID, :RouteID); ";

const inline std::string DELETE_ROUTE_QUERY =
"DELETE FROM TrainRoute WHERE ID = :ID; ";

const inline std::string GET_TRAIN_TYPES_QUERY =
"SELECT ID, Title, Description FROM TrainType; ";

const inline std::string CREATE_TRAIN_TYPE_QUERY =
"INSERT INTO TrainType (Title, Description) VALUES (:Title, :Description); ";

const inline std::string CREATE_TRAIN_CAR_QUERY = 
"INSERT INTO TrainCar (CarClass, CarType) VALUES (:CarClass, :CarType)";

const inline std::string ASSIGN_TRAIN_CAR_QUERY = 
"INSERT INTO TrainCarAssignedTrain (TrainCarID, TrainID) "
"VALUES (:TrainCarID, :TrainID); ";

const inline std::string CREATE_TRAIN_SEATS_QUERY =
"INSERT INTO TrainCarSeat (ID, AssignedCar) VALUES (:ID, :AssignedCar); ";

const inline std::string GET_TRAIN_CAR_IDS = 
"SELECT TrainCarID FROM `TrainCarAssignment` WHERE `TrainID` = :ID; ";

const inline std::string GET_MINIMUM_SEAT_NUMBER =
"SELECT MIN(SeatID) FROM `CustomerSeatReservation` WHERE `TrainCarID` = :ID; ";

const inline std::string CREATE_CUSTOMER_SEAT_RESERVATION =
"INSERT INTO `CustomerSecurityInformation` "
"(SeatID, TrainCarID, CustomerID, TrainArrivalTime, DestinationArrivalTime, Cost, PDFPath) "
"VALUES (:SeatID, :TrainCarID, :CustomerID, :TrainArrivalTime, :DestinationArrivalTime, :Cost, :PDFPath); ";
