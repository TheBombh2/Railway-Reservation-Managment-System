import 'package:dio/dio.dart';
import 'package:employee_frontend/secrets.dart';

class ApiClient {
  final Dio _dio;
  final String _subdomain;
  final int portNumber;
  final bool useIPandPort;

  ApiClient(
    this._dio, {
    String subdomain = 'employee',
    this.useIPandPort = true,
    this.portNumber = Secrets.employeePortNumber,
  }) : _subdomain = subdomain;

  String _buildBaseUrl() =>
      "https://rrms-$_subdomain.furious-shark-hosting.duckdns.org";

  String _buildIPBasedUrl() => "http://${Secrets.serverIP}:$portNumber";

  Future<dynamic> getRequest(
    String endPoint, {
    Map<String, dynamic>? queryParams,
    String? sessionToken,
  }) async {
    final url = '${useIPandPort ? _buildIPBasedUrl() : _buildBaseUrl()}$endPoint';

    final response = await _dio.get(
      url,
      queryParameters: queryParams,
      options: _buildOptions(sessionToken),
    );
    return response.data;
  }


    Future<dynamic> patchRequest(
    String endPoint, {
    Map<String, dynamic>? queryParams,
    String? sessionToken,
  }) async {
    final url = '${useIPandPort ? _buildIPBasedUrl() : _buildBaseUrl()}$endPoint';

    final response = await _dio.patch(
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
    final url = '${useIPandPort ? _buildIPBasedUrl() :_buildBaseUrl()}$endPoint';

    final response = await _dio.post(
      url,
      data: body,
      options: _buildOptions(sessionToken),
    );
    return response.data;
  }

  Future<dynamic> deleteRequest(
    String endPoint, {
    dynamic body,
    String? sessionToken,
    ResponseType responseType = ResponseType.json,
  }) async {
    final url = '${useIPandPort ? _buildIPBasedUrl() :_buildBaseUrl()}$endPoint';

    final response = await _dio.delete(
      url,
      data: body,
      options: _buildOptions(sessionToken),
    );
    return response.data;
  }

  Options _buildOptions(String? sessionToken) {
    return Options(
      headers: {
        if (sessionToken != null) 'Authorization': 'Bearer $sessionToken',
        'Content-Type': 'application/json',
      },
    );
  }
}
