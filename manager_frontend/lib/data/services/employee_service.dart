import 'package:dio/dio.dart';
import 'package:manager_frontend/data/services/api_client.dart';

class EmployeeService {
  final ApiClient _apiClient;

  EmployeeService(Dio dio) : _apiClient = ApiClient(dio, subdomain: 'employee');

  Future<Map<String, dynamic>> getAllEmployeeInfo(String sessionToken) async {
    await Future.delayed(Duration(seconds: 5));
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
    /*
    
    try {
      final response = await _apiClient.getRequest(
        '/users/employee/all-info',
        sessionToken: sessionToken,
      );

      return response;
    } catch (e) {
      throw Exception("Failed to get employee information");
    }
    */
  }

  Future<Map<String, dynamic>> getAllEmployeesInfo(String sessionToken) async {
    return {
      "employees": [
        {
          "departmentName": "Engineering",
          "employeeID": "DEV-1001",
          "firstName": "Alex",
          "gender": "Male",
          "jobTitle": "Senior Software Engineer",
          "lastName": "Johnson",
          "managerLastName": "Smith",
          "managerMiddleName": "Q",
          "managerfirstName": "Sarah",
          "middleName": "Robert",
        },
        {
          "departmentName": "Marketing",
          "employeeID": "MKT-2002",
          "firstName": "Emily",
          "gender": "Female",
          "jobTitle": "Digital Marketing Specialist",
          "lastName": "Chen",
          "managerLastName": "Williams",
          "managerMiddleName": "L",
          "managerfirstName": "Michael",
          "middleName": "Grace",
        },
      ],
      "size": 2,
    };
    /* try {
      final response = await _apiClient.getRequest(
        '/users/employees/all-info',
        sessionToken: sessionToken,
      );

      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
    */
  }
}
