import 'package:dio/dio.dart';
import 'package:manager_frontend/data/services/api_client.dart';
import 'package:manager_frontend/secrets.dart';

class ReservationService {
  final ApiClient _apiClient;

  ReservationService(Dio dio)
    : _apiClient = ApiClient(
        dio,
        subdomain: 'reservation',
        portNumber: Secrets.reservationPortNumber,
      );

  Future<Map<String, dynamic>> getAllStations(String sessionToken) async {
    try {
      final response = await _apiClient.getRequest(
        '/stations/all-stations',
        sessionToken: sessionToken,
      );

      return response;
    } catch (e) {
      throw Exception("Failed to get stations information");
    }
  }

  Future<void> createNewStation(
    Map<String, dynamic> stationData,
    String sessionToken,
  ) async {
    try {
      final response = await _apiClient.postRequest(
        '/stations/create-station',
        body: stationData,
        sessionToken: sessionToken,
      );

      return response;
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        case 401:
          throw 'Please Login';
        default:
          throw 'Something went wrong.';
      }
    }
  }

  Future<void> createNewStationConnection(
    Map<String, dynamic> data,
    String sessionToken,
  ) async {
    try {
      final response = await _apiClient.postRequest(
        '/stations/add-connection',
        body: data,
        sessionToken: sessionToken,
      );

      return response;
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        case 401:
          throw 'Please Login';
        case 500:
          throw "There is already a connection between these two stations";
        default:
          throw 'Something went wrong.';
      }
    }
  }

  Future<void> deletStation(String stationID, String sessionToken) async {
    try {
      final response = await _apiClient.deleteRequest(
        '/stations/$stationID/delete',
        sessionToken: sessionToken,
      );

      return response;
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        case 401:
          throw 'Please Login';
        default:
          throw 'Something went wrong.';
      }
    }
  }



  Future<String> createRoute(
    Map<String, dynamic> data,
    String sessionToken,
  ) async {
    try {
      final response = await _apiClient.postRequest(
        '/routes/create',
        body: data,
        sessionToken: sessionToken,
        responseType: ResponseType.plain
      );

      return response;
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        case 401:
          throw 'Please Login';
        default:
          throw 'Something went wrong.';
      }
    }
  }


  Future<void> addRouteConnection(
    Map<String, dynamic> data,
    String sessionToken,
  ) async {
    try {
      final response = await _apiClient.postRequest(
        '/routes/add-connection',
        body: data,
        sessionToken: sessionToken,
      );

      return response;
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        case 401:
          throw 'Please Login';
        default:
          throw 'Something went wrong.';
      }
    }
  }


  Future<Map<String, dynamic>> getAllRoutesInfo(
    String sessionToken,
  ) async {
    try {
      final response = await _apiClient.getRequest(
        '/routes/all-info',
        sessionToken: sessionToken,
      );

      return response;
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        case 401:
          throw 'Please Login';
        default:
          throw 'Something went wrong.';
      }
    }
  }


  Future<Map<String, dynamic>> getRouteConnections(
    String routeID,
    String sessionToken,
  ) async {
    try {
      final response = await _apiClient.getRequest(
        '/routes/$routeID/connections',
        sessionToken: sessionToken,
      );

      return response;
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        case 401:
          throw 'Please Login';
        default:
          throw 'Something went wrong.';
      }
    }
  }

  Future<void> deleteRoute(String routeID, String sessionToken) async {
    try {
      final response = await _apiClient.deleteRequest(
        '/routes/$routeID/delete',
        sessionToken: sessionToken,
      );

      return response;
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        case 401:
          throw 'Please Login';
        default:
          throw 'Something went wrong.';
      }
    }
  }


  Future<String> createTrain(
    Map<String, dynamic> data,
    String sessionToken,
  ) async {
    try {
      final response = await _apiClient.postRequest(
        '/trains/create',
        body: data,
        sessionToken: sessionToken,
        responseType: ResponseType.plain
      );

      return response;
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        case 401:
          throw 'Please Login';
        default:
          throw 'Something went wrong.';
      }
    }
  }

   Future<String> createTrainType(
    Map<String, dynamic> data,
    String sessionToken,
  ) async {
    try {
      final response = await _apiClient.postRequest(
        '/trains/types/create',
        body: data,
        sessionToken: sessionToken,
        responseType: ResponseType.plain
      );

      return response;
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        case 401:
          throw 'Please Login';
        default:
          throw 'Something went wrong.';
      }
    }
  }


  Future<Map<String, dynamic>> getAllTrainsinfo(
    String sessionToken,
  ) async {
    try {
      final response = await _apiClient.getRequest(
        '/trains/all-info',
        sessionToken: sessionToken,
      );

      return response;
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        case 401:
          throw 'Please Login';
        default:
          throw 'Something went wrong.';
      }
    }
  }


  Future<String> getTrainState(
    String id,
    String sessionToken,
  ) async {
    try {
      final response = await _apiClient.getRequest(
        '/trains/$id/get-state',
        sessionToken: sessionToken,

      );

      return response;
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        case 401:
          throw 'Please Login';
        default:
          throw 'Something went wrong.';
      }
    }
  }


  Future<Map<String, dynamic>> getAllTrainTypes(
    String sessionToken,
  ) async {
    try {
      final response = await _apiClient.getRequest(
        '/trains/all-types',
        sessionToken: sessionToken,
      );

      return response;
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        case 401:
          throw 'Please Login';
        default:
          throw 'Something went wrong.';
      }
    }
  }


  Future<void> deleteTrain(String trainID, String sessionToken) async {
    try {
      final response = await _apiClient.deleteRequest(
        '/trains/$trainID/delete',
        sessionToken: sessionToken,
      );

      return response;
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        case 401:
          throw 'Please Login';
        default:
          throw 'Something went wrong.';
      }
    }
  }


  Future<void> stopTrain(String trainID, String sessionToken) async {
    try {
      final response = await _apiClient.deleteRequest(
        '/trains/$trainID/stop',
        sessionToken: sessionToken,
      );

      return response;
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        case 401:
          throw 'Please Login';
        default:
          throw 'Something went wrong.';
      }
    }
  }

  Future<void> sendTrain(String trainID, String sessionToken) async {
    try {
      final response = await _apiClient.postRequest(
        '/trains/$trainID/send',
        sessionToken: sessionToken,
        body: {}
      );

      return response;
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        case 401:
          throw 'Please Login';
        default:
          throw 'Something went wrong.';
      }
    }
  }
}
