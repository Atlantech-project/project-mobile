// DEV-ONLY (Flutter Screens): replaced by the real repository in MB-P54/P55.
import '../../../core/mock/mock_backend.dart';
import '../../../core/models/field_task.dart';
import '../../../core/models/outbox_event.dart';
import '../../../core/router/session_state.dart';
import 'tasks_repository.dart';

class MockTasksRepository implements TasksRepository {
  MockTasksRepository(this._backend, this._session);

  final MockBackend _backend;
  final SessionState _session;

  @override
  Stream<void> get changes => _backend.changes;

  @override
  List<FieldTask> get cachedTasks => _backend.tasks;

  @override
  DateTime? get lastSync => _backend.lastTaskSync;

  @override
  Future<List<FieldTask>> refresh() => _backend.fetchTasks();

  @override
  FieldTask? cachedTask(String id) =>
      _backend.tasks.where((t) => t.id == id).firstOrNull;

  @override
  Future<void> acknowledge(FieldTask task) async =>
      _save(task, OutboxEventType.acknowledge);

  @override
  Future<void> updateStatus(FieldTask task, TaskStatus status) async =>
      _save(task, OutboxEventType.statusUpdate, status);

  void _save(FieldTask task, OutboxEventType type, [TaskStatus? status]) {
    final user = _session.user;
    if (user == null) return;
    _backend.enqueue(user: user, task: task, type: type, newStatus: status);
  }
}
