import 'package:bookia/core/services/dio/apis.dart';
import 'package:dio/dio.dart';

class DioProvider {
  static late Dio dio;

  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: Apis.baseUrl,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      ),
    );
  }

  static Future<Response> postApi({
    required String endpoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
  }) {
    return dio.post(
      endpoint,
      data: data,
      options: Options(headers: headers),
      queryParameters: params,
    );
  }

  static Future<Response> getApi({
    required String endpoint,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
  }) {
    return dio.get(
      endpoint,
      options: Options(headers: headers),
      queryParameters: params,
    );
  }

  static Future<Response> putApi({
    required String endpoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
  }) {
    return dio.put(
      endpoint,
      data: data,
      options: Options(headers: headers),
      queryParameters: params,
    );
  }

  static Future<Response> deleteApi({
    required String endpoint,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
  }) {
    return dio.delete(
      endpoint,
      options: Options(headers: headers),
      queryParameters: params,
    );
  }

  static Future<Response> patchApi({
    required String endpoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
  }) {
    return dio.patch(
      endpoint,
      data: data,
      options: Options(headers: headers),
      queryParameters: params,
    );
  }
}
