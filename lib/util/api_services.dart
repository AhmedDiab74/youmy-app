import 'package:dio/dio.dart';
import 'package:merchant/util/Constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final String _baseUrl = uri;
  final Dio _dio;

  ApiService(this._dio);

  Future<Map<String, dynamic>> get({required String endPoint}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth-token') ?? '';

    var response = await _dio.get(
      '$_baseUrl$endPoint',
      options: Options(headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      }),
    );

    return response.data;
  }

Future<Response> post({
  required String endPoint,
  required dynamic data,
  String? authToken, // Add this parameter to pass the Authorization token
  Map<String, dynamic>? headers,
}) async {
  // If headers are not provided, initialize them with Content-Type and Authorization
  headers ??= {
    "Content-Type": "application/json",
    if (authToken != null) "Authorization": "Bearer $authToken",
  };

  // If headers are provided, add Authorization if authToken is available
  if (authToken != null) {
    headers["Authorization"] = "Bearer $authToken";
  }

  var response = await _dio.post(
    '$_baseUrl$endPoint',
    data: data,
    options: Options(
      headers: headers,
      validateStatus: (status) {
        return status! < 500; // Accept status codes less than 500
      },
    ),
  );

  return response;
}


  Future<Map<String, dynamic>> delete({required String endPoint}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth-token') ?? '';

    var response = await _dio.delete(
      '$_baseUrl$endPoint',
      options: Options(headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      }),
    );

    return response.data;
  }

  Future<Map<String, dynamic>> postUpdate({
    required String endPoint,
    required dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? authId = prefs.getInt('auth-id') ?? 0;

    String url = '$_baseUrl$endPoint';
    if (queryParameters != null && queryParameters.isNotEmpty) {
      url += '?${Uri(queryParameters: queryParameters).query}';
    }

    var response = await _dio.post(
      url,
      data: data,
      options: Options(headers: {
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer $authId'
      }),
    );

    return response.data;
  }
}

final apiService = ApiService(Dio());
