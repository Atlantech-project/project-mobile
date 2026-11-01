import '../models/field_notification.dart';
import '../models/field_task.dart';
import '../models/outbox_event.dart';
import '../router/session_state.dart';
import '../widgets/app_status_badge.dart';
import 'l10n/app_localizations.dart';

/// Shared wording for enums that several screens show.
extension AppLabels on AppLocalizations {
  String roleLabel(FieldRole role) => switch (role) {
    FieldRole.marinePilot => roleMarinePilot,
    FieldRole.tugMaster => roleTugMaster,
    FieldRole.ctSupervisor => roleCtSupervisor,
    FieldRole.nctSupervisor => roleNctSupervisor,
    FieldRole.unsupported => roleUnsupported,
  };

  /// "M. Farid · Marine Pilot · Alexandria Port" under signed-in titles.
  String? userLine(SessionState session) {
    final user = session.user;
    if (user == null) return null;
    return [
      user.displayName,
      roleLabel(user.role),
      ?session.port?.portName,
    ].join(' · ');
  }

  String taskTypeLabel(TaskComponentType type) => switch (type) {
    TaskComponentType.pilot => taskTypePilotage,
    TaskComponentType.tug => taskTypeTug,
    TaskComponentType.terminalOps => taskTypeTerminal,
  };

  /// Button and status wording: In progress and Executed (MB-P55).
  String taskStatusLabel(TaskStatus status) => switch (status) {
    TaskStatus.assigned => taskStatusAssigned,
    TaskStatus.started => taskStatusStarted,
    TaskStatus.done => taskStatusDone,
  };

  String systemLabelText(SystemLabel label) => switch (label) {
    SystemLabel.updated => systemLabelUpdated,
    SystemLabel.overridden => systemLabelOverridden,
    SystemLabel.cancelled => systemLabelCancelled,
  };

  String outboxStatusLabel(OutboxStatus status) => switch (status) {
    OutboxStatus.pending => outboxStatusPending,
    OutboxStatus.sending => outboxStatusSending,
    OutboxStatus.done => outboxStatusDone,
    OutboxStatus.rejected => outboxStatusRejected,
  };

  String rejectReasonText(RejectReason reason) => switch (reason) {
    RejectReason.planCancelled => rejectPlanCancelled,
    RejectReason.illegalTransition => rejectIllegalTransition,
    RejectReason.notAssigned => rejectNotAssigned,
    RejectReason.notFound => rejectNotFound,
    RejectReason.invalidEvent => rejectInvalidEvent,
    RejectReason.unknown => rejectUnknown,
  };

  String notificationTypeLabel(NotificationType type) => switch (type) {
    NotificationType.planAssignment => notificationTypeAssignment,
    NotificationType.preExecutionReminder => notificationTypeReminder,
    NotificationType.planCancelled => notificationTypeCancelled,
  };

  String notificationStatusLabel(NotificationStatus status) => switch (status) {
    NotificationStatus.sent => notificationStatusSent,
    NotificationStatus.failed => notificationStatusFailed,
    NotificationStatus.acknowledged => notificationStatusAcknowledged,
  };
}

/// Badge tones for the shared enums.
abstract final class AppTones {
  static AppStatusTone outbox(OutboxStatus status) => switch (status) {
    OutboxStatus.pending || OutboxStatus.sending => AppStatusTone.warning,
    OutboxStatus.done => AppStatusTone.success,
    OutboxStatus.rejected => AppStatusTone.danger,
  };

  static AppStatusTone systemLabel(SystemLabel label) => switch (label) {
    SystemLabel.updated => AppStatusTone.info,
    SystemLabel.overridden || SystemLabel.cancelled => AppStatusTone.danger,
  };

  static AppStatusTone notification(NotificationStatus status) =>
      switch (status) {
        NotificationStatus.sent => AppStatusTone.info,
        NotificationStatus.failed => AppStatusTone.danger,
        NotificationStatus.acknowledged => AppStatusTone.success,
      };

  static AppStatusTone task(TaskStatus status) => switch (status) {
    TaskStatus.assigned => AppStatusTone.neutral,
    TaskStatus.started => AppStatusTone.info,
    TaskStatus.done => AppStatusTone.success,
  };
}
