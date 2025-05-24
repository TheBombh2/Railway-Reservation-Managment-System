import 'package:customer_frontend/data/model/ticket.dart';
import 'package:customer_frontend/data/services/api_client.dart';
import 'package:customer_frontend/secrets.dart';
import 'package:dio/dio.dart';

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

   Future<Map<String, dynamic>> getCustomerReservations(String sessionToken) async {
    try {
      final response = await _apiClient.getRequest(
        '/reservations/customer/get-reservations',
        sessionToken: sessionToken,
      );

      return response;
    } catch (e) {
      throw Exception("Failed to get stations information");
    }
  }

  Future<Map<String, dynamic>> getTrains(
    String firstStationID,
    String secondStationID,
    String sessionToken,
  ) async {
    try {
      final response = await _apiClient.getRequest(
        '/reservations/get-reservations',
        sessionToken: sessionToken,
        queryParams: {"source": firstStationID, "destination": secondStationID},
      );

      return response;
    } catch (e) {
      throw Exception("Failed to get stations information");
    }
  }

  Future<void> reserveTrain(dynamic ticket, String sessionToken) async {
    try {
      final response = await _apiClient.postRequest(
        '/reservations/create',
        body: ticket,
        sessionToken: sessionToken,
        responseType: ResponseType.plain,
      );

      return response;
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        case 404:
          throw 'Email or password are invalid';
        default:
          print(e.toString());
          throw 'Something went wrong.';
      }
    }
  }
}
