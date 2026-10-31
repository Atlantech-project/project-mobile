import 'dart:math';

import 'package:dio/dio.dart';

import '../api_contract.dart';

/// Gives every write (POST, PUT, PATCH, DELETE) an idempotency key so the
/// server applies it once, however often it is resent.
///
/// Skips [ApiPaths.withoutIdempotencyKey] (`/sync/events`,
/// `/auth/mobile/login`, `/broadcasting/auth`, CT-01 section 4).
///
/// The key comes from `extra[ApiExtras.idempotencyKey]` when the caller has
/// one, otherwise a new UUID v4. The key is written back to `extra` so a
/// retry of the same request reuses it.
class IdempotencyInterceptor extends Interceptor {
  IdempotencyInterceptor({Random? random})
    : _random = random ?? Random.secure();

  static const _writeMethods = {'POST', 'PUT', 'PATCH', 'DELETE'};

  final Random _random;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (_writeMethods.contains(options.method.toUpperCase()) &&
        !_isExcluded(options)) {
      final key =
          options.extra[ApiExtras.idempotencyKey] as String? ?? _uuidV4();
      options.extra[ApiExtras.idempotencyKey] = key;
      options.headers[ApiHeaders.idempotencyKey] = key;
    }
    handler.next(options);
  }

  bool _isExcluded(RequestOptions options) {
    final path = options.uri.path;
    return ApiPaths.withoutIdempotencyKey.any(path.endsWith);
  }

  String _uuidV4() {
    final bytes = List<int>.generate(16, (_) => _random.nextInt(256));
    bytes[6] = (bytes[6] & 0x0f) | 0x40;
    bytes[8] = (bytes[8] & 0x3f) | 0x80;
    final hex = bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
    return '${hex.substring(0, 8)}-${hex.substring(8, 12)}-'
        '${hex.substring(12, 16)}-${hex.substring(16, 20)}-${hex.substring(20)}';
  }
}
