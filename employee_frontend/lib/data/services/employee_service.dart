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

  Future<Map<String, dynamic>> getAllEmployeesInfo(String sessionToken) async {
   
    try {
      final response = await _apiClient.getRequest(
        '/users/employees/all-info',
        sessionToken: sessionToken,
      );

      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> createNewEmployee(
    Map<String, dynamic> employeeData,
    String sessionToken,
  ) async {
    try {
      final response = await _apiClient.postRequest(
        '/users/create/employee',
        body: employeeData,
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

  Future<void> createNewJob(
    Map<String, dynamic> jobData,
    String sessionToken,
  ) async {
    try {
      final response = await _apiClient.postRequest(
        '/jobs/create',
        body: jobData,
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

  Future<void> createNewTask(
    Map<String, dynamic> taskData,
    String sessionToken,
  ) async {
    try {
      final response = await _apiClient.postRequest(
        '/users/tasks/create',
        body: taskData,
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

  Future<void> createNewAppraisal(
    Map<String, dynamic> appraisalData,
    String sessionToken,
  ) async {
    try {
      final response = await _apiClient.postRequest(
        '/users/appraisals/create',
        body: appraisalData,
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

  Future<void> createNewCitation(
    Map<String, dynamic> citationData,
    String sessionToken,
  ) async {
    try {
      final response = await _apiClient.postRequest(
        '/users/citations/create',
        body: citationData,
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

  Future<Map<String, dynamic>> getAllDepartmentsInfo(
    String sessionToken,
  ) async {
    try {
      final response = await _apiClient.getRequest(
        '/departments/info',
        sessionToken: sessionToken,
      );

      return response;
    } catch (e) {
      throw Exception("Failed to get departments information");
    }
  }


  Future<void> createNewDepartment(
    Map<String, dynamic> data,
    String sessionToken,
  ) async {
    try {
      final response = await _apiClient.postRequest(
        '/departments/create',
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


   Future<void> deleteDepartment(
    String departmentID,
    String sessionToken,
  ) async {
    try {
      final response = await _apiClient.deleteRequest(
        '/departments/$departmentID/delete',
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

  Future<Map<String, dynamic>> getAllJobsInfo(String sessionToken) async {
    try {
      final response = await _apiClient.getRequest(
        '/jobs/all-info',
        sessionToken: sessionToken,
      );

      return response;
    } catch (e) {
      throw Exception("Failed to get jobs information");
    }
  }


  Future<void> deleteEmployee(
    String employeeID,
    String sessionToken,
  ) async {
    try {
      final response = await _apiClient.deleteRequest(
        '/employee/$employeeID/delete',
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


  Future<Map<String, dynamic>> getAllPermissions(String sessionToken) async {
    try {
      final response = await _apiClient.getRequest(
        '/permissions/all-permissions',
        sessionToken: sessionToken,
      );

      return response;
    } catch (e) {
      throw Exception("Failed to get permissions information");
    }
  }


  Future<Map<String, dynamic>> getAllSubPermissions(String sessionToken) async {
    try {
      final response = await _apiClient.getRequest(
        '/subpermissions/all-subpermissions',
        sessionToken: sessionToken,
      );

      return response;
    } catch (e) {
      throw Exception("Failed to get subpermissions information");
    }
  }
}
