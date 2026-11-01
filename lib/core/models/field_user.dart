import '../router/session_state.dart';

/// The signed-in field user, as returned by `POST /auth/mobile/login`
/// (MB-P52 saves user id, role, name and `terminal_ids`).
class FieldUser {
  const FieldUser({
    required this.userId,
    required this.username,
    required this.displayName,
    required this.role,
    this.terminalIds = const [],
  });

  final String userId;
  final String username;
  final String displayName;
  final FieldRole role;
  final List<String> terminalIds;
}
