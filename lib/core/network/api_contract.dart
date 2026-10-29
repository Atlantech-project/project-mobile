// Everything the server must agree on lives in this file.
// Source: ATLANTECH Team Contracts, CT-01 (API conventions) and CT-04 (mobile
// sign-in and system info).

/// Paths under [AppConfig.baseUrl] (`/api/v1`).
abstract final class ApiPaths {
  /// Health check. No token. Any 2xx means the port server is reachable.
  // TODO(CT-04): not in CT-04 yet; taken from the sync sequence diagram
  // (`GET /system/ping`). Confirm with the Backend team.
  static const String ping = '/system/ping';
}

/// Mobile request headers (CT-01).
abstract final class ApiHeaders {
  static const String authorization = 'Authorization';
  static const String appVersion = 'X-App-Version';
  static const String deviceId = 'X-Device-Id';

  /// On every mobile write.
  static const String idempotencyKey = 'Idempotency-Key';
}

/// Fields of an error body (CT-01, RFC 9457), for example:
/// `{"status": 409, "code": "VERSION_CONFLICT",
///   "message_key": "errors.version_conflict", "detail": "...",
///   "current": {"id": 12, "version": "..."}}`.
abstract final class ApiErrorFields {
  static const String code = 'code';
  static const String messageKey = 'message_key';
  static const String detail = 'detail';
  static const String title = 'title';

  /// 422: `{"field": ["errors.some.key"]}`.
  static const String errors = 'errors';

  /// 409: the server's current `id` and `version`.
  static const String current = 'current';

  /// 426 (CT-04).
  static const String minAppVersion = 'min_app_version';
}

/// Error `code` values the app acts on (CT-01).
abstract final class ApiErrorCodes {
  /// 403: the account was deactivated.
  static const String accountDisabled = 'ACCOUNT_DISABLED';
}

/// Keys a caller can put in `Options.extra` to steer the interceptors.
abstract final class ApiExtras {
  /// `true`: send no token and skip the 401 sign-out (system info, ping,
  /// login).
  static const String skipAuth = 'skipAuth';

  /// The idempotency key to send. The Outbox passes the key it stored so a
  /// resent event keeps the same one.
  static const String idempotencyKey = 'idempotencyKey';
}
