part of 'departments_bloc.dart';

abstract class DepartmentsEvent {}

class LoadDepartments extends DepartmentsEvent {
  LoadDepartments();
}


class CreateDpeartment extends DepartmentsEvent {
  final DepartmentCreate departmentData;
  CreateDpeartment({required this.departmentData});
}


