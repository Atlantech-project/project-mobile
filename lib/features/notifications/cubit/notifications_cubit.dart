import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/errors/app_exception.dart';
import '../../../core/models/field_notification.dart';
import '../../../core/models/outbox_event.dart';
import '../../../core/network/connection_cubit.dart';
import '../../../core/router/session_state.dart';
import '../../../core/widgets/app_state_body.dart';
import '../../sync/data/outbox_repository.dart';
import '../data/notifications_repository.dart';

/// The status filter tabs of P-19. [all] shows every row.
enum NotificationFilter { all, sent, failed, acknowledged }

class NotificationsState {
  const NotificationsState({
    this.status = AppViewStatus.loading,
    this.items = const [],
    this.filter = NotificationFilter.all,
    this.online = true,
    this.lastSync,
    this.pendingAckTaskIds = const {},
  });

  final AppViewStatus status;

  /// Every notification of the signed-in user, newest first.
  final List<FieldNotification> items;
  final NotificationFilter filter;
  final bool online;
  final DateTime? lastSync;

  /// Tasks with an `ACKNOWLEDGE` event saved on the device and not yet
  /// accepted by the server.
  final Set<String> pendingAckTaskIds;

  List<FieldNotification> get visible => switch (filter) {
    NotificationFilter.all => items,
    NotificationFilter.sent => [
      for (final n in items)
        if (n.status == NotificationStatus.sent) n,
    ],
    NotificationFilter.failed => [
      for (final n in items)
        if (n.status == NotificationStatus.failed) n,
    ],
    NotificationFilter.acknowledged => [
      for (final n in items)
        if (n.status == NotificationStatus.acknowledged) n,
    ],
  };

  NotificationsState copyWith({
    AppViewStatus? status,
    List<FieldNotification>? items,
    NotificationFilter? filter,
    bool? online,
    DateTime? lastSync,
    Set<String>? pendingAckTaskIds,
  }) => NotificationsState(
    status: status ?? this.status,
    items: items ?? this.items,
    filter: filter ?? this.filter,
    online: online ?? this.online,
    lastSync: lastSync ?? this.lastSync,
    pendingAckTaskIds: pendingAckTaskIds ?? this.pendingAckTaskIds,
  );
}

/// P-19 Notifications: list, acknowledge through the Outbox, open the task.
class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit(
    this._repository,
    this._outbox,
    this._session,
    this._connection,
  ) : super(NotificationsState(online: _connection.state)) {
    _subs = [
      _repository.changes.listen((_) => _quietRefresh()),
      _connection.stream.listen(
        (online) => emit(state.copyWith(online: online)),
      ),
    ];
  }

  final NotificationsRepository _repository;
  final OutboxRepository _outbox;
  final SessionState _session;
  final ConnectionCubit _connection;
  late final List<StreamSubscription<void>> _subs;

  Future<void> load() async {
    emit(state.copyWith(status: AppViewStatus.loading));
    await _fetch();
  }

  Future<void> _quietRefresh() async {
    if (state.status == AppViewStatus.loading) return;
    await _fetch();
  }

  Future<void> _fetch() async {
    try {
      final items = await _repository.refresh();
      if (isClosed) return;
      emit(
        state.copyWith(
          status: items.isEmpty ? AppViewStatus.empty : AppViewStatus.ready,
          items: items,
          online: _connection.state,
          lastSync: _connection.state ? DateTime.now().toUtc() : null,
          pendingAckTaskIds: _pendingAcks(),
        ),
      );
    } on AppException {
      if (isClosed) return;
      emit(state.copyWith(status: AppViewStatus.error, items: const []));
    }
  }

  Set<String> _pendingAcks() {
    final userId = _session.user?.userId;
    return {
      for (final e in _outbox.events)
        if (e.userId == userId &&
            e.type == OutboxEventType.acknowledge &&
            (e.status == OutboxStatus.pending ||
                e.status == OutboxStatus.sending))
          e.taskId,
    };
  }

  void setFilter(NotificationFilter filter) =>
      emit(state.copyWith(filter: filter));

  /// Saves `ACKNOWLEDGE` in the Outbox (DEC-40). The row turns
  /// Acknowledged only after the server accepts it.
  Future<void> acknowledge(FieldNotification n) async {
    await _repository.acknowledge(n);
    if (isClosed) return;
    emit(state.copyWith(pendingAckTaskIds: _pendingAcks()));
  }

  @override
  Future<void> close() async {
    for (final s in _subs) {
      await s.cancel();
    }
    return super.close();
  }
}
