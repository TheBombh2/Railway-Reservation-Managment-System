part of 'employees_bloc.dart';

abstract class EmployeesEvent {}

class LoadEmployees extends EmployeesEvent {
  LoadEmployees();
}

class CreateEmployee extends EmployeesEvent {
  final EmployeeCreate employeeData;
  CreateEmployee(this.employeeData);
}

class DeleteEmployee extends EmployeesEvent {
  final String employeeID;
  DeleteEmployee(this.employeeID);
}

class CreateTask extends EmployeesEvent {
  final Task taskData;
  CreateTask(this.taskData);
}

class CreateAppraisal extends EmployeesEvent {
  final Appraisal appraisalData;
  CreateAppraisal(this.appraisalData);
}

class CreateCitation extends EmployeesEvent {
  final Citation citationData;
  CreateCitation(this.citationData);
}

class CreateJob extends EmployeesEvent {
  final JobCreate jobData;
  CreateJob(this.jobData);
}

class AssignTask extends EmployeesEvent {}
