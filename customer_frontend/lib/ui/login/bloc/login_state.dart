part of 'login_bloc.dart';

final class LoginState {
  const LoginState({
    this.status = FormzSubmissionStatus.initial,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.isValid = false,
    this.failureReason = "",
  });

  final FormzSubmissionStatus status;
  final Email email;
  final Password password;
  final bool isValid;
  final String failureReason;

  LoginState copyWith({
    FormzSubmissionStatus? status,
    Email? email,
    Password? password,
    bool? isValid,
    String? failureReason,
  }) {
    return LoginState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      isValid: isValid ?? this.isValid,
      failureReason: failureReason ?? this.failureReason,
    );
  }

  @override
  List<Object> get props => [status, email, password];
}
