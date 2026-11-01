import '../../../core/models/field_notification.dart';

/// Notifications of the signed-in user.
// TODO(MB-P19): real list from the cache + `GET /sync/changes`.
abstract interface class NotificationsRepository {
  Stream<void> get changes;

  /// The latest notifications, newest first. Offline it returns the cache.
  Future<List<FieldNotification>> refresh();

  /// Saves an `ACKNOWLEDGE` event for the notification's task.
  Future<void> acknowledge(FieldNotification notification);
}
