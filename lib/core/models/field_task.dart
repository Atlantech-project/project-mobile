/// `component_type` of an assigned plan component (MB-P54).
enum TaskComponentType { pilot, tug, terminalOps }

/// Execution status of a plan component. The buttons say In progress and
/// Executed; the values sent are `STARTED` and `DONE` (MB-P55).
enum TaskStatus { assigned, started, done }

/// `system_label` from the server (MB-P54, MB-P55). `overridden` and
/// `cancelled` stop every action.
enum SystemLabel { updated, overridden, cancelled }

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
}
