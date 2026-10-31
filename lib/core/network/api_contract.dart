// Everything the server must agree on lives in this file.
// Source: ATLANTECH Team Contracts, CT-01 (API conventions and error codes),
// CT-04 v1.1 (mobile sign-in and system info), CT-06 and CT-07.

/// Paths under [AppConfig.baseUrl] (`/api/v1`).
abstract final class ApiPaths {
  /// Port identity and `min_app_version`. No token, never refused with 426.
  /// Also the connection check: there is no `/system/ping` (CT-04, DEC-58).
  static const String systemInfo = '/system/info';

  /// Mobile sign-in (CT-04). No `Idempotency-Key`.
  static const String mobileLogin = '/auth/mobile/login';

  /// Outbox upload (CT-07). Uses `client_event_id`, not `Idempotency-Key`.
  static const String syncEvents = '/sync/events';

  /// Private channel authorisation (CT-06). No `Idempotency-Key`.
  static const String broadcastingAuth = '/broadcasting/auth';

  /// Writes that never carry an `Idempotency-Key` (CT-01 section 4).
  static const Set<String> withoutIdempotencyKey = {
    syncEvents,
    mobileLogin,
    broadcastingAuth,
  };
}

/// Mobile request headers (CT-01).
abstract final class ApiHeaders {
  static const String authorization = 'Authorization';
  static const String appVersion = 'X-App-Version';
  static const String deviceId = 'X-Device-Id';

  /// On every mobile write except [ApiPaths.withoutIdempotencyKey].
  static const String idempotencyKey = 'Idempotency-Key';

  /// Seconds to wait, on 429 and sometimes on 503.
  static const String retryAfter = 'Retry-After';
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

/// Error `code` values the app acts on (CT-01 error catalogue). Branch on
/// these, never on `detail`.
abstract final class ApiErrorCodes {
  /// 403: the account was deactivated.
  static const String accountDisabled = 'ACCOUNT_DISABLED';

  /// 403: the user must change the password before anything else.
  static const String passwordChangeRequired = 'PASSWORD_CHANGE_REQUIRED';

  /// 429: sign-in or password-change throttling, with `Retry-After`.
  static const String tooManyAttempts = 'TOO_MANY_ATTEMPTS';
}

/// Keys a caller can put in `Options.extra` to steer the interceptors.
abstract final class ApiExtras {
  /// `true`: send no token and skip the 401 sign-out (system info, login).
  static const String skipAuth = 'skipAuth';

  /// The idempotency key to send. A caller that retries the same write
  /// passes the key it stored so the retry keeps the same one.
  static const String idempotencyKey = 'idempotencyKey';
}
