part of 'employees_bloc.dart';

abstract class EmployeesEvent {}

class LoadEmployees extends EmployeesEvent {
  LoadEmployees();
}

class CreateEmployee extends EmployeesEvent {
  final EmployeeCreate employeeData;
  CreateEmployee(this.employeeData);
}

class AssignTask extends EmployeesEvent {}
