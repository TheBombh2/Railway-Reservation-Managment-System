import 'package:bloc/bloc.dart';
import 'package:manager_frontend/data/model/department.dart';
import 'package:manager_frontend/data/model/permission.dart';
import 'package:manager_frontend/data/model/subpermissionsData.dart';
import 'package:manager_frontend/data/repositories/authentication_repository.dart';
import 'package:manager_frontend/data/repositories/employee_repository.dart';
import 'package:meta/meta.dart';

part 'departments_event.dart';
part 'departments_state.dart';

class DepartmentsBloc extends Bloc<DepartmentsEvent, DepartmentsState> {
  final EmployeeRepository employeeRepository;
  final AuthenticationRepository authenticationRepository;
  DepartmentsBloc({
    required this.employeeRepository,
    required this.authenticationRepository,
  }) : super(DepartmentsInitial()) {
    on<LoadDepartments>(_onLoadDepartments);
  }

  Future<void> _onLoadDepartments(
    LoadDepartments event,
    Emitter<DepartmentsState> emit,
  ) async {
    emit(DepartmentsLoading());
    try {
      final departments = await employeeRepository.getAllDepartmentsInfo(
        authenticationRepository.getSessionToken(),
      );

      final permissionsList = await employeeRepository.getAllPermissions(
        authenticationRepository.getSessionToken(),
      );

      final subPermissionsList = await employeeRepository.getAllSubPermissions(
        authenticationRepository.getSessionToken(),
      );

      emit(
        DepartmentsLoaded(
          departmentsList: departments,
          permissionsList: permissionsList,
          subPermissionsList: subPermissionsList,
        ),
      );
    } catch (e) {
      emit(DepartmentsError(message: e.toString()));
    }
  }
}
