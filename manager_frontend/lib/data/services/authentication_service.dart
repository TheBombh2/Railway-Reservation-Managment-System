import 'package:dio/dio.dart';
import 'package:manager_frontend/data/services/api_client.dart';

class AuthenticationService {
  final ApiClient _apiClient;

  AuthenticationService(Dio dio)
    : _apiClient = ApiClient(dio, subdomain: 'authorization');

  Future<String> login(String email, String passwordHash) async {
    try {
      final response = await _apiClient.postRequest(
        '/login/employee',
        body: {'email': email, 'passwordHash': passwordHash},
        responseType: ResponseType.plain
      );

      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
