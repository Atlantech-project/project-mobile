import '../network/api_date_time.dart';

/// Mobile notification types (MB-P19). T+10 and T+20 re-sends are
/// [planAssignment] too.
enum NotificationType {
  planAssignment('PLAN_ASSIGNMENT'),
  preExecutionReminder('PRE_EXECUTION_REMINDER'),
  planCancelled('PLAN_CANCELLED');

  const NotificationType(this.code);

  final String code;

  static NotificationType fromCode(String code) =>
      values.firstWhere((t) => t.code == code);
}

/// `SENT`, `FAILED` or `ACKNOWLEDGED`.
enum NotificationStatus {
  sent('SENT'),
  failed('FAILED'),
  acknowledged('ACKNOWLEDGED');

  const NotificationStatus(this.code);

  final String code;

  static NotificationStatus fromCode(String code) =>
      values.firstWhere((s) => s.code == code);
}

/// One notification of the signed-in user.
class FieldNotification {
  const FieldNotification({
    required this.id,
    required this.type,
    required this.taskId,
    required this.taskReference,
    required this.vesselName,
    required this.berth,
    required this.terminal,
    required this.createdAt,
    this.status = NotificationStatus.sent,
    this.acknowledgedAt,
  });

  final String id;
  final NotificationType type;
  final String taskId;
  final String taskReference;
  final String vesselName;
  final String berth;
  final String terminal;
  final DateTime createdAt;
  final NotificationStatus status;
  final DateTime? acknowledgedAt;

  FieldNotification copyWith({
    NotificationStatus? status,
    DateTime? acknowledgedAt,
  }) => FieldNotification(
    id: id,
    type: type,
    taskId: taskId,
    taskReference: taskReference,
    vesselName: vesselName,
    berth: berth,
    terminal: terminal,
    createdAt: createdAt,
    status: status ?? this.status,
    acknowledgedAt: acknowledgedAt ?? this.acknowledgedAt,
  );

  /// The notification cache record (MB-F3). Keeps `acknowledged_at`.
  Map<String, Object?> toJson() => {
    'id': id,
    'type': type.code,
    'task_id': taskId,
    'task_reference': taskReference,
    'vessel_name': vesselName,
    'berth': berth,
    'terminal': terminal,
    'created_at': ApiDateTime.format(createdAt),
    'status': status.code,
    'acknowledged_at': ApiDateTime.formatOrNull(acknowledgedAt),
  };

  factory FieldNotification.fromJson(Map<String, Object?> json) =>
      FieldNotification(
        id: json['id']! as String,
        type: NotificationType.fromCode(json['type']! as String),
        taskId: json['task_id']! as String,
        taskReference: json['task_reference']! as String,
        vesselName: json['vessel_name']! as String,
        berth: json['berth']! as String,
        terminal: json['terminal']! as String,
        createdAt: DateTime.parse(json['created_at']! as String),
        status: NotificationStatus.fromCode(json['status']! as String),
        acknowledgedAt: ApiDateTime.parseOrNull(json['acknowledged_at']),
      );
}
