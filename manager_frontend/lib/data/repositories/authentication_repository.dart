import 'dart:async';

import 'package:manager_frontend/data/model/manager.dart';
import 'package:manager_frontend/data/services/authentication_service.dart';
import 'package:manager_frontend/data/services/employee_service.dart';
import 'package:manager_frontend/secrets.dart';
import 'package:manager_frontend/utility/hashing_utility.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  AuthenticationRepository({
    required AuthenticationService authenticationService,
    required EmployeeService employeeService,
  }) : _authenticationService = authenticationService,
       _employeeService = employeeService;

  final AuthenticationService _authenticationService;
  final EmployeeService _employeeService;
  final _controller = StreamController<AuthenticationStatus>();
  Manager? _manager;
  late String _sessionToken;

  Stream<AuthenticationStatus> get status async* {
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> login({required String email, required String password}) async {
    try {
      //Should get salt with specific employee when endpoint is ready
      final passwordSalt = Secrets.rootManagerPasswordSalt;
      final passwordHash = HashingUtility.hashWithSHA256(
        password + passwordSalt,
      );

      _sessionToken = await _authenticationService.login(email, passwordHash);

      final managerData = await _employeeService.getAllEmployeeInfo(
        _sessionToken,
      );
      _manager = Manager.fromJson(managerData);
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

  Future<Manager?> getManager() async {
    if (_manager != null) return _manager;
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  String getSessionToken() {
    return _sessionToken;
  }

  void dispose() => _controller.close();
}
