part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

final class RegisterSubmitted extends RegisterEvent {
  final UserRegister userData;
  const RegisterSubmitted(this.userData);
}
