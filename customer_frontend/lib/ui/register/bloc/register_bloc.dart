import 'package:bloc/bloc.dart';
import 'package:customer_frontend/data/model/user.dart';
import 'package:customer_frontend/data/repositories/authentication_repository.dart';
import 'package:meta/meta.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc({required AuthenticationRepository authenticationRepositroy})
    : _authenticationRepositroy = authenticationRepositroy,
      super(RegisterInital()) {
    on<RegisterSubmitted>(_onSubmitted);
  }
  final AuthenticationRepository _authenticationRepositroy;

  Future<void> _onSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterLoading());
    try {
      await _authenticationRepositroy.createUser(data: event.userData);
      emit(RegisterCompleted());
    } catch (e) {
      print(e.toString());
    }
  }
}
