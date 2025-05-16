import 'package:manager_frontend/data/model/department.dart';
import 'package:manager_frontend/data/model/employee.dart';
import 'package:manager_frontend/data/model/job.dart';
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

  Future<DepartmentsList> getAllDepartmentsInfo(String sessionToken) async {
    try {
      final raw = await _employeeService.getAllDepartmentsInfo(
        sessionToken,
      );
      final depsList = DepartmentsList.fromJson(raw);
      return depsList;
    } catch (e) {
      rethrow;
    }
  }


  Future<JobsList> getAllJobsInfo(String sessionToken) async {
    try {
      final raw = await _employeeService.getAllJobsInfo(
        sessionToken,
      );
      final jobsList = JobsList.fromJson(raw);
      return jobsList;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createEmployee(
    EmployeeCreate employeeData,
    String sessionToken,
  ) async {
    try {
      await _employeeService.createNewEmployee(employeeData.toJson(), sessionToken);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createJob(
    JobCreate jobData,
    String sessionToken,
  ) async {
    try {
      await _employeeService.createNewJob(jobData.toJson(), sessionToken);
    } catch (e) {
      rethrow;
    }
  }
}
