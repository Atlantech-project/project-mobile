import '../localization/l10n/app_localizations.dart';
import 'app_exception.dart';

/// The text to show for an [AppException].
///
/// Order (CT-01): the app's own translation of `message_key`, then the
/// server's English `detail`, then a general message. Never branch on the
/// text; branch on `code` or the exception type.
abstract final class AppErrorMessage {
  static String of(AppException error, AppLocalizations l10n) {
    switch (error) {
      case NetworkException(isTimeout: true):
        return l10n.errorTimeout;
      case NetworkException():
        return l10n.errorNetwork;
      case UntrustedServerException():
        return l10n.errorUntrustedServer;
      default:
        break;
    }
    final key = error.messageKey;
    final translated = key == null ? null : _byKey(key, l10n);
    return translated ?? error.detail ?? l10n.errorUnknown;
  }

  /// `message_key` values from the CT-01 error catalogue.
  static String? _byKey(String key, AppLocalizations l10n) => switch (key) {
    'errors.bad_request' => l10n.errorBadRequest,
    'errors.unauthenticated' => l10n.errorUnauthenticated,
    'errors.auth.invalid_credentials' => l10n.errorInvalidCredentials,
    'errors.forbidden' => l10n.errorForbidden,
    'errors.account_disabled' => l10n.errorAccountDisabled,
    'errors.password_change_required' => l10n.errorPasswordChangeRequired,
    'errors.not_found' => l10n.errorNotFound,
    'errors.version_conflict' => l10n.errorVersionConflict,
    'errors.validation_failed' => l10n.errorValidationFailed,
    'errors.idempotency_key_reused' => l10n.errorIdempotencyKeyReused,
    'errors.license_read_only' => l10n.errorLicenseReadOnly,
    'errors.app_update_required' => l10n.errorAppUpdateRequired,
    'errors.too_many_attempts' => l10n.errorTooManyAttempts,
    'errors.server_error' => l10n.errorServerError,
    'errors.service_unavailable' => l10n.errorServiceUnavailable,
    _ => null,
  };
}
