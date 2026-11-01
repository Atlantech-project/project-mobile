import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/outbox_event.dart';
import '../../../core/network/connection_cubit.dart';
import '../../../core/router/session_state.dart';
import '../data/outbox_repository.dart';

class SyncState {
  const SyncState({this.events = const [], this.online = true});

  /// The signed-in user's events, newest first.
  final List<OutboxEvent> events;
  final bool online;

  int count(OutboxStatus status) =>
      events.where((e) => e.status == status).length;

  int get pending => count(OutboxStatus.pending) + count(OutboxStatus.sending);

  bool get sending => count(OutboxStatus.sending) > 0;

  bool get failed => events.any(
    (e) => e.status == OutboxStatus.pending && e.lastAttemptFailed,
  );
}

/// P-56 Sync Status and Outbox. Reads the Outbox; never deletes from it.
class SyncCubit extends Cubit<SyncState> {
  SyncCubit(this._outbox, this._session, this._connection)
    : super(SyncState(online: _connection.state)) {
    _subs = [
      _outbox.changes.listen((_) => _read()),
      _connection.stream.listen((_) => _read()),
    ];
    _read();
  }

  final OutboxRepository _outbox;
  final SessionState _session;
  final ConnectionCubit _connection;
  late final List<StreamSubscription<void>> _subs;

  void _read() {
    if (isClosed) return;
    final userId = _session.user?.userId;
    emit(
      SyncState(
        online: _connection.state,
        events: [
          for (final e in _outbox.events.reversed)
            if (e.userId == userId) e,
        ],
      ),
    );
  }

  Future<void> syncNow() => _outbox.syncNow();

  @override
  Future<void> close() async {
    for (final s in _subs) {
      await s.cancel();
    }
    return super.close();
  }
}
