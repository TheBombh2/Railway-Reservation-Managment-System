part of 'authentication_bloc.dart';

class AuthenticationState {
  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    required this.manager,
  });

  AuthenticationState.unknown() : this._(manager: Manager.empty());

  const AuthenticationState.authenticated(Manager manager)
    : this._(status: AuthenticationStatus.authenticated, manager: manager);

  AuthenticationState.unauthenticated()
    : this._(
        status: AuthenticationStatus.unauthenticated,
        manager: Manager.empty(),
      );

  final AuthenticationStatus status;
  final Manager manager;

  List<Object> get props => [status, manager];
}
