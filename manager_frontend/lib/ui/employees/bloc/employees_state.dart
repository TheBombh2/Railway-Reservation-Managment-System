part of 'employees_bloc.dart';

@immutable
sealed class EmployeesState {}

final class EmployeesInitial extends EmployeesState {}

final class EmployeesLoading extends EmployeesState {}

class EmployeesLoaded extends EmployeesState {
  final EmployeeList employees;

  EmployeesLoaded({required this.employees});
}

class EmployeesError extends EmployeesState {
  final String message;
  EmployeesError({required this.message});
  @override
  List<Object> get props => [message];
}
