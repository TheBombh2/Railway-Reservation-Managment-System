import 'package:bloc/bloc.dart';
import 'package:employee_frontend/data/model/citation.dart';
import 'package:employee_frontend/data/repositories/authentication_repository.dart';
import 'package:employee_frontend/data/repositories/employee_repository.dart';
import 'package:meta/meta.dart';

part 'citations_event.dart';
part 'citations_state.dart';

class CitationsBloc extends Bloc<CitationsEvent, CitationsState> {
  final EmployeeRepository employeeRepository;
  final AuthenticationRepository authenticationRepository;
  CitationsBloc(
      {required this.employeeRepository,
      required this.authenticationRepository})
      : super(CitationsInitial()) {
    on<LoadCitations>(_onLoadCitations);
  }


  Future<void> _onLoadCitations(
    LoadCitations event,
    Emitter<CitationsState> emit,
  ) async {
    emit(CitationsLoading());
    try {
      var list = await employeeRepository.getAllCitations(
          await authenticationRepository.getUuid(),
          authenticationRepository.getSessionToken());
      emit(CitationsLoaded(list));
    } catch (e) {
      emit(CitationsError(message: e.toString()));
    }
  }
}
