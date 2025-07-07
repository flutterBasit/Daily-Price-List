import 'package:dio/dio.dart';

class ApiServices {
  static final Dio _dio = Dio(BaseOptions(
      baseUrl: 'https://dummyjson.com/',
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      responseType: ResponseType.json));

  static Future<dynamic> get(String endpoint,
      {Map<String, dynamic>? queryparams}) async {
    try {
      final response = await _dio.get(endpoint, queryParameters: queryparams);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        throw Exception('API erroe with status code : ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
