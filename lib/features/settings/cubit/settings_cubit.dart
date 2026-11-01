import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/errors/app_exception.dart';
import '../../../core/models/outbox_event.dart';
import '../../../core/network/connection_cubit.dart';
import '../../../core/router/session_state.dart';
import '../../auth/data/auth_repository.dart';
import '../../sync/data/outbox_repository.dart';

class SettingsState {
  const SettingsState({
    this.loading = true,
    this.online = true,
    this.unsent = const [],
    this.loggingOut = false,
  });

  /// Figma "Loading": the first read of the local settings.
  final bool loading;
  final bool online;

  /// The signed-in user's PENDING or SENDING events. Log Out keeps them.
  final List<OutboxEvent> unsent;
  final bool loggingOut;

  SettingsState copyWith({
    bool? loading,
    bool? online,
    List<OutboxEvent>? unsent,
    bool? loggingOut,
  }) => SettingsState(
    loading: loading ?? this.loading,
    online: online ?? this.online,
    unsent: unsent ?? this.unsent,
    loggingOut: loggingOut ?? this.loggingOut,
  );
}

/// P-58 Settings & Session. Everything here is read-only except Log Out.
class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this._auth, this._outbox, this._session, this._connection)
    : super(SettingsState(online: _connection.state)) {
    _subs = [
      _outbox.changes.listen((_) => _read()),
      _connection.stream.listen((_) => _read()),
    ];
  }

  final AuthRepository _auth;
  final OutboxRepository _outbox;
  final SessionState _session;
  final ConnectionCubit _connection;
  late final List<StreamSubscription<void>> _subs;

  /// Settings are local; the short wait only shows the Figma loading state.
  // TODO(MB-P58): read the session and port from secure storage (MB-F3).
  Future<void> load() async {
    emit(state.copyWith(loading: true));
    await Future<void>.delayed(const Duration(milliseconds: 400));
    if (isClosed) return;
    emit(state.copyWith(loading: false));
    _read();
  }

  void _read() {
    if (isClosed) return;
    final userId = _session.user?.userId;
    emit(
      state.copyWith(
        online: _connection.state,
        unsent: [
          for (final e in _outbox.events)
            if (e.userId == userId &&
                (e.status == OutboxStatus.pending ||
                    e.status == OutboxStatus.sending))
              e,
        ],
      ),
    );
  }

  /// Ends the session on this device. Pending events stay, owned by the
  /// same user (DEC-41). A failed server call still signs out locally.
  Future<void> logout() async {
    if (state.loggingOut) return;
    emit(state.copyWith(loggingOut: true));
    try {
      await _auth.logout();
    } on AppException {
      // Offline or server error: the local token is deleted anyway.
    }
    _session.signOut(byUser: true);
  }

  @override
  Future<void> close() async {
    for (final s in _subs) {
      await s.cancel();
    }
    return super.close();
  }
}
