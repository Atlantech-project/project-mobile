import 'package:dio/dio.dart';

import '../../router/session_state.dart';
import '../api_contract.dart';
import '../token_store.dart';

/// Handles 403. `ACCOUNT_DISABLED` clears the token and signs the user out
/// with the Outbox on hold, so the router returns to P-52. Any other 403 on
/// a signed-in request (role or terminal scope) makes the router show P-20.
/// The Outbox is kept in both cases.
// TODO(MB-F4): Outbox sends in the background must not open P-20; mark them
// so this interceptor skips the redirect and the event is rejected instead.
class ForbiddenInterceptor extends Interceptor {
  ForbiddenInterceptor(this._tokens, this._session);

  final TokenStore _tokens;
  final SessionState _session;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final response = err.response;
    if (response?.statusCode == 403) {
      final body = response?.data;
      final code = body is Map ? body[ApiErrorFields.code] : null;
      final skipAuth = err.requestOptions.extra[ApiExtras.skipAuth] == true;

      if (code == ApiErrorCodes.accountDisabled) {
        await _tokens.clear();
        _session.disableAccount();
      } else if (_session.isAuthenticated && !skipAuth) {
        _session.denyAccess();
      }
    }
    handler.next(err);
  }
}
