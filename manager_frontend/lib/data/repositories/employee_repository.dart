import 'package:json_bigint/json_bigint.dart';
import 'package:manager_frontend/data/model/appraisal.dart';
import 'package:manager_frontend/data/model/citation.dart';
import 'package:manager_frontend/data/model/department.dart';
import 'package:manager_frontend/data/model/employee.dart';
import 'package:manager_frontend/data/model/job.dart';
import 'package:manager_frontend/data/model/permission.dart';
import 'package:manager_frontend/data/model/subpermissionsData.dart';
import 'package:manager_frontend/data/model/task.dart';
import 'package:manager_frontend/data/services/employee_service.dart';
import 'package:manager_frontend/ui/employees/bloc/employees_bloc.dart';

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
      final raw = await _employeeService.getAllDepartmentsInfo(sessionToken);
      final depsList = DepartmentsList.fromJson(raw);
      return depsList;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createDpeartment(
    DepartmentCreate data,
    String sessionToken,
  ) async {
    try {
      
      final formattedData = encodeJson(data.toJson());
     // print(formattedData);
      final newData = decodeJson(formattedData) as Map<String, dynamic>;
      await _employeeService.createNewDepartment(newData, sessionToken);
    } catch (e) {
      rethrow;
    }
  }


  Future<void> deleteDepartment(String departmentID, String sessionToken) async {
    try {
      await _employeeService.deleteDepartment(departmentID, sessionToken);
    } catch (e) {
      rethrow;
    }
  }

  Future<JobsList> getAllJobsInfo(String sessionToken) async {
    try {
      final raw = await _employeeService.getAllJobsInfo(sessionToken);
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
      await _employeeService.createNewEmployee(
        employeeData.toJson(),
        sessionToken,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createJob(JobCreate jobData, String sessionToken) async {
    try {
      await _employeeService.createNewJob(jobData.toJson(), sessionToken);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createTask(Task data, String sessionToken) async {
    try {
      await _employeeService.createNewTask(data.toJson(), sessionToken);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createAppraisal(Appraisal data, String sessionToken) async {
    try {
      await _employeeService.createNewAppraisal(data.toJson(), sessionToken);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createCitation(Citation data, String sessionToken) async {
    try {
      await _employeeService.createNewCitation(data.toJson(), sessionToken);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteEmployee(String employeeID, String sessionToken) async {
    try {
      await _employeeService.deleteEmployee(employeeID, sessionToken);
    } catch (e) {
      rethrow;
    }
  }

  Future<Permissions> getAllPermissions(String sessionToken) async {
    try {
      final raw = await _employeeService.getAllPermissions(sessionToken);
      final permsList = Permissions.fromJson(raw);
      return permsList;
    } catch (e) {
      rethrow;
    }
  }

  Future<SubPermissionsData> getAllSubPermissions(String sessionToken) async {
    try {
      final raw = await _employeeService.getAllSubPermissions(sessionToken);
      final permsList = SubPermissionsData.fromJson(raw);
      return permsList;
    } catch (e) {
      rethrow;
    }
  }
}
