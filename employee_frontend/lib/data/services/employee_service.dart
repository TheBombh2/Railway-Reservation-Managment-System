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
      throw Exception("Failed to get tasks information");
    }
  }


  Future<Map<String, dynamic>> getAllAppraisals(String employeeID, String sessionToken) async {
    

    try {
      final response = await _apiClient.getRequest(
        '/users/$employeeID/appraisals',
        sessionToken: sessionToken,
      );

      return response;
    } catch (e) {
      throw Exception("Failed to get appraisals information");
    }
  }
  

  Future<Map<String, dynamic>> getAllCitations(String employeeID, String sessionToken) async {
    

    try {
      final response = await _apiClient.getRequest(
        '/users/$employeeID/citations',
        sessionToken: sessionToken,
      );

      return response;
    } catch (e) {
      throw Exception("Failed to get citations information");
    }
  }


    Future<void> completeTask(int taskID,String sessionToken) async {
    try {
      final response = await _apiClient.patchRequest(
        '/tasks/$taskID/complete',
        sessionToken: sessionToken
      );

      return response;
    } on DioException catch (e) {
      throw 'Something went wrong.';
    }
  }


}
