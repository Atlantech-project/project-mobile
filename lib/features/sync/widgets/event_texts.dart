import '../../../core/localization/app_formats.dart';
import '../../../core/localization/app_labels.dart';
import '../../../core/localization/l10n/app_localizations.dart';
import '../../../core/models/outbox_event.dart';

/// Wording for the three delivery stages of an Outbox event: saved on the
/// device, dispatched, accepted by the server. Shared by P-54, P-55, P-56.
extension EventTexts on AppLocalizations {
  /// "Executed", "In progress" or "Acknowledgement".
  String eventAction(OutboxEvent e) => e.type == OutboxEventType.acknowledge
      ? eventAcknowledgement
      : taskStatusLabel(e.newStatus!);

  String eventDevice(OutboxEvent? e) => e == null
      ? eventDeviceNone
      : eventDeviceSaved(eventAction(e), AppFormats.time(e.reportedAt));

  String eventDispatch(OutboxEvent? e) {
    if (e == null) return eventDispatchNone;
    return switch (e.status) {
      OutboxStatus.pending when e.lastAttemptFailed => eventDispatchFailed,
      OutboxStatus.pending => eventDispatchWaiting,
      OutboxStatus.sending => eventDispatchSending,
      OutboxStatus.done || OutboxStatus.rejected => eventDispatchDone(
        AppFormats.time(e.dispatchedAt ?? e.reportedAt),
      ),
    };
  }

  String eventAcceptance(OutboxEvent? e) {
    if (e == null) return eventAcceptanceNone;
    return switch (e.status) {
      OutboxStatus.pending ||
      OutboxStatus.sending => eventAcceptanceWaiting(eventAction(e)),
      OutboxStatus.done => eventAcceptanceDone(
        eventAction(e),
        AppFormats.time(e.acceptedAt ?? e.reportedAt),
      ),
      OutboxStatus.rejected => eventAcceptanceRejected(eventAction(e)),
    };
  }
}
