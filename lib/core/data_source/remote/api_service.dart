import 'package:dio/dio.dart';
import 'package:market_ease/core/data_source/remote/api_config.dart';

class ApiService {
  final Dio _dio;

  ApiService()
      : _dio = Dio(
          BaseOptions(
            baseUrl: ApiEndPoints.baseUrl,
            receiveDataWhenStatusError: true,
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
          ),
        );

  Future<Response<dynamic>> paymentPost({
    required Map<String, dynamic> body,
    required String url,
    required String token,
    String? contentType,
    Map<String, dynamic>? headers,
  }) async {
    var response = await _dio.post(
      url,
      data: body,
      options: Options(
        contentType: contentType ?? Headers.formUrlEncodedContentType,
        headers: headers ??
            {
              'Authorization': 'Bearer $token',
            },
      ),
    );
    return response;
  }

  Future<Response> post({
    required String endPoint,
    required Map<String, dynamic> data,
    Map<String, dynamic>? queryParameters,
    String? token,
  }) async {
    return await _dio.post(
      endPoint,
      data: data,
      queryParameters: queryParameters,
      options: Options(
        headers: token != null ? {'token': token} : null,
      ),
    );
  }

  Future<Response> get({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    String? token,
  }) async {
    return await _dio.get(
      endPoint,
      queryParameters: queryParameters,
      options: Options(
        headers: token != null ? {'token': token} : null,
      ),
    );
  }

  Future<Response> put({
    required String endPoint,
    required Map<String, dynamic> data,
    Map<String, dynamic>? queryParameters,
    String? token,
  }) async {
    return await _dio.put(
      endPoint,
      data: data,
      queryParameters: queryParameters,
      options: Options(
        headers: token != null ? {'token': token} : null,
      ),
    );
  }

  Future<Response> delete({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    String? token,
  }) async {
    return await _dio.delete(
      endPoint,
      data: data,
      queryParameters: queryParameters,
      options: Options(
        headers: token != null ? {'token': token} : null,
      ),
    );
  }
}
