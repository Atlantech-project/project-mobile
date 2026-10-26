import 'package:dio/dio.dart';

import '../../router/session_state.dart';
import '../api_contract.dart';
import '../token_store.dart';

/// Adds the device token as a Bearer token. On 401 clears it and signs the
/// user out, so the router returns to P-52. The Outbox is not touched.
class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._tokens, this._session);

  final TokenStore _tokens;
  final SessionState _session;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.extra[ApiExtras.skipAuth] != true) {
      final token = await _tokens.read();
      if (token != null) {
        options.headers[ApiHeaders.authorization] = 'Bearer $token';
      }
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final skipAuth = err.requestOptions.extra[ApiExtras.skipAuth] == true;
    if (err.response?.statusCode == 401 && !skipAuth) {
      await _tokens.clear();
      if (_session.isAuthenticated) _session.signOut();
    }
    handler.next(err);
  }
}
