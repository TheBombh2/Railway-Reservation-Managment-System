import 'package:customer_frontend/data/model/user.dart';
import 'package:customer_frontend/data/services/api_client.dart';
import 'package:customer_frontend/secrets.dart';
import 'package:dio/dio.dart';


class AuthenticationService {
  final ApiClient _apiClient;

  AuthenticationService(Dio dio)
    : _apiClient = ApiClient(dio, subdomain: 'authorization',portNumber: Secrets.authorizationPortNumber);

  Future<String> login(String email, String passwordHash) async {
    // simulate recieving session token
    //return Secrets.rootSessionToken;

    try {
      final response = await _apiClient.postRequest(
        '/login/customer',
        body: {'email': email, 'passwordHash': passwordHash},
        responseType: ResponseType.plain,
      );

      return response;
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        case 404:
          throw 'Email or password are invalid';
        default:
        print(e.toString());
          throw 'Something went wrong.';
      }
    }
    
  }



    Future<void> createUser(dynamic data) async {
    // simulate recieving session token
    //return Secrets.rootSessionToken;

    try {
      final response = await _apiClient.postRequest(
        '/users/create/customer',
        body: data,
        responseType: ResponseType.plain,
      );

      return response;
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        case 404:
          throw 'Email or password are invalid';
        default:
        print(e.toString());
          throw 'Something went wrong.';
      }
    }
    
  }




  Future<String> getSalt(String email) async {
   

    try {
      final response = await _apiClient.getRequest(
        '/users/$email/customer/salt',
      );

      return response;
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        default:
          throw 'Something went wrong.';
      }
    }
  }

  Future<String> getNewSalt() async {
  
    try {
      final response = await _apiClient.getRequest(
        '/utility/salt',
      );

      return response;
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
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
