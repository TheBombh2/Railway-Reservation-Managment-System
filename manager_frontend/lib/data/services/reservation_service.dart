import 'package:dio/dio.dart';
import 'package:manager_frontend/data/services/api_client.dart';

class ReservationService {
  final ApiClient _apiClient;

  ReservationService(Dio dio)
    : _apiClient = ApiClient(dio, subdomain: 'reservation');

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
}
