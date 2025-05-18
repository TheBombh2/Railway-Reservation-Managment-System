import 'package:bloc/bloc.dart';
import 'package:customer_frontend/data/model/user.dart';
import 'package:customer_frontend/data/repositories/authentication_repository.dart';



part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepositroy,
  }) : _authenticationRepositroy = authenticationRepositroy,
       super(AuthenticationState.unknown()) {
    on<AuthenticationSubscriptionRequest>(_onSubscriptionRequested);
    on<AuthenticationLogoutPressed>(_onLogoutPressed);
  }

  final AuthenticationRepository _authenticationRepositroy;

  Future<void> _onSubscriptionRequested(
    AuthenticationSubscriptionRequest event,
    Emitter<AuthenticationState> emit,
  ) {
    return emit.onEach(
      _authenticationRepositroy.status,
      onData: (status) async {
        switch (status) {
          case AuthenticationStatus.unauthenticated:
            return emit(AuthenticationState.unauthenticated());
          case AuthenticationStatus.authenticated:
            final user = await _authenticationRepositroy.getUser();
            return emit(
              user != null
                  ? AuthenticationState.authenticated(user)
                  :  AuthenticationState.unauthenticated(),
            );
          case AuthenticationStatus.unknown:
            return emit( AuthenticationState.unknown());
        }
      },
      onError: addError
    );
  }

  void _onLogoutPressed(
    AuthenticationLogoutPressed event,
    Emitter<AuthenticationState> emit,
  ) {
    _authenticationRepositroy.logOut();
  }


  
}
