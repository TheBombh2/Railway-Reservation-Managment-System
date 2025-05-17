part of 'departments_bloc.dart';

abstract class DepartmentsEvent {}

class LoadDepartments extends DepartmentsEvent {
  LoadDepartments();
}

class CreateDpeartment extends DepartmentsEvent {
  final DepartmentCreate departmentData;
  final List<Permission> permissions;
  final Map<String, Map<String, dynamic>> subPermissions;
  CreateDpeartment({
    required this.departmentData,
    required this.permissions,
    required this.subPermissions,
  });
}

class DeleteDepartment extends DepartmentsEvent {
  final String departmentID;

  DeleteDepartment({required this.departmentID});
}
