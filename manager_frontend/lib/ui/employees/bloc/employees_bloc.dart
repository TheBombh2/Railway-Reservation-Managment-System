import 'package:bloc/bloc.dart';
import 'package:manager_frontend/data/model/employee.dart';
import 'package:manager_frontend/data/repositories/employee_repository.dart';
import 'package:meta/meta.dart';

part 'employees_event.dart';
part 'employees_state.dart';

class EmployeesBloc extends Bloc<EmployeesEvent, EmployeesState> {
  final EmployeeRepository employeeRepository;
  EmployeesBloc({required this.employeeRepository})
    : super(EmployeesInitial()) {
    on<LoadEmployees>(_onLoadEmployees);
  }

  Future<void> _onLoadEmployees(
    LoadEmployees event,
    Emitter<EmployeesState> emit,
  ) async {
    emit(EmployeesLoading());
    try {
      final employees = await employeeRepository.getAllEmployeesInfo(
        event.sessionToken,
      );
      emit(EmployeesLoaded(employees: employees));
    } catch (e) {
      emit(EmployeesError(message: e.toString()));
    }
  }
}
