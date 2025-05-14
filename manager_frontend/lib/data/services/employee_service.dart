import 'package:dio/dio.dart';
import 'package:manager_frontend/data/services/api_client.dart';

class EmployeeService {
  final ApiClient _apiClient;

  EmployeeService(Dio dio) : _apiClient = ApiClient(dio, subdomain: 'employee');

  Future<Map<String, dynamic>> getAllEmployeeInfo(String sessionToken) async {
    try {
      final response = await _apiClient.getRequest(
        '/users/employee/all-info',
        sessionToken: sessionToken,
      );

      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
