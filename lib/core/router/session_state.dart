import 'package:flutter/foundation.dart';

/// Field roles the app knows about. [unsupported] is any non-field role,
/// which must land on P-20 Access Denied.
enum FieldRole {
  marinePilot,
  tugMaster,
  ctSupervisor,
  nctSupervisor,
  unsupported,
}

/// Why P-20 Access Denied is showing.
enum AccessDeniedReason {
  /// Signed in with a non-field role ([FieldRole.unsupported]).
  role,

  /// The server answered 403: the role or terminal scope does not allow the
  /// page or action.
  permission,
}

/// In-memory session used by the router redirect.
// TODO(MB-F3): back this with secure storage so it survives restarts.
class SessionState extends ChangeNotifier {
  bool _portIdentified = false;
  bool _isAuthenticated = false;
  FieldRole? _role;
  bool _updateRequired = false;
  String? _minAppVersion;
  bool _permissionDenied = false;
  bool _accountDisabled = false;

  bool get portIdentified => _portIdentified;
  bool get isAuthenticated => _isAuthenticated;
  FieldRole? get role => _role;

  /// Non-null while the router must show P-20. Only meaningful when signed
  /// in.
  AccessDeniedReason? get accessDeniedReason {
    if (_role == FieldRole.unsupported) return AccessDeniedReason.role;
    if (_permissionDenied) return AccessDeniedReason.permission;
    return null;
  }

  /// Set by a 403 `ACCOUNT_DISABLED` answer. The user is signed out and the
  /// Outbox must not send until a successful sign-in clears it.
  // TODO(MB-F4): the Outbox checks this before sending.
  // TODO(MB-P52): P-52 shows the "account disabled" message.
  bool get accountDisabled => _accountDisabled;

  /// Set by the HTTP 426 handler (MB-F2).
  bool get updateRequired => _updateRequired;

  /// The lowest app version the server accepts, from the 426 body
  /// (`min_app_version`). `null` when the server did not send it.
  String? get minAppVersion => _minAppVersion;

  void markPortIdentified() {
    _portIdentified = true;
    notifyListeners();
  }

  void signIn(FieldRole role) {
    _isAuthenticated = true;
    _role = role;
    _permissionDenied = false;
    _accountDisabled = false;
    notifyListeners();
  }

  void signOut() {
    _isAuthenticated = false;
    _role = null;
    _permissionDenied = false;
    notifyListeners();
  }

  /// A 403 on a signed-in request: the router shows P-20.
  void denyAccess() {
    if (_permissionDenied) return;
    _permissionDenied = true;
    notifyListeners();
  }

  /// "Back to My Tasks" on P-20.
  void clearAccessDenied() {
    if (!_permissionDenied) return;
    _permissionDenied = false;
    notifyListeners();
  }

  /// 403 `ACCOUNT_DISABLED`: signs out and holds the Outbox.
  void disableAccount() {
    _accountDisabled = true;
    _isAuthenticated = false;
    _role = null;
    _permissionDenied = false;
    notifyListeners();
  }

  void setUpdateRequired(bool value, {String? minAppVersion}) {
    _updateRequired = value;
    _minAppVersion = value ? minAppVersion : null;
    notifyListeners();
  }
}
