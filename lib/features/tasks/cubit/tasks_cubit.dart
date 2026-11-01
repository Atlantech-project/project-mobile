import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/errors/app_exception.dart';
import '../../../core/models/field_task.dart';
import '../../../core/models/outbox_event.dart';
import '../../../core/network/connection_cubit.dart';
import '../../../core/router/session_state.dart';
import '../../../core/widgets/app_state_body.dart';
import '../../sync/data/outbox_repository.dart';
import '../data/tasks_repository.dart';

class TasksState {
  const TasksState({
    this.status = AppViewStatus.loading,
    this.tasks = const [],
    this.events = const [],
    this.online = true,
    this.refreshing = false,
    this.lastSync,
  });

  /// [AppViewStatus.ready] also covers a cached list shown offline.
  final AppViewStatus status;
  final List<FieldTask> tasks;

  /// The signed-in user's Outbox events, oldest first.
  final List<OutboxEvent> events;
  final bool online;
  final bool refreshing;
  final DateTime? lastSync;

  /// Events saved on the device and not yet answered by the server.
  List<OutboxEvent> get unsent => [
    for (final e in events)
      if (e.status == OutboxStatus.pending || e.status == OutboxStatus.sending)
        e,
  ];

  /// The newest event of [taskId], if any.
  OutboxEvent? latestEventFor(String taskId) =>
      events.where((e) => e.taskId == taskId).lastOrNull;

  OutboxEvent? get latestEvent => events.lastOrNull;

  FieldTask? get updatedTask =>
      tasks.where((t) => t.systemLabel != null).firstOrNull;

  TasksState copyWith({
    AppViewStatus? status,
    List<FieldTask>? tasks,
    List<OutboxEvent>? events,
    bool? online,
    bool? refreshing,
    DateTime? lastSync,
  }) => TasksState(
    status: status ?? this.status,
    tasks: tasks ?? this.tasks,
    events: events ?? this.events,
    online: online ?? this.online,
    refreshing: refreshing ?? this.refreshing,
    lastSync: lastSync ?? this.lastSync,
  );
}

/// P-54 My Tasks. Cache first: the saved list shows at once, then the server
/// answer replaces it.
class TasksCubit extends Cubit<TasksState> {
  TasksCubit(this._tasks, this._outbox, this._session, this._connection)
    : super(TasksState(online: _connection.state)) {
    _subs = [
      _tasks.changes.listen((_) => _readCache()),
      _connection.stream.listen((online) {
        emit(state.copyWith(online: online));
        if (online) unawaited(refresh());
      }),
    ];
  }

  final TasksRepository _tasks;
  final OutboxRepository _outbox;
  final SessionState _session;
  final ConnectionCubit _connection;
  late final List<StreamSubscription<void>> _subs;

  Future<void> load() async {
    final cached = _tasks.cachedTasks;
    emit(
      state.copyWith(
        status: AppViewStatus.loading,
        tasks: cached,
        events: _userEvents(),
      ),
    );
    await refresh();
  }

  Future<void> refresh() async {
    if (state.refreshing) return;
    emit(state.copyWith(refreshing: true));
    try {
      final tasks = await _tasks.refresh();
      if (isClosed) return;
      final online = _connection.state;
      emit(
        state.copyWith(
          status: tasks.isEmpty
              ? (online ? AppViewStatus.empty : AppViewStatus.offline)
              : AppViewStatus.ready,
          tasks: tasks,
          events: _userEvents(),
          refreshing: false,
          lastSync: _tasks.lastSync,
        ),
      );
    } on AppException {
      if (isClosed) return;
      emit(
        state.copyWith(
          status: AppViewStatus.error,
          tasks: const [],
          refreshing: false,
        ),
      );
    }
  }

  void _readCache() {
    if (isClosed || state.status == AppViewStatus.loading) return;
    final tasks = _tasks.cachedTasks;
    emit(
      state.copyWith(
        tasks: state.status == AppViewStatus.ready ? tasks : state.tasks,
        events: _userEvents(),
      ),
    );
  }

  List<OutboxEvent> _userEvents() {
    final userId = _session.user?.userId;
    return [
      for (final e in _outbox.events)
        if (e.userId == userId) e,
    ];
  }

  @override
  Future<void> close() async {
    for (final s in _subs) {
      await s.cancel();
    }
    return super.close();
  }
}
