import 'package:dio/dio.dart';

class Networkutils {
  static bool isNetworkError(dynamic error) {
    if (error is DioException) {
      return error.type == DioExceptionType.connectionError ||
          error.type == DioExceptionType.connectionError ||
          error.type == DioExceptionType.sendTimeout ||
          error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.unknown;
    }
    final errorString = error.toString();
    return errorString.contains('SocketException') ||
        errorString.contains('Network is unreachable') ||
        errorString.contains('Failed host lookup') ||
        errorString.contains('Connection refused');
  }
}
