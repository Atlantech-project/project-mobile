import '../../../core/models/field_task.dart';

/// Assigned tasks: cache-first reads, writes go to the Outbox.
// TODO(MB-P54): real list from the task cache + `GET /sync/changes`.
// TODO(MB-P55): real Acknowledge and status writes through the Outbox.
abstract interface class TasksRepository {
  /// Fires when the cached tasks change.
  Stream<void> get changes;

  /// The tasks saved on the device.
  List<FieldTask> get cachedTasks;

  /// When the task list was last received from the server.
  DateTime? get lastSync;

  /// Asks the server for the latest tasks. Offline it returns the cache.
  Future<List<FieldTask>> refresh();

  FieldTask? cachedTask(String id);

  /// Saves an `ACKNOWLEDGE` event in the Outbox.
  Future<void> acknowledge(FieldTask task);

  /// Saves a `STATUS_UPDATE` event (`STARTED` or `DONE`) in the Outbox.
  Future<void> updateStatus(FieldTask task, TaskStatus status);
}
