part of 'departments_bloc.dart';

@immutable
sealed class DepartmentsState {}

final class DepartmentsInitial extends DepartmentsState {}

final class DepartmentsLoading extends DepartmentsState {}

class DepartmentsLoaded extends DepartmentsState {
  final DepartmentsList departmentsList;
  final Permissions permissionsList;
  final SubPermissionsData subPermissionsList;
  DepartmentsLoaded({
    required this.permissionsList,
    required this.subPermissionsList,
    required this.departmentsList,
  });

  DepartmentsLoaded copyWith({
    DepartmentsList? departments,
    Permissions? permissions,
    SubPermissionsData? subPermissions,
  }) {
    return DepartmentsLoaded(
      departmentsList: departments ?? this.departmentsList,
      permissionsList: permissions ?? this.permissionsList,
      subPermissionsList: subPermissions ?? this.subPermissionsList,
    );
  }
}

class DepartmentsOperationSuccess extends DepartmentsState {}

class DepartmentsError extends DepartmentsState {
  final String message;
  DepartmentsError({required this.message});
  @override
  List<Object> get props => [message];
}
