import 'package:dio/dio.dart';
import 'package:manager_frontend/data/services/api_client.dart';

class EmployeeService {
  final ApiClient _apiClient;

  EmployeeService(Dio dio) : _apiClient = ApiClient(dio, subdomain: 'employee');

  Future<Map<String, dynamic>> getAllEmployeeInfo(String sessionToken) async {
    /*await Future.delayed(Duration(seconds: 5));
    return {
      "basic-info": {
        "firstName": "John",
        "gender": "Male",
        "lastName": "Doe",
        "middleName": "Michael",
        "salary": 120000,
      },
      "department-info": {
        "description": "Software Development Department",
        "location": "New York Office",
        "manager-info": {
          "firstName": "Sarah",
          "gender": "Female",
          "hireDate": "2020-05-15",
          "lastName": "Smith",
          "middleName": "Anne",
        },
        "title": "Development Department",
      },
      "job-info": {
        "jobDescription": "Oversees software development projects and teams",
        "jobTitle": "Development Manager",
      },
      "manager-info": {
        "firstName": "Robert",
        "gender": "Male",
        "jobInfo": {
          "jobDescription": "Oversees multiple departments",
          "jobTitle": "Director of Operations",
        },
        "lastName": "Johnson",
        "middleName": "William",
      },
    };
    */

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
    /*return {
      "employees": [
        {
          "email": "alyelsharkawwyoct@gmail.com",
          "phoneNumber": "123456789",
          "jobTitle": "Root Developer",
          "employeeID": "01967497-a715-7058-9658-88d1161f06cc",
          "managerLastName": "Salem",
          "employeeGender": "M",
          "managerMiddleName": "",
          "employeeLastName": "Elsharkawy",
          "managerFirstName": "Belal",
          "employeeMiddleName": "",
          "employeeFirstName": "Aly",
        },
        {
          "employeeFirstName": "Belal",
          "employeeMiddleName": "",
          "managerFirstName": "Belal",
          "employeeLastName": "Salem",
          "managerMiddleName": "",
          "employeeGender": "M",
          "managerLastName": "Salem",
          "employeeID": "01967497-a72f-78dc-92eb-64efb912f5c3",
          "jobTitle": "Root Developer",
          "phoneNumber": "123456789",
          "email": "belalsalem500@gmail.com",
        },
        {
          "email": "notnormal@furious-shark-hosting.duckdns.org",
          "phoneNumber": "123456789",
          "jobTitle": "Root Developer",
          "employeeID": "01967497-a72f-7a34-909c-0f5aea3ad6a2",
          "managerLastName": "Salem",
          "employeeGender": "U",
          "managerMiddleName": "",
          "employeeLastName": "normal",
          "managerFirstName": "Belal",
          "employeeMiddleName": "",
          "employeeFirstName": "not",
        },
        {
          "email": "elgamed6000@gmail.com",
          "phoneNumber": "123456789",
          "jobTitle": "Root Developer",
          "employeeID": "01967497-a72f-7b24-8d77-2b17fbcf5d9b",
          "managerLastName": "Salem",
          "employeeGender": "M",
          "managerMiddleName": "",
          "employeeLastName": "Bomboclat",
          "managerFirstName": "Belal",
          "employeeMiddleName": "",
          "employeeFirstName": "ElGamed",
        },
      ],
      "size": 4,
    };
    */
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
}
