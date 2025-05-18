import 'package:dio/dio.dart';
import 'package:employee_frontend/data/services/api_client.dart';
import 'package:employee_frontend/secrets.dart';

class EmployeeService {
  final ApiClient _apiClient;

  EmployeeService(Dio dio) : _apiClient = ApiClient(dio, subdomain: 'employee',portNumber: Secrets.employeePortNumber);

  Future<Map<String, dynamic>> getAllEmployeeInfo(String sessionToken) async {
    

    try {
      final response = await _apiClient.getRequest(
        '/users/employee/all-info',
        sessionToken: sessionToken,
      );

      return response;
    } catch (e) {
      throw Exception("Failed to get employee information");
    }
  }


Future<Map<String, dynamic>> getAllTasks(String sessionToken) async {
    

    try {
      final response = await _apiClient.getRequest(
        '/users/tasks',
        sessionToken: sessionToken,
      );

      return response;
    } catch (e) {
      throw Exception("Failed to get employee information");
    }
  }
  


}
