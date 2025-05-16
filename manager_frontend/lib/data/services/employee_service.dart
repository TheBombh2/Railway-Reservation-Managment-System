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
