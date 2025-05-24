import 'package:bloc/bloc.dart';
import 'package:employee_frontend/data/model/task.dart';
import 'package:employee_frontend/data/repositories/authentication_repository.dart';
import 'package:employee_frontend/data/repositories/employee_repository.dart';
import 'package:meta/meta.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final EmployeeRepository employeeRepository;
  final AuthenticationRepository authenticationRepository;
  TasksBloc(
      {required this.employeeRepository,
      required this.authenticationRepository})
      : super(TasksInitial()) {
    on<LoadTasks>(_onLoadTasks);
    on<CompleteTask>(_onCompleteTask);
  }

  Future<void> _onLoadTasks(
    LoadTasks event,
    Emitter<TasksState> emit,
  ) async {
    emit(TasksLoading());
    try {
      var tasksList = await employeeRepository
          .getAllTasks(authenticationRepository.getSessionToken());
      emit(TasksLoaded(tasksList));
    } catch (e) {
      emit(TasksError(message: e.toString()));
    }
  }

  Future<void> _onCompleteTask(
    CompleteTask event,
    Emitter<TasksState> emit,
  ) async {
    emit(TasksLoading());
    try {
      await employeeRepository.completeTask(
          taskID: event.taskID,
          sessionToken: authenticationRepository.getSessionToken());
      emit(TasksOperationSuccess());
    } catch (e) {
      emit(TasksError(message: e.toString()));
    }
  }
}
