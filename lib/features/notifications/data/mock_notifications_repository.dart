// DEV-ONLY (Flutter Screens): replaced by the real repository in MB-P19.
import '../../../core/mock/mock_backend.dart';
import '../../../core/models/field_notification.dart';
import '../../../core/models/outbox_event.dart';
import '../../../core/router/session_state.dart';
import 'notifications_repository.dart';

class MockNotificationsRepository implements NotificationsRepository {
  MockNotificationsRepository(this._backend, this._session);

  final MockBackend _backend;
  final SessionState _session;

  @override
  Stream<void> get changes => _backend.changes;

  @override
  Future<List<FieldNotification>> refresh() => _backend.fetchNotifications();

  @override
  Future<void> acknowledge(FieldNotification notification) async {
    final user = _session.user;
    final task = _backend.tasks
        .where((t) => t.id == notification.taskId)
        .firstOrNull;
    if (user == null || task == null) return;
    _backend.enqueue(user: user, task: task, type: OutboxEventType.acknowledge);
  }
}
