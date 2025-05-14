import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:manager_frontend/data/repositories/authentication_repositroy.dart';
import 'package:manager_frontend/domain/models/email.dart';
import 'package:manager_frontend/domain/models/password.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required AuthenticationRepositroy authenticationRepositroy})
    : _authenticationRepositroy = authenticationRepositroy,
      super(const LoginState()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
  }
  final AuthenticationRepositroy _authenticationRepositroy;

  void _onEmailChanged(LoginEmailChanged event, Emitter<LoginState> emit) {
    final email = Email.dirty(event.email);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([state.password, email]),
      ),
    );
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([password, state.email]),
      ),
    );
  }

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emite,
  ) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        await _authenticationRepositroy.login(
          email: state.email.value,
          passwordHash: state.password.value,
        );
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } catch (_) {
        emite(state.copyWith(status: FormzSubmissionStatus.failure));
        emite(state.copyWith(status: FormzSubmissionStatus.canceled));

        
      }
    }
  }
}
