import 'package:dio/dio.dart';


class ApiClient {
  final Dio _dio;
  final String _subdomain;
  
  ApiClient(this._dio, {String subdomain = 'employee'}) 
    : _subdomain = subdomain;

  String _buildBaseUrl() => 
    "https://rrms-$_subdomain.furious-shark-hosting.duckdns.org";

  Future<Map<String, dynamic>> getRequest(
    String endPoint, {
    Map<String, dynamic>? queryParams,
    String? sessionToken,
  }) async {
    final url = '${_buildBaseUrl()}$endPoint';
    
    final response = await _dio.get(
      url,
      queryParameters: queryParams,
      options: _buildOptions(sessionToken),
    );
    return response.data;
  }

  Future<dynamic> postRequest(
    String endPoint, {
    required Map<String, dynamic> body,
    String? sessionToken,
    ResponseType responseType = ResponseType.json,
  }) async {
    final url = '${_buildBaseUrl()}$endPoint';
    
    final response = await _dio.post(
      url,
      data: body,
      options: _buildOptions(sessionToken),
    );
    return response.data;
  }

  
  Options _buildOptions(String? sessionToken) {
    return Options(
      headers: {
        if (sessionToken != null) 
          'Authorization': 'Bearer $sessionToken',
        'Content-Type': 'application/json', 
      },
    );
  }
}