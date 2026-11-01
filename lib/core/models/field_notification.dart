/// Mobile notification types (MB-P19). T+10 and T+20 re-sends are
/// [planAssignment] too.
enum NotificationType { planAssignment, preExecutionReminder, planCancelled }

/// `SENT`, `FAILED` or `ACKNOWLEDGED`.
enum NotificationStatus { sent, failed, acknowledged }

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
}
