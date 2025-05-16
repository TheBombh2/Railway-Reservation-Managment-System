part of 'departments_bloc.dart';

@immutable
sealed class DepartmentsState {}

final class DepartmentsInitial extends DepartmentsState {}

final class DepartmentsLoading extends DepartmentsState {}

class DepartmentsLoaded extends DepartmentsState {
  final DepartmentsList departmentsList;
  DepartmentsLoaded({required this.departmentsList});

  DepartmentsLoaded copyWith({DepartmentsList? departments}) {
    return DepartmentsLoaded(
      departmentsList: departments ?? this.departmentsList,
    );
  }
}

class DepartmentsError extends DepartmentsState {
  final String message;
  DepartmentsError({required this.message});
  @override
  List<Object> get props => [message];
}
