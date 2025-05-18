

import 'package:employee_frontend/data/model/task.dart';
import 'package:employee_frontend/data/services/employee_service.dart';

class EmployeeRepository {
  EmployeeRepository({required EmployeeService employeeService})
    : _employeeService = employeeService;

  final EmployeeService _employeeService;

  
  Future<TasksListModel> getAllTasks(String sessionToken) async {
    try {
      final raw = await _employeeService.getAllTasks(sessionToken);
      final list = TasksListModel.fromJson(raw);
      return list;
    } catch (e) {
      rethrow;
    }
  }
  

 
}
