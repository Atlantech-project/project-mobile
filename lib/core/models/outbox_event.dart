import 'field_task.dart';

/// `type` of an Outbox event.
enum OutboxEventType { statusUpdate, acknowledge }

/// Where an Outbox event stands (P-56).
enum OutboxStatus { pending, sending, done, rejected }

/// `reason_code` of a rejected event (MB-P55). Anything else is
/// [RejectReason.unknown].
enum RejectReason {
  planCancelled,
  illegalTransition,
  notAssigned,
  notFound,
  invalidEvent,
  unknown,
}

/// One event saved on the device and sent with `POST /sync/events`.
///
/// The task fields after [taskId] are a display copy of the task at the time
/// the event was saved, so P-56 can show the event without the task cache.
class OutboxEvent {
  const OutboxEvent({
    required this.clientEventId,
    required this.type,
    required this.taskId,
    required this.taskReference,
    required this.planReference,
    required this.vesselName,
    required this.terminal,
    required this.berth,
    required this.reportedAt,
    required this.userId,
    required this.username,
    this.newStatus,
    this.status = OutboxStatus.pending,
    this.attempts = 0,
    this.lastAttemptFailed = false,
    this.reason,
    this.dispatchedAt,
    this.acceptedAt,
  });

  final String clientEventId;
  final OutboxEventType type;
  final String taskId;
  final String taskReference;
  final String planReference;
  final String vesselName;
  final String terminal;
  final String berth;

  /// `STARTED` or `DONE` for [OutboxEventType.statusUpdate].
  final TaskStatus? newStatus;
  final DateTime reportedAt;
  final String userId;
  final String username;
  final OutboxStatus status;
  final int attempts;

  /// The last send failed before the server answered (transport error).
  final bool lastAttemptFailed;
  final RejectReason? reason;
  final DateTime? dispatchedAt;
  final DateTime? acceptedAt;

  OutboxEvent copyWith({
    OutboxStatus? status,
    int? attempts,
    bool? lastAttemptFailed,
    RejectReason? reason,
    DateTime? dispatchedAt,
    DateTime? acceptedAt,
  }) => OutboxEvent(
    clientEventId: clientEventId,
    type: type,
    taskId: taskId,
    taskReference: taskReference,
    planReference: planReference,
    vesselName: vesselName,
    terminal: terminal,
    berth: berth,
    newStatus: newStatus,
    reportedAt: reportedAt,
    userId: userId,
    username: username,
    status: status ?? this.status,
    attempts: attempts ?? this.attempts,
    lastAttemptFailed: lastAttemptFailed ?? this.lastAttemptFailed,
    reason: reason ?? this.reason,
    dispatchedAt: dispatchedAt ?? this.dispatchedAt,
    acceptedAt: acceptedAt ?? this.acceptedAt,
  );
}
