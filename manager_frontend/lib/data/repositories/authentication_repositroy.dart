import 'dart:async';

import 'package:manager_frontend/data/services/authentication_service.dart';
import 'package:manager_frontend/domain/models/manager.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepositroy {
  AuthenticationRepositroy({
    required AuthenticationService authenticationService,
  }) : _authenticationService = authenticationService;

  final AuthenticationService _authenticationService;
  final _controller = StreamController<AuthenticationStatus>();
  Manager? _manager;

  Stream<AuthenticationStatus> get status async* {
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> login({
    required String email,
    required String passwordHash,
  }) async {
    try {
      final sessionToken = await _authenticationService.login(
        email,
        passwordHash,
      );
      _manager = Manager(sessionToken);
      //Here we should get manager info using session token but for now we will use a placeholder manager
      _controller.add(AuthenticationStatus.authenticated);
    } catch (e) {
      _controller.add(AuthenticationStatus.unauthenticated);
      throw Exception(e.toString());
    }
  }

  Future<Manager?> getManager() async {
    if (_manager != null) return _manager;
  }

  void dispose() => _controller.close();
}
