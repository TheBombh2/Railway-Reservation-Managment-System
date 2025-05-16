import 'package:dio/dio.dart';
import 'package:manager_frontend/data/services/api_client.dart';

class AuthenticationService {
  final ApiClient _apiClient;

  AuthenticationService(Dio dio)
    : _apiClient = ApiClient(dio, subdomain: 'authorization');

  Future<String> login(String email, String passwordHash) async {
    // simulate recieving session token
    //return Secrets.rootSessionToken;

    try {
      final response = await _apiClient.postRequest(
        '/login/employee',
        body: {'email': email, 'passwordHash': passwordHash},
        responseType: ResponseType.plain,
      );

      return response;
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        case 404:
          throw 'Email or password are invalid';
        default:
          throw 'Something went wrong.';
      }
    }
    
  }

   Future<String> getUuid(String sessionToken) async {
    // simulate recieving session token
    //return Secrets.rootSessionToken;

    try {
      final response = await _apiClient.getRequest(
        '/users/uuid',
        sessionToken: sessionToken
      );

      return response;
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        
        default:
          throw 'Something went wrong.';
      }
    }
    
  }

  Future<void> logout() async {
    /*try {
      final response = await _apiClient.postRequest(
        '/login/employee',
        body: {'email': email, 'passwordHash': passwordHash},
        responseType: ResponseType.plain,
      );

      return response;
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        case 404:
          throw 'Email or password are invalid';
        default:
          throw 'Something went wrong.';
      }
    }
  
  */
}

}
