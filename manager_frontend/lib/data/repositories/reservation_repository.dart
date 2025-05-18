import 'package:manager_frontend/data/model/route.dart';
import 'package:manager_frontend/data/model/station.dart';
import 'package:manager_frontend/data/model/train.dart';
import 'package:manager_frontend/data/services/reservation_service.dart';

class ReservationRepository {
  ReservationRepository({required ReservationService reservationService})
    : _reservationService = reservationService;

  final ReservationService _reservationService;

  Future<StationsListModel> getAllStations(String sessionToken) async {
    try {
      final raw = await _reservationService.getAllStations(sessionToken);
      final list = StationsListModel.fromJson(raw);
      return list;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createNewStation(StationCreate data, String sessionToken) async {
    try {
      await _reservationService.createNewStation(data.toJson(), sessionToken);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createNewStationConnection(
    dynamic data,
    String sessionToken,
  ) async {
    try {
      await _reservationService.createNewStationConnection(data, sessionToken);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteStation(String stationID, String sessionToken) async {
    try {
      await _reservationService.deletStation(stationID, sessionToken);
    } catch (e) {
      rethrow;
    }
  }

  Future<String> createNewRoute(RouteCreate data, String sessionToken) async {
    try {
      final routeID = await _reservationService.createRoute(
        data.toJson(),
        sessionToken,
      );
      return routeID;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addRouteConnection(
    RouteConnection data,
    String sessionToken,
  ) async {
    try {
      await _reservationService.addRouteConnection(data.toJson(), sessionToken);
    } catch (e) {
      rethrow;
    }
  }

  Future<RoutesListModel> getAllRoutes(String sessionToken) async {
    try {
      final raw = await _reservationService.getAllRoutesInfo(sessionToken);
      final list = RoutesListModel.fromJson(raw);
      return list;
    } catch (e) {
      rethrow;
    }
  }

  Future<RouteConnectionsList> getRouteConnections(
    String routeID,
    String sessionToken,
  ) async {
    try {
      final raw = await _reservationService.getRouteConnections(
        routeID,
        sessionToken,
      );
      final list = RouteConnectionsList.fromJson(raw);
      return list;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteRoute(String routeID, String sessionToken) async {
    try {
      await _reservationService.deleteRoute(routeID, sessionToken);
    } catch (e) {
      rethrow;
    }
  }

   Future<void> createNewTrain(TrainCreate data, String sessionToken) async {
    try {
      await _reservationService.createTrain(data.toJson(), sessionToken);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createNewTrainType(TrainType data, String sessionToken) async {
    try {
      await _reservationService.createTrainType(data.toJson(), sessionToken);
    } catch (e) {
      rethrow;
    }
  }

  Future<TrainTypesList> getAllTrainTypes(
    String sessionToken,
  ) async {
    try {
      final raw = await _reservationService.getAllTrainTypes(
        sessionToken,
      );
      final list = TrainTypesList.fromJson(raw);
      return list;
    } catch (e) {
      rethrow;
    }
  }


  Future<TrainsList> getAllTrainsInfo(
    String sessionToken,
  ) async {
    try {
      final raw = await _reservationService.getAllTrainsinfo(
        sessionToken,
      );
      final list = TrainsList.fromJson(raw);
      return list;
    } catch (e) {
      rethrow;
    }
  }


  Future<String> getTrainState(
    String trainID,
    String sessionToken,
  ) async {
    try {
      final raw = await _reservationService.getTrainState(
        trainID,
        sessionToken,
      );
      return raw;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> sendTrain(String trainID, String sessionToken) async {
    try {
      await _reservationService.sendTrain(trainID, sessionToken);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> stopTrain(String trainID, String sessionToken) async {
    try {
      await _reservationService.stopTrain(trainID, sessionToken);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteTrain(String trainID, String sessionToken) async {
    try {
      await _reservationService.deleteTrain(trainID, sessionToken);
    } catch (e) {
      rethrow;
    }
  }
}
