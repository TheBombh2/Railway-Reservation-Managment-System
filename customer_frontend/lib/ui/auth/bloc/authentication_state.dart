part of 'authentication_bloc.dart';

class AuthenticationState {
  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    required this.user,
  });

  AuthenticationState.unknown() : this._(user: User.empty());

  const AuthenticationState.authenticated(User user)
    : this._(status: AuthenticationStatus.authenticated, user: user);

  AuthenticationState.unauthenticated()
    : this._(
        status: AuthenticationStatus.unauthenticated,
        user: User.empty(),
      );

  final AuthenticationStatus status;
  final User user;

  List<Object> get props => [status, user];
}
