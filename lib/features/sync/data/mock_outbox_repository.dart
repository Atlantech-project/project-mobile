// DEV-ONLY (Flutter Screens): replaced by the Outbox in MB-F4A/MB-F4B.
import '../../../core/mock/mock_backend.dart';
import '../../../core/models/outbox_event.dart';
import 'outbox_repository.dart';

class MockOutboxRepository implements OutboxRepository {
  MockOutboxRepository(this._backend);

  final MockBackend _backend;

  @override
  Stream<void> get changes => _backend.changes;

  @override
  List<OutboxEvent> get events => _backend.outbox;

  @override
  Future<void> syncNow() => _backend.syncNow();
}
