import '../../../core/models/field_user.dart';
import '../../../core/models/port_info.dart';

/// Port identification and sign-in. Throws [AppException]s.
// TODO(MB-P53): real `identifyPort` on `GET /system/info`.
// TODO(MB-P52): real `login`, `changePassword` and `logout` (MB-P58).
abstract interface class AuthRepository {
  /// `GET /system/info`.
  Future<PortInfo> identifyPort();

  /// `POST /auth/mobile/login`. Throws [ForbiddenException] with
  /// `PASSWORD_CHANGE_REQUIRED` on a first login.
  Future<FieldUser> login({required String username, required String password});

  /// `POST /auth/change-password`.
  Future<FieldUser> changePassword(String newPassword);

  /// `POST /auth/logout` when online; offline only the token is deleted.
  Future<void> logout();
}
