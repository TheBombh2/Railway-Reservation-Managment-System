import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
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

  late Permissions permissionsList;
  DepartmentsBloc({
    required this.employeeRepository,
    required this.authenticationRepository,
  }) : super(DepartmentsInitial()) {
    on<LoadDepartments>(_onLoadDepartments);
    on<CreateDpeartment>(_onCreateDepartment);
    on<DeleteDepartment>(_onDeleteDepartment);
  }

  Future<void> _onLoadDepartments(
    LoadDepartments event,
    Emitter<DepartmentsState> emit,
  ) async {
    emit(DepartmentsLoading());
    try {
      await Future.delayed(Duration(seconds: 1));
      final departments = await employeeRepository.getAllDepartmentsInfo(
        authenticationRepository.getSessionToken(),
      );

      permissionsList = await employeeRepository.getAllPermissions(
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

  Future<void> _onDeleteDepartment(
    DeleteDepartment event,
    Emitter<DepartmentsState> emit,
  ) async {
    if (state is DepartmentsLoaded) {
      final currentState = state as DepartmentsLoaded;
      try {
        await employeeRepository.deleteDepartment(
          event.departmentID,
          authenticationRepository.getSessionToken(),
        );
        emit(DepartmentsOperationSuccess());
        add(LoadDepartments());
      } catch (e) {
        emit(DepartmentsError(message: e.toString()));
        emit(currentState);
      }
    }
  }

  Future<void> _onCreateDepartment(
    CreateDpeartment event,
    Emitter<DepartmentsState> emit,
  ) async {
    emit(DepartmentsLoading());
    try {
      List<int> subPermissions = [];
      for (var perm in permissionsList.permissions!) {
        subPermissions.add(0);
      }
      int permissionValue = 0;
      for (var perm in event.permissions) {
        permissionValue = permissionValue | perm.value!;
        final byteIndex = event.subPermissions![perm.name]!['index'];
        var subPermissionValue = 0;
        for (var subPerm in event.subPermissions[perm.name]!.entries) {
          if (subPerm.key == "index") continue;
          subPermissionValue = subPermissionValue | subPerm.value;
        }
        subPermissions[byteIndex] = subPermissionValue;
      }

      //print(subPermissions);
      //print(permissionValue);

      BigInt result = BigInt.zero;

      for (int i = 0; i < subPermissions.length; i++) {
        result |=
            BigInt.from(subPermissions[i]) <<
            (8 * (subPermissions.length - i - 1));
      }

      //print(result);

      final newDepData = event.departmentData.copyWith(
        permission: permissionValue,
        subPermission: result,
        managerID: await authenticationRepository.getUuid(),
        managerHireDate: DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
      );

      employeeRepository.createDpeartment(
        newDepData,
        authenticationRepository.getSessionToken(),
      );

      emit(DepartmentsOperationSuccess());
      add(LoadDepartments());
    } catch (e) {
      emit(DepartmentsError(message: e.toString()));
    }
  }
}
