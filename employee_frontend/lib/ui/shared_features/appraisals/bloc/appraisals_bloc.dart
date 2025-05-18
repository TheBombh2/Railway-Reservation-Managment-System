import 'package:bloc/bloc.dart';
import 'package:employee_frontend/data/model/appraisal.dart';
import 'package:employee_frontend/data/repositories/authentication_repository.dart';
import 'package:employee_frontend/data/repositories/employee_repository.dart';
import 'package:employee_frontend/ui/shared_features/appraisals/widgets/appraisals_list.dart';
import 'package:meta/meta.dart';

part 'appraisals_event.dart';
part 'appraisals_state.dart';

class AppraisalsBloc extends Bloc<AppraisalsEvent, AppraisalsState> {
  final EmployeeRepository employeeRepository;
  final AuthenticationRepository authenticationRepository;
  AppraisalsBloc(
      {required this.employeeRepository,
      required this.authenticationRepository})
      : super(AppraisalsInitial()) {
    on<LoadAppraisals>(_onLoadAppraisals);
  }

  Future<void> _onLoadAppraisals(
    LoadAppraisals event,
    Emitter<AppraisalsState> emit,
  ) async {
    emit(AppraisalsLoading());
    try {
      var list = await employeeRepository.getAllAppraisals(
          await authenticationRepository.getUuid(),
          authenticationRepository.getSessionToken());
      emit(AppraisalsLoaded(list));
    } catch (e) {
      emit(AppraisalsError(message: e.toString()));
    }
  }
}
