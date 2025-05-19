import 'package:customer_frontend/data/services/api_client.dart';
import 'package:customer_frontend/secrets.dart';
import 'package:dio/dio.dart';



class CustomerService {
  final ApiClient _apiClient;

  CustomerService(Dio dio) : _apiClient = ApiClient(dio, subdomain: 'reservation',portNumber: Secrets.reservationPortNumber);

  Future<Map<String, dynamic>> getAllCustomerInfo(String sessionToken) async {
    

    try {
      final response = await _apiClient.getRequest(
        '/users/customer/all-info',
        sessionToken: sessionToken,
      );

      return response;
    } catch (e) {
      print(e.toString());
      throw Exception("Failed to get customer information");
    }
  }





}
