import '../network/api_date_time.dart';
import 'field_task.dart';

/// `type` of an Outbox event.
enum OutboxEventType {
  statusUpdate('STATUS_UPDATE'),
  acknowledge('ACKNOWLEDGE');

  const OutboxEventType(this.code);

  final String code;

  static OutboxEventType fromCode(String code) =>
      values.firstWhere((t) => t.code == code);
}

/// Where an Outbox event stands (P-56).
enum OutboxStatus {
  pending('PENDING'),
  sending('SENDING'),
  done('DONE'),
  rejected('REJECTED');

  const OutboxStatus(this.code);

  final String code;

  static OutboxStatus fromCode(String code) =>
      values.firstWhere((s) => s.code == code);
}

/// `reason_code` of a rejected event (MB-P55). Anything else is
/// [RejectReason.unknown].
enum RejectReason {
  planCancelled('PLAN_CANCELLED'),
  illegalTransition('ILLEGAL_TRANSITION'),
  notAssigned('NOT_ASSIGNED'),
  notFound('NOT_FOUND'),
  invalidEvent('INVALID_EVENT'),
  unknown(null);

  const RejectReason(this.code);

  final String? code;

  /// `null` when there is no code; [unknown] for a code the app does not know.
  static RejectReason? fromCode(String? code) => code == null
      ? null
      : values.firstWhere((r) => r.code == code, orElse: () => unknown);
}

/// `sync_source` of an event: the device class, detected once and kept in
/// the meta box (MB-F3).
enum SyncSource {
  tablet('TABLET'),
  mobile('MOBILE');

  const SyncSource(this.code);

  final String code;

  static SyncSource? fromCode(String? code) =>
      values.where((s) => s.code == code).firstOrNull;
}

/// One event saved on the device and sent with `POST /sync/events`.
///
/// The task fields after [taskId] are a display copy of the task at the time
/// the event was saved, so P-56 can show the event without the task cache.
class OutboxEvent {
  const OutboxEvent({
    required this.clientEventId,
    required this.type,
    required this.payload,
    required this.syncSource,
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
    this.reasonCode,
    this.clientSentAt,
    this.dispatchedAt,
    this.acceptedAt,
  });

  final String clientEventId;
  final OutboxEventType type;

  /// The event body sent as is: `plan_component_id` and `new_status` for
  /// `STATUS_UPDATE`, `notification_id` for `ACKNOWLEDGE` (MB-P55).
  final Map<String, Object?> payload;
  final SyncSource syncSource;
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

  /// `reason_code` exactly as the server sent it, so an unknown code is kept.
  final String? reasonCode;

  /// When the event was last put in a `POST /sync/events` request.
  final DateTime? clientSentAt;
  final DateTime? dispatchedAt;
  final DateTime? acceptedAt;

  RejectReason? get reason => RejectReason.fromCode(reasonCode);

  OutboxEvent copyWith({
    OutboxStatus? status,
    int? attempts,
    bool? lastAttemptFailed,
    String? reasonCode,
    DateTime? clientSentAt,
    DateTime? dispatchedAt,
    DateTime? acceptedAt,
  }) => OutboxEvent(
    clientEventId: clientEventId,
    type: type,
    payload: payload,
    syncSource: syncSource,
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
    reasonCode: reasonCode ?? this.reasonCode,
    clientSentAt: clientSentAt ?? this.clientSentAt,
    dispatchedAt: dispatchedAt ?? this.dispatchedAt,
    acceptedAt: acceptedAt ?? this.acceptedAt,
  );

  /// The Outbox box record (MB-F3).
  Map<String, Object?> toJson() => {
    'client_event_id': clientEventId,
    'type': type.code,
    'payload': payload,
    'sync_source': syncSource.code,
    'task_id': taskId,
    'task_reference': taskReference,
    'plan_reference': planReference,
    'vessel_name': vesselName,
    'terminal': terminal,
    'berth': berth,
    'new_status': newStatus?.code,
    'reported_at': ApiDateTime.format(reportedAt),
    'user_id': userId,
    'username': username,
    'status': status.code,
    'attempts': attempts,
    'last_attempt_failed': lastAttemptFailed,
    'reason_code': reasonCode,
    'client_sent_at': ApiDateTime.formatOrNull(clientSentAt),
    'dispatched_at': ApiDateTime.formatOrNull(dispatchedAt),
    'accepted_at': ApiDateTime.formatOrNull(acceptedAt),
  };

  factory OutboxEvent.fromJson(Map<String, Object?> json) => OutboxEvent(
    clientEventId: json['client_event_id']! as String,
    type: OutboxEventType.fromCode(json['type']! as String),
    payload: Map<String, Object?>.from(json['payload']! as Map),
    syncSource:
        SyncSource.fromCode(json['sync_source'] as String?) ??
        SyncSource.tablet,
    taskId: json['task_id']! as String,
    taskReference: json['task_reference']! as String,
    planReference: json['plan_reference']! as String,
    vesselName: json['vessel_name']! as String,
    terminal: json['terminal']! as String,
    berth: json['berth']! as String,
    newStatus: TaskStatus.fromCode(json['new_status'] as String?),
    reportedAt: DateTime.parse(json['reported_at']! as String),
    userId: json['user_id']! as String,
    username: json['username']! as String,
    status: OutboxStatus.fromCode(json['status']! as String),
    attempts: json['attempts']! as int,
    lastAttemptFailed: json['last_attempt_failed']! as bool,
    reasonCode: json['reason_code'] as String?,
    clientSentAt: ApiDateTime.parseOrNull(json['client_sent_at']),
    dispatchedAt: ApiDateTime.parseOrNull(json['dispatched_at']),
    acceptedAt: ApiDateTime.parseOrNull(json['accepted_at']),
  );
}
