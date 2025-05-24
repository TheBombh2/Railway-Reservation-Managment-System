import 'dart:async';

import 'package:customer_frontend/data/model/user.dart';
import 'package:customer_frontend/data/services/authentication_service.dart';
import 'package:customer_frontend/data/services/customer_service.dart';
import 'package:customer_frontend/secrets.dart';
import 'package:customer_frontend/utility/hashing_utility.dart';





enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  AuthenticationRepository({
    required AuthenticationService authenticationService,
    required CustomerService customerService,
  }) : _authenticationService = authenticationService,
       _customerService = customerService;

  final AuthenticationService _authenticationService;
  final CustomerService _customerService;
  final _controller = StreamController<AuthenticationStatus>();
  User? _user;
  late String _sessionToken;

  Stream<AuthenticationStatus> get status async* {
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> login({required String email, required String password}) async {
    try {
      //Should get salt with specific employee when endpoint is ready
      final passwordSalt = await _authenticationService.getSalt(email);
      final passwordHash = HashingUtility.hashWithSHA256(
        password + passwordSalt,
      );

      _sessionToken = await _authenticationService.login(email, passwordHash);

      final userData = await _customerService.getAllCustomerInfo(
        _sessionToken,
      );
      _user = User.fromJson(userData);
      //Here we should get manager info using session token but for now we will use a placeholder manager
      _controller.add(AuthenticationStatus.authenticated);
    } catch (e) {
      _controller.add(AuthenticationStatus.unauthenticated);
      rethrow;
    }
  }

  Future<String> getUuid() async {
    try {
      
      final uuid = await _authenticationService.getUuid(_sessionToken);
      return uuid;
      
    } catch (e) {
      rethrow;
    }
  }

  Future<User?> getUser() async {
    if (_user != null) return _user;
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  String getSessionToken() {
    return _sessionToken;
  }

  void dispose() => _controller.close();
}
