

import 'package:employee_frontend/data/services/employee_service.dart';

class EmployeeRepository {
  EmployeeRepository({required EmployeeService employeeService})
    : _employeeService = employeeService;

  final EmployeeService _employeeService;

  /*
  Future<Permissions> getAllPermissions(String sessionToken) async {
    try {
      final raw = await _employeeService.getAllPermissions(sessionToken);
      final permsList = Permissions.fromJson(raw);
      return permsList;
    } catch (e) {
      rethrow;
    }
  }
  */

 
}
