part of 'employees_bloc.dart';

@immutable
sealed class EmployeesState {}

final class EmployeesInitial extends EmployeesState {}

final class EmployeesLoading extends EmployeesState {}

class EmployeesLoaded extends EmployeesState {
  final EmployeeList employees;
  final DepartmentsList departments;
  final JobsList jobs;

  EmployeesLoaded({required this.employees,required this.departments, required this.jobs});

  EmployeesLoaded copyWith({
    EmployeeList? employees,
    DepartmentsList? departments,
    JobsList? jobs,
    String? filter,
    String? sortBy,
  }) {
    return EmployeesLoaded(
      employees: employees ?? this.employees,
      departments: departments ?? this.departments,
      jobs: jobs?? this.jobs
    );
  }
}

class EmployeeOperationSuccess extends EmployeesState{}

class EmployeesError extends EmployeesState {
  final String message;
  EmployeesError({required this.message});
  @override
  List<Object> get props => [message];
}
