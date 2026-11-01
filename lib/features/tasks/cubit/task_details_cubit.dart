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

class TaskDetailsState {
  const TaskDetailsState({
    this.status = AppViewStatus.loading,
    this.task,
    this.events = const [],
    this.online = true,
    this.selected,
    this.lastSync,
  });

  final AppViewStatus status;
  final FieldTask? task;

  /// This user's Outbox events for the task, oldest first.
  final List<OutboxEvent> events;
  final bool online;

  /// The status picked on screen. Not saved until Save is pressed.
  final TaskStatus? selected;
  final DateTime? lastSync;

  OutboxEvent? get latestStatusEvent =>
      events.where((e) => e.type == OutboxEventType.statusUpdate).lastOrNull;

  OutboxEvent? get pendingAcknowledge => events
      .where(
        (e) =>
            e.type == OutboxEventType.acknowledge &&
            e.status != OutboxStatus.done,
      )
      .lastOrNull;

  int get unsentCount => events
      .where(
        (e) =>
            e.status == OutboxStatus.pending ||
            e.status == OutboxStatus.sending,
      )
      .length;

  bool get isAcknowledged =>
      task?.acknowledgedAt != null ||
      (pendingAcknowledge != null &&
          pendingAcknowledge!.status != OutboxStatus.rejected);

  /// `OVERRIDDEN` and `CANCELLED` stop every action (MB-P55).
  bool get locked => task?.isLocked ?? true;

  bool get canSave =>
      !locked && selected != null && task?.status != TaskStatus.done;

  TaskDetailsState copyWith({
    AppViewStatus? status,
    FieldTask? task,
    List<OutboxEvent>? events,
    bool? online,
    TaskStatus? selected,
    bool clearSelected = false,
    DateTime? lastSync,
  }) => TaskDetailsState(
    status: status ?? this.status,
    task: task ?? this.task,
    events: events ?? this.events,
    online: online ?? this.online,
    selected: clearSelected ? null : (selected ?? this.selected),
    lastSync: lastSync ?? this.lastSync,
  );
}

/// P-55 Task Details and Status Update. Every write goes to the Outbox first.
class TaskDetailsCubit extends Cubit<TaskDetailsState> {
  TaskDetailsCubit(
    this._taskId,
    this._tasks,
    this._outbox,
    this._session,
    this._connection,
  ) : super(TaskDetailsState(online: _connection.state)) {
    _subs = [
      _tasks.changes.listen((_) => _readCache()),
      _connection.stream.listen(
        (online) => emit(state.copyWith(online: online)),
      ),
    ];
  }

  final String _taskId;
  final TasksRepository _tasks;
  final OutboxRepository _outbox;
  final SessionState _session;
  final ConnectionCubit _connection;
  late final List<StreamSubscription<void>> _subs;

  Future<void> load() async {
    final cached = _tasks.cachedTask(_taskId);
    if (cached != null) {
      emit(
        state.copyWith(
          status: AppViewStatus.ready,
          task: cached,
          events: _taskEvents(),
          lastSync: _tasks.lastSync,
        ),
      );
      return;
    }
    emit(const TaskDetailsState().copyWith(online: _connection.state));
    try {
      await _tasks.refresh();
    } on AppException {
      // Shown as "No task data" below.
    }
    if (isClosed) return;
    final task = _tasks.cachedTask(_taskId);
    emit(
      state.copyWith(
        status: task == null ? AppViewStatus.empty : AppViewStatus.ready,
        task: task,
        events: _taskEvents(),
        lastSync: _tasks.lastSync,
      ),
    );
  }

  /// DEV-ONLY (Flutter Screens): shows the loading frame.
  void showLoading() => emit(TaskDetailsState(online: _connection.state));

  /// DEV-ONLY (Flutter Screens): shows the "No task data" frame.
  void showNoData() => emit(
    TaskDetailsState(status: AppViewStatus.empty, online: _connection.state),
  );

  void select(TaskStatus status) => emit(state.copyWith(selected: status));

  Future<void> acknowledge() async {
    final task = state.task;
    if (task == null || state.locked || state.isAcknowledged) return;
    await _tasks.acknowledge(task);
  }

  Future<void> save() async {
    final task = state.task;
    final selected = state.selected;
    if (task == null || selected == null || !state.canSave) return;
    await _tasks.updateStatus(task, selected);
    if (!isClosed) emit(state.copyWith(clearSelected: true));
  }

  Future<void> retrySync() => _outbox.syncNow();

  void _readCache() {
    if (isClosed || state.status != AppViewStatus.ready) return;
    emit(
      state.copyWith(task: _tasks.cachedTask(_taskId), events: _taskEvents()),
    );
  }

  List<OutboxEvent> _taskEvents() {
    final userId = _session.user?.userId;
    return [
      for (final e in _outbox.events)
        if (e.taskId == _taskId && e.userId == userId) e,
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
