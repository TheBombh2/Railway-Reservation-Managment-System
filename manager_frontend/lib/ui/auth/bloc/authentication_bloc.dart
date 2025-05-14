import 'package:bloc/bloc.dart';
import 'package:manager_frontend/domain/models/manager.dart';
import 'package:manager_frontend/data/repositories/authentication_repositroy.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepositroy authenticationRepositroy,
  }) : _authenticationRepositroy = authenticationRepositroy,
       super(const AuthenticationState.unknown()) {
    on<AuthenticationSubscriptionRequest>(_onSubscriptionRequested);
    on<AuthenticationLogoutPressed>(_onLogoutPressed);
  }

  final AuthenticationRepositroy _authenticationRepositroy;

  Future<void> _onSubscriptionRequested(
    AuthenticationSubscriptionRequest event,
    Emitter<AuthenticationState> emit,
  ) {
    return emit.onEach(
      _authenticationRepositroy.status,
      onData: (status) async {
        switch (status) {
          case AuthenticationStatus.unauthenticated:
            return emit(const AuthenticationState.unauthenticated());
          case AuthenticationStatus.authenticated:
            final manager = await _authenticationRepositroy.getManager();
            return emit(
              manager != null
                  ? AuthenticationState.authenticated(manager)
                  : const AuthenticationState.unauthenticated(),
            );
          case AuthenticationStatus.unknown:
            return emit(const AuthenticationState.unknown());
        }
      },
      onError: addError
    );
  }

  void _onLogoutPressed(
    AuthenticationLogoutPressed event,
    Emitter<AuthenticationState> emit,
  ) {}
}
