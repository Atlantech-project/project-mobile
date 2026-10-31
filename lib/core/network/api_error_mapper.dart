import 'dart:io';

import 'package:dio/dio.dart';

import '../errors/app_exception.dart';
import 'api_contract.dart';

/// Turns a [DioException] into the matching [AppException].
abstract final class ApiErrorMapper {
  static AppException map(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
        return const NetworkException(isTimeout: true);
      case DioExceptionType.badCertificate:
        return const UntrustedServerException();
      case DioExceptionType.cancel:
        return const RequestCancelledException();
      case DioExceptionType.badResponse:
        return _fromResponse(e.response);
      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        final cause = e.error;
        if (cause is HandshakeException || cause is TlsException) {
          return const UntrustedServerException();
        }
        return const NetworkException();
    }
  }

  static AppException _fromResponse(Response<dynamic>? response) {
    final body = response?.data;
    final map = body is Map ? body : const {};
    final code = _string(map[ApiErrorFields.code]);
    final messageKey = _string(map[ApiErrorFields.messageKey]);
    final detail =
        _string(map[ApiErrorFields.detail]) ??
        _string(map[ApiErrorFields.title]);

    return switch (response?.statusCode) {
      401 => UnauthorizedException(
        code: code,
        messageKey: messageKey,
        detail: detail,
      ),
      403 => ForbiddenException(
        code: code,
        messageKey: messageKey,
        detail: detail,
      ),
      404 => NotFoundException(
        code: code,
        messageKey: messageKey,
        detail: detail,
      ),
      409 => ConflictException(
        code: code,
        messageKey: messageKey,
        detail: detail,
        current: switch (map[ApiErrorFields.current]) {
          final Map<dynamic, dynamic> current => {
            for (final e in current.entries) '${e.key}': e.value,
          },
          _ => null,
        },
      ),
      422 => ValidationException(
        code: code,
        messageKey: messageKey,
        detail: detail,
        fieldErrors: _fieldErrors(map[ApiErrorFields.errors]),
      ),
      423 => LicenseReadOnlyException(
        code: code,
        messageKey: messageKey,
        detail: detail,
      ),
      426 => UpgradeRequiredException(
        code: code,
        messageKey: messageKey,
        detail: detail,
        minAppVersion: _string(map[ApiErrorFields.minAppVersion]),
      ),
      429 => TooManyAttemptsException(
        code: code,
        messageKey: messageKey,
        detail: detail,
        retryAfter: _retryAfter(response),
      ),
      503 => ServiceUnavailableException(
        code: code,
        messageKey: messageKey,
        detail: detail,
        retryAfter: _retryAfter(response),
      ),
      final status => ServerException(
        code: code,
        messageKey: messageKey,
        detail: detail,
        statusCode: status,
      ),
    };
  }

  /// `Retry-After` in seconds. The HTTP-date form is not used by the API.
  static Duration? _retryAfter(Response<dynamic>? response) {
    final value = response?.headers.value(ApiHeaders.retryAfter);
    final seconds = value == null ? null : int.tryParse(value.trim());
    return seconds == null || seconds < 0 ? null : Duration(seconds: seconds);
  }

  static String? _string(Object? value) =>
      value is String && value.isNotEmpty ? value : null;

  static Map<String, List<String>> _fieldErrors(Object? errors) {
    if (errors is! Map) return const {};
    return {
      for (final entry in errors.entries)
        '${entry.key}': switch (entry.value) {
          final List<dynamic> list => [for (final m in list) '$m'],
          final Object value => ['$value'],
          null => const <String>[],
        },
    };
  }
}
