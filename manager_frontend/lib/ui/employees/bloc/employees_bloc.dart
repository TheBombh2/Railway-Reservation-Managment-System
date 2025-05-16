import 'package:bloc/bloc.dart';
import 'package:manager_frontend/data/model/department.dart';
import 'package:manager_frontend/data/model/employee.dart';
import 'package:manager_frontend/data/model/job.dart';
import 'package:manager_frontend/data/repositories/authentication_repository.dart';
import 'package:manager_frontend/data/repositories/employee_repository.dart';
import 'package:meta/meta.dart';

part 'employees_event.dart';
part 'employees_state.dart';

class EmployeesBloc extends Bloc<EmployeesEvent, EmployeesState> {
  final EmployeeRepository employeeRepository;
  final AuthenticationRepository authenticationRepository;
  EmployeesBloc({required this.employeeRepository, required this.authenticationRepository})
    : super(EmployeesInitial()) {
    on<LoadEmployees>(_onLoadEmployees);
    on<CreateEmployee>(_onCreateEmployee);
  }

  Future<void> _onLoadEmployees(
    LoadEmployees event,
    Emitter<EmployeesState> emit,
  ) async {
    emit(EmployeesLoading());
    try {
      final employees = await employeeRepository.getAllEmployeesInfo(
        authenticationRepository.getSessionToken(),
      );
      final departments = await employeeRepository.getAllDepartmentsInfo(authenticationRepository.getSessionToken());
      final jobs = await employeeRepository.getAllJobsInfo(authenticationRepository.getSessionToken());
      emit(EmployeesLoaded(employees: employees,departments: departments,jobs: jobs));
    } catch (e) {
      emit(EmployeesError(message: e.toString()));
    }
  }

  Future<void> _onCreateEmployee(CreateEmployee event,Emitter<EmployeesState> emit) async{
    if(state is EmployeesLoaded){
        final currentState = state as EmployeesLoaded;
      try{
        await employeeRepository.createEmployee(event.employeeData,authenticationRepository.getSessionToken());
        emit(EmployeeOperationSuccess());
        add(LoadEmployees());
      }
      catch(e){
        emit(EmployeesError(message: e.toString()));
        emit(currentState);

      }
    }
  }
}
