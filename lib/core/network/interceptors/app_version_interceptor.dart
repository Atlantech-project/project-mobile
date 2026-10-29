import 'package:dio/dio.dart';

import '../../router/session_state.dart';
import '../api_contract.dart';

/// Sends the app version. On 426 marks the session as needing an
/// update, so the router blocks everything with P-57.
class AppVersionInterceptor extends Interceptor {
  AppVersionInterceptor(this._appVersion, this._session);

  final String _appVersion;
  final SessionState _session;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers[ApiHeaders.appVersion] = _appVersion;
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final response = err.response;
    if (response?.statusCode == 426 && !_session.updateRequired) {
      final body = response?.data;
      final minVersion = body is Map
          ? body[ApiErrorFields.minAppVersion]
          : null;
      _session.setUpdateRequired(
        true,
        minAppVersion: minVersion is String && minVersion.isNotEmpty
            ? minVersion
            : null,
      );
    }
    handler.next(err);
  }
}
