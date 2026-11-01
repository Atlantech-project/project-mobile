import '../../../core/models/outbox_event.dart';

/// The Outbox saved on the device.
// TODO(MB-F4A/MB-F4B): real Outbox on Hive and the sync engine.
abstract interface class OutboxRepository {
  /// Fires when an event is saved or changes status.
  Stream<void> get changes;

  /// Every event on the device, oldest first.
  List<OutboxEvent> get events;

  /// Sends the PENDING events of the signed-in user now.
  Future<void> syncNow();
}
