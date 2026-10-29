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

/// In-memory session used by the router redirect.
// TODO(MB-F3): back this with secure storage so it survives restarts.
class SessionState extends ChangeNotifier {
  bool _portIdentified = false;
  bool _isAuthenticated = false;
  FieldRole? _role;
  bool _updateRequired = false;
  String? _minAppVersion;

  bool get portIdentified => _portIdentified;
  bool get isAuthenticated => _isAuthenticated;
  FieldRole? get role => _role;

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
    notifyListeners();
  }

  void signOut() {
    _isAuthenticated = false;
    _role = null;
    notifyListeners();
  }

  void setUpdateRequired(bool value, {String? minAppVersion}) {
    _updateRequired = value;
    _minAppVersion = value ? minAppVersion : null;
    notifyListeners();
  }
}
