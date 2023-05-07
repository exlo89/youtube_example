import 'package:dio/dio.dart';

class ApiHandler {
  static final ApiHandler _singleton = ApiHandler._internal();
  final Dio _dio = Dio();

  factory ApiHandler() => _singleton;

  ApiHandler._internal() {
    _dio.options.baseUrl = 'https://www.thecocktaildb.com';
  }

  /// Return a [Response] from a GET request with [route].
  Future<Response<dynamic>> get(
    String route, {
    Map<String, dynamic> queryParameters = const {},
  }) async {
    try {
      return await _dio.get(
        route,
        queryParameters: queryParameters,
      );
    } catch (error) {
      throw 'Something went wrong';
    }
  }

}
