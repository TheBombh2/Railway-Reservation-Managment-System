import 'package:manager_frontend/data/model/employee.dart';
import 'package:manager_frontend/data/services/employee_service.dart';

class EmployeeRepository {
  EmployeeRepository({required EmployeeService employeeService})
    : _employeeService = employeeService;

  final EmployeeService _employeeService;

  Future<EmployeeList> getAllEmployeesInfo(String sessionToken) async {
    try {
      final rawEmployeeList = await _employeeService.getAllEmployeesInfo(
        sessionToken,
      );
      final employeeList = EmployeeList.fromJson(rawEmployeeList);
      return employeeList;
    } catch (e) {
      rethrow;
    }
  }
}
