part of 'authentication_bloc.dart';

class AuthenticationState {
  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    required this.manager,
  });

  AuthenticationState.unknown() : this._(manager: User.empty());

  const AuthenticationState.authenticated(User manager)
    : this._(status: AuthenticationStatus.authenticated, manager: manager);

  AuthenticationState.unauthenticated()
    : this._(
        status: AuthenticationStatus.unauthenticated,
        manager: User.empty(),
      );

  final AuthenticationStatus status;
  final User manager;

  List<Object> get props => [status, manager];
}
