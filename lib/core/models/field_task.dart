import '../network/api_date_time.dart';

/// `component_type` of an assigned plan component (MB-P54).
enum TaskComponentType {
  pilot('PILOT'),
  tug('TUG'),
  terminalOps('TERMINAL_OPS');

  const TaskComponentType(this.code);

  final String code;

  static TaskComponentType fromCode(String code) =>
      values.firstWhere((t) => t.code == code);
}

/// Execution status of a plan component. The buttons say In progress and
/// Executed; the values sent are `STARTED` and `DONE` (MB-P55).
enum TaskStatus {
  assigned('ASSIGNED'),
  started('STARTED'),
  done('DONE');

  const TaskStatus(this.code);

  final String code;

  static TaskStatus? fromCode(String? code) =>
      values.where((s) => s.code == code).firstOrNull;
}

/// `system_label` from the server (MB-P54, MB-P55). `overridden` and
/// `cancelled` stop every action.
enum SystemLabel {
  updated('UPDATED'),
  overridden('OVERRIDDEN'),
  cancelled('CANCELLED');

  const SystemLabel(this.code);

  final String code;

  static SystemLabel? fromCode(String? code) =>
      values.where((l) => l.code == code).firstOrNull;
}

/// One assigned task (a plan component) as cached on the device.
class FieldTask {
  const FieldTask({
    required this.id,
    required this.reference,
    required this.planReference,
    required this.terminal,
    required this.componentType,
    required this.vesselName,
    required this.berth,
    required this.plannedStart,
    required this.plannedEnd,
    required this.version,
    this.tugs = const [],
    this.pilotName,
    this.status = TaskStatus.assigned,
    this.statusAt,
    this.systemLabel,
    this.notificationId,
    this.acknowledgedAt,
  });

  /// `plan_component_id`.
  final String id;

  /// Task reference shown to the user, e.g. `PT-A-0109`.
  final String reference;

  /// Operational plan reference, e.g. `OP-A-0109`.
  final String planReference;
  final String terminal;
  final TaskComponentType componentType;
  final String vesselName;
  final String berth;
  final DateTime plannedStart;
  final DateTime plannedEnd;

  /// Opaque version string. Never parsed.
  final String version;
  final List<String> tugs;
  final String? pilotName;

  /// Server-confirmed status.
  final TaskStatus status;
  final DateTime? statusAt;
  final SystemLabel? systemLabel;

  /// The newest `SENT` notification of this task, used by Acknowledge.
  final String? notificationId;
  final DateTime? acknowledgedAt;

  bool get isLocked =>
      systemLabel == SystemLabel.overridden ||
      systemLabel == SystemLabel.cancelled;

  FieldTask copyWith({
    TaskStatus? status,
    DateTime? statusAt,
    SystemLabel? systemLabel,
    bool clearSystemLabel = false,
    DateTime? acknowledgedAt,
    String? version,
  }) => FieldTask(
    id: id,
    reference: reference,
    planReference: planReference,
    terminal: terminal,
    componentType: componentType,
    vesselName: vesselName,
    berth: berth,
    plannedStart: plannedStart,
    plannedEnd: plannedEnd,
    version: version ?? this.version,
    tugs: tugs,
    pilotName: pilotName,
    status: status ?? this.status,
    statusAt: statusAt ?? this.statusAt,
    systemLabel: clearSystemLabel ? null : (systemLabel ?? this.systemLabel),
    notificationId: notificationId,
    acknowledgedAt: acknowledgedAt ?? this.acknowledgedAt,
  );

  /// The task cache record (MB-F3). Keeps system_label and ersion
  /// exactly as received.
  Map<String, Object?> toJson() => {
    'id': id,
    'reference': reference,
    'plan_reference': planReference,
    'terminal': terminal,
    'component_type': componentType.code,
    'vessel_name': vesselName,
    'berth': berth,
    'planned_start': ApiDateTime.format(plannedStart),
    'planned_end': ApiDateTime.format(plannedEnd),
    'version': version,
    'tugs': tugs,
    'pilot_name': pilotName,
    'status': status.code,
    'status_at': ApiDateTime.formatOrNull(statusAt),
    'system_label': systemLabel?.code,
    'notification_id': notificationId,
    'acknowledged_at': ApiDateTime.formatOrNull(acknowledgedAt),
  };

  factory FieldTask.fromJson(Map<String, Object?> json) => FieldTask(
    id: json['id']! as String,
    reference: json['reference']! as String,
    planReference: json['plan_reference']! as String,
    terminal: json['terminal']! as String,
    componentType: TaskComponentType.fromCode(
      json['component_type']! as String,
    ),
    vesselName: json['vessel_name']! as String,
    berth: json['berth']! as String,
    plannedStart: DateTime.parse(json['planned_start']! as String),
    plannedEnd: DateTime.parse(json['planned_end']! as String),
    version: json['version']! as String,
    tugs: List<String>.from(json['tugs']! as List),
    pilotName: json['pilot_name'] as String?,
    status:
        TaskStatus.fromCode(json['status'] as String?) ?? TaskStatus.assigned,
    statusAt: ApiDateTime.parseOrNull(json['status_at']),
    systemLabel: SystemLabel.fromCode(json['system_label'] as String?),
    notificationId: json['notification_id'] as String?,
    acknowledgedAt: ApiDateTime.parseOrNull(json['acknowledged_at']),
  );
}
