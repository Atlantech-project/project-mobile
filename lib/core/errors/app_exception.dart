/// Every failure a Repository can get from the network layer.
///
/// [DioClient] turns each Dio error into one of these, so Repositories and
/// Cubits never see Dio types. Server errors follow CT-01 (RFC 9457):
/// [code] is the stable machine code (`ACCOUNT_DISABLED`, `VERSION_CONFLICT`,
/// …), [messageKey] the translation key the app shows (`errors.account_disabled`)
/// and [detail] the server's own English text, for logs only.
sealed class AppException implements Exception {
  const AppException({
    this.code,
    this.messageKey,
    this.detail,
    this.statusCode,
  });

  final String? code;
  final String? messageKey;
  final String? detail;
  final int? statusCode;

  @override
  String toString() =>
      '$runtimeType(status: $statusCode, code: $code, key: $messageKey, '
      'detail: $detail)';
}

/// 401: no valid token, or it expired or was revoked. The user is signed out
/// and must sign in again; the Outbox is kept.
final class UnauthorizedException extends AppException {
  const UnauthorizedException({super.code, super.messageKey, super.detail})
    : super(statusCode: 401);
}

/// 403: the role or terminal scope does not allow this, or the account is
/// disabled (`ACCOUNT_DISABLED`).
final class ForbiddenException extends AppException {
  const ForbiddenException({super.code, super.messageKey, super.detail})
    : super(statusCode: 403);

  bool get isAccountDisabled => code == 'ACCOUNT_DISABLED';
}

/// 409: the record changed on the server (stale `version`) or a business
/// rule conflicts with the current state. [current] is the server's copy
/// (`id` and `version`) when it sent one.
final class ConflictException extends AppException {
  const ConflictException({
    super.code,
    super.messageKey,
    super.detail,
    this.current,
  }) : super(statusCode: 409);

  final Map<String, dynamic>? current;
}

/// 422: invalid input. [fieldErrors] maps a field name to its message keys.
final class ValidationException extends AppException {
  const ValidationException({
    super.code,
    super.messageKey,
    super.detail,
    this.fieldErrors = const {},
  }) : super(statusCode: 422);

  final Map<String, List<String>> fieldErrors;
}

/// 423: the port licence is read-only, so new writes are refused.
final class LicenseReadOnlyException extends AppException {
  const LicenseReadOnlyException({super.code, super.messageKey, super.detail})
    : super(statusCode: 423);
}

/// 426 (`APP_UPDATE_REQUIRED`): the app is below [minAppVersion]. The router
/// moves to P-57.
final class UpgradeRequiredException extends AppException {
  const UpgradeRequiredException({
    super.code,
    super.messageKey,
    super.detail,
    this.minAppVersion,
  }) : super(statusCode: 426);

  final String? minAppVersion;
}

/// 503: the port server is up but not serving right now.
final class ServiceUnavailableException extends AppException {
  const ServiceUnavailableException({
    super.code,
    super.messageKey,
    super.detail,
  }) : super(statusCode: 503);
}

/// Any other HTTP error status.
final class ServerException extends AppException {
  const ServerException({
    super.code,
    super.messageKey,
    super.detail,
    super.statusCode,
  });
}

/// No answer: no network, the server is unreachable, or a timeout.
final class NetworkException extends AppException {
  const NetworkException({this.isTimeout = false});

  final bool isTimeout;
}

/// The server's certificate is not signed by the ATLANTECH Root CA. Usually
/// the phone is on the wrong network (not the port VPN).
final class UntrustedServerException extends AppException {
  const UntrustedServerException();
}

/// The caller cancelled the request.
final class RequestCancelledException extends AppException {
  const RequestCancelledException();
}
