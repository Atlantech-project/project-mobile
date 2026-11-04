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

  /// The session record in the meta box (MB-F3). The role is kept by its
  /// Dart name: it is a device-only value.
  Map<String, Object?> toJson() => {
    'user_id': userId,
    'username': username,
    'display_name': displayName,
    'role': role.name,
    'terminal_ids': terminalIds,
  };

  factory FieldUser.fromJson(Map<String, Object?> json) => FieldUser(
    userId: json['user_id']! as String,
    username: json['username']! as String,
    displayName: json['display_name']! as String,
    role: FieldRole.values.asNameMap()[json['role']] ?? FieldRole.unsupported,
    terminalIds: List<String>.from(json['terminal_ids']! as List),
  );
}
