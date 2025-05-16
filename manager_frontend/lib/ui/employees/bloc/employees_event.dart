part of 'employees_bloc.dart';


abstract class EmployeesEvent {}

class LoadEmployees extends EmployeesEvent{
  final String sessionToken;
  LoadEmployees({required this.sessionToken});
}
class CreateEmployee extends EmployeesEvent{}

