import 'package:flutter/foundation.dart';

import '../models/field_user.dart';
import '../models/port_info.dart';

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
  FieldUser? _user;
  FieldUser? _lastUser;
  PortInfo? _port;
  bool _sessionExpired = false;
  bool _signedOutByUser = false;

  bool get portIdentified => _portIdentified;
  bool get isAuthenticated => _isAuthenticated;
  FieldRole? get role => _role;

  /// The signed-in user. Null when signed out.
  FieldUser? get user => _user;

  /// The user of the last session, kept after sign-out or expiry so P-52 can
  /// ask the same user to sign in again (same-user Outbox rule).
  FieldUser? get lastUser => _lastUser;

  /// The identified port (P-53). Null until identified.
  PortInfo? get port => _port;

  /// The token expired or was revoked (401). P-52 shows "Sign in again".
  bool get sessionExpired => _sessionExpired;

  /// The user chose Log Out on P-58. The router shows the "signed out" page
  /// until the next sign-in.
  bool get signedOutByUser => _signedOutByUser;

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

  void markPortIdentified([PortInfo? port]) {
    _portIdentified = true;
    _port = port ?? _port;
    notifyListeners();
  }

  void signIn(FieldRole role, {FieldUser? user}) {
    _isAuthenticated = true;
    _role = role;
    _user = user;
    _lastUser = user ?? _lastUser;
    _sessionExpired = false;
    _signedOutByUser = false;
    _permissionDenied = false;
    _accountDisabled = false;
    notifyListeners();
  }

  /// Ends the session. [byUser] is true for Log Out on P-58: [lastUser] and
  /// the Outbox are kept, and the router shows the "signed out" page.
  void signOut({bool byUser = false}) {
    _isAuthenticated = false;
    _role = null;
    _user = null;
    _sessionExpired = false;
    _signedOutByUser = byUser;
    _permissionDenied = false;
    notifyListeners();
  }

  /// A 401 on a signed-in request: signs out, keeps [lastUser] and the
  /// Outbox, and P-52 asks for the same user again.
  void expireSession() {
    _isAuthenticated = false;
    _role = null;
    _user = null;
    _permissionDenied = false;
    _sessionExpired = true;
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
    _user = null;
    _permissionDenied = false;
    notifyListeners();
  }

  void setUpdateRequired(bool value, {String? minAppVersion}) {
    _updateRequired = value;
    _minAppVersion = value ? minAppVersion : null;
    notifyListeners();
  }
}
