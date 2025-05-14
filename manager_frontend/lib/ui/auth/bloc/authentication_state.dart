part of 'authentication_bloc.dart';

class AuthenticationState {
  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.manager = Manager.empty,
  });

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(Manager manager)
    : this._(status: AuthenticationStatus.authenticated, manager: manager);

  const AuthenticationState.unauthenticated()
    : this._(status: AuthenticationStatus.unauthenticated);

  final AuthenticationStatus status;
  final Manager manager;

  List<Object> get props => [status, manager];
}
