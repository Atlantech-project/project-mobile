import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';

import '../config/app_config.dart';
import '../errors/app_exception.dart';
import 'api_contract.dart';
import 'api_date_time.dart';
import 'api_error_mapper.dart';

/// The app's only HTTP client. Repositories call it; Cubits never do.
///
/// Every failure is thrown as an [AppException], never a Dio type. Pass
/// `authenticated: false` for calls made before sign-in, and `idempotencyKey`
/// when the caller retries a write it already sent. Datetimes in a body go
/// through [ApiDateTime.format].
class DioClient {
  DioClient({
    required SecurityContext securityContext,
    required List<Interceptor> interceptors,
    String baseUrl = AppConfig.baseUrl,
  }) : _dio = Dio(
         BaseOptions(
           baseUrl: baseUrl,
           connectTimeout: AppConfig.connectTimeout,
           sendTimeout: AppConfig.sendTimeout,
           receiveTimeout: AppConfig.receiveTimeout,
           contentType: Headers.jsonContentType,
           responseType: ResponseType.json,
           headers: {HttpHeaders.acceptHeader: Headers.jsonContentType},
         ),
       ) {
    // Never accept a certificate the Root CA did not sign.
    _dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () => HttpClient(context: securityContext),
    );
    _dio.interceptors.addAll(interceptors);
    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(
          requestHeader: false,
          requestBody: false,
          responseHeader: false,
          responseBody: true,
          logPrint: (line) => debugPrint('$line'),
        ),
      );
    }
  }

  final Dio _dio;

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? query,
    bool authenticated = true,
    CancelToken? cancelToken,
  }) => _send(
    () => _dio.get<T>(
      path,
      queryParameters: query,
      options: _options(authenticated: authenticated),
      cancelToken: cancelToken,
    ),
  );

  Future<Response<T>> post<T>(
    String path, {
    Object? data,
    bool authenticated = true,
    String? idempotencyKey,
    CancelToken? cancelToken,
  }) => _send(
    () => _dio.post<T>(
      path,
      data: data,
      options: _options(
        authenticated: authenticated,
        idempotencyKey: idempotencyKey,
      ),
      cancelToken: cancelToken,
    ),
  );

  Future<Response<T>> put<T>(
    String path, {
    Object? data,
    String? idempotencyKey,
    CancelToken? cancelToken,
  }) => _send(
    () => _dio.put<T>(
      path,
      data: data,
      options: _options(idempotencyKey: idempotencyKey),
      cancelToken: cancelToken,
    ),
  );

  Future<Response<T>> patch<T>(
    String path, {
    Object? data,
    String? idempotencyKey,
    CancelToken? cancelToken,
  }) => _send(
    () => _dio.patch<T>(
      path,
      data: data,
      options: _options(idempotencyKey: idempotencyKey),
      cancelToken: cancelToken,
    ),
  );

  Future<Response<T>> delete<T>(
    String path, {
    Object? data,
    String? idempotencyKey,
    CancelToken? cancelToken,
  }) => _send(
    () => _dio.delete<T>(
      path,
      data: data,
      options: _options(idempotencyKey: idempotencyKey),
      cancelToken: cancelToken,
    ),
  );

  /// `true` when the port server answers `GET /system/info` in time. This
  /// is the connection check: there is no `/system/ping` (CT-04, DEC-58).
  /// No token, and the server never answers it with 426. Never throws.
  Future<bool> checkConnection() async {
    try {
      final response = await _dio.get<dynamic>(
        ApiPaths.systemInfo,
        options: _options(authenticated: false).copyWith(
          sendTimeout: AppConfig.connectionCheckTimeout,
          receiveTimeout: AppConfig.connectionCheckTimeout,
        ),
      );
      final status = response.statusCode ?? 0;
      return status >= 200 && status < 300;
    } on DioException {
      return false;
    }
  }

  Options _options({bool authenticated = true, String? idempotencyKey}) =>
      Options(
        extra: {
          ApiExtras.skipAuth: !authenticated,
          ApiExtras.idempotencyKey: ?idempotencyKey,
        },
      );

  Future<Response<T>> _send<T>(Future<Response<T>> Function() request) async {
    try {
      return await request();
    } on DioException catch (e) {
      throw ApiErrorMapper.map(e);
    }
  }
}
