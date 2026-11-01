// DEV-ONLY (Flutter Screens): a fake port server and device store so every
// tablet screen runs without the backend. Each MB task replaces the mock
// repository that reads this with a real one; delete this folder when the
// last one lands.
import 'dart:async';

import '../errors/app_exception.dart';
import '../models/field_notification.dart';
import '../models/field_task.dart';
import '../models/field_user.dart';
import '../models/outbox_event.dart';
import '../models/port_info.dart';
import '../network/api_contract.dart';
import '../router/session_state.dart';
import 'mock_data.dart';

/// What `GET /system/info` answers in the mock (P-53 states).
enum MockPortScenario { identified, serverUnavailable, verificationFailed }

/// What the task list request does in the mock (P-54 states).
enum MockTasksScenario { normal, empty, fails }

/// What the next `POST /sync/events` does in the mock (P-56 states).
enum MockSyncScenario {
  /// The server applies every event.
  accept,

  /// The request fails before an answer; events go back to PENDING.
  transportFailure,
}

/// DEV-ONLY: in-memory fake of the port server and of the device storage.
///
/// Repositories call it with small delays so loading states show. The dev
/// state picker on each screen changes its scenarios.
class MockBackend {
  MockBackend(this._session);

  final SessionState _session;

  /// How long a fake request takes.
  static const Duration latency = Duration(milliseconds: 700);

  final _changes = StreamController<void>.broadcast();

  /// Fires after any change to tasks, the Outbox, notifications or the
  /// connection.
  Stream<void> get changes => _changes.stream;

  // ---- connection ----------------------------------------------------------

  bool _online = true;
  bool get online => _online;

  /// P-58 "Connection status unavailable": the app cannot tell.
  bool connectionUnknown = false;

  void setOnline(bool value) {
    _online = value;
    connectionUnknown = false;
    _notify();
    if (value) unawaited(syncNow());
  }

  // ---- scenarios -----------------------------------------------------------

  MockPortScenario portScenario = MockPortScenario.identified;
  MockTasksScenario tasksScenario = MockTasksScenario.normal;
  MockSyncScenario syncScenario = MockSyncScenario.accept;

  /// P-56 "Device wiped": show the warning about unsent events.
  bool deviceWiped = false;

  // ---- data ----------------------------------------------------------------

  List<FieldTask> _tasks = const [];
  final List<OutboxEvent> _outbox = [];
  List<FieldNotification> _notifications = const [];
  int _eventSeq = 0;

  List<FieldTask> get tasks => List.unmodifiable(_tasks);
  List<OutboxEvent> get outbox => List.unmodifiable(_outbox);
  List<FieldNotification> get notifications =>
      List.unmodifiable(_notifications);

  /// The time the device last received tasks from the server.
  DateTime? lastTaskSync;

  // ---- P-53 ----------------------------------------------------------------

  Future<PortInfo> identifyPort() async {
    await Future<void>.delayed(latency);
    if (!_online || portScenario == MockPortScenario.serverUnavailable) {
      throw const NetworkException();
    }
    if (portScenario == MockPortScenario.verificationFailed) {
      throw const ServerException(statusCode: 500);
    }
    return MockData.port;
  }

  // ---- P-52 ----------------------------------------------------------------

  Future<FieldUser> login(String username, String password) async {
    await Future<void>.delayed(latency);
    if (!_online) throw const NetworkException();
    final account = MockData.accounts[username.trim().toLowerCase()];
    if (account == null || password == MockData.wrongPassword) {
      throw const UnauthorizedException(
        messageKey: 'errors.auth.invalid_credentials',
      );
    }
    if (account.disabled) {
      throw const ForbiddenException(code: ApiErrorCodes.accountDisabled);
    }
    if (account.mustChangePassword) {
      _pendingPasswordChange = account.user;
      throw const ForbiddenException(
        code: ApiErrorCodes.passwordChangeRequired,
      );
    }
    _loadUserData(account.user);
    return account.user;
  }

  FieldUser? _pendingPasswordChange;

  Future<FieldUser> changePassword(String newPassword) async {
    await Future<void>.delayed(latency);
    if (!_online) throw const NetworkException();
    final user = _pendingPasswordChange;
    if (user == null) throw const UnauthorizedException();
    _pendingPasswordChange = null;
    _loadUserData(user);
    return user;
  }

  Future<void> logout() async {
    if (_online) await Future<void>.delayed(latency);
  }

  /// DEV-ONLY: loads [user]'s data without a sign-in, for state previews.
  void prepareUser(FieldUser user) {
    _loadUserData(user);
    _notify();
  }

  void _loadUserData(FieldUser user) {
    // A different user does not see the previous user's cached tasks. Their
    // Outbox events stay on the device (same-user rule).
    _tasks = MockData.tasksFor(user);
    _notifications = MockData.notificationsFor(user, _tasks);
    lastTaskSync = DateTime.now().toUtc();
  }

  // ---- P-54 / P-55 ---------------------------------------------------------

  Future<List<FieldTask>> fetchTasks() async {
    await Future<void>.delayed(latency);
    if (!_online) {
      if (tasksScenario == MockTasksScenario.empty) return const [];
      return tasks;
    }
    switch (tasksScenario) {
      case MockTasksScenario.fails:
        throw const ServerException(statusCode: 500);
      case MockTasksScenario.empty:
        return const [];
      case MockTasksScenario.normal:
        lastTaskSync = DateTime.now().toUtc();
        return tasks;
    }
  }

  /// Simulates a `TASK_UPDATED` event: the planner changed a task.
  void applyPlanChange(String taskId, SystemLabel label) {
    _tasks = [
      for (final t in _tasks)
        t.id == taskId
            ? t.copyWith(systemLabel: label, version: '${t.version}+1')
            : t,
    ];
    if (label == SystemLabel.cancelled) {
      final task = _tasks.firstWhere((t) => t.id == taskId);
      _notifications = [
        FieldNotification(
          id: 'NT-${_notifications.length + 1}',
          type: NotificationType.planCancelled,
          taskId: task.id,
          taskReference: task.reference,
          vesselName: task.vesselName,
          berth: task.berth,
          terminal: task.terminal,
          createdAt: DateTime.now().toUtc(),
        ),
        ..._notifications,
      ];
    }
    _notify();
  }

  /// Hides the `UPDATED` label once the user's own event is saved (MB-P55).
  void _clearUpdatedLabel(String taskId) {
    _tasks = [
      for (final t in _tasks)
        t.id == taskId && t.systemLabel == SystemLabel.updated
            ? t.copyWith(clearSystemLabel: true)
            : t,
    ];
  }

  // ---- Outbox --------------------------------------------------------------

  /// Saves an event on the device, then starts a sync when online (DEC-41).
  void enqueue({
    required FieldUser user,
    required FieldTask task,
    required OutboxEventType type,
    TaskStatus? newStatus,
  }) {
    _eventSeq++;
    _outbox.add(
      OutboxEvent(
        clientEventId:
            'evt-${DateTime.now().microsecondsSinceEpoch}-$_eventSeq',
        type: type,
        taskId: task.id,
        taskReference: task.reference,
        planReference: task.planReference,
        vesselName: task.vesselName,
        terminal: task.terminal,
        berth: task.berth,
        newStatus: newStatus,
        reportedAt: DateTime.now().toUtc(),
        userId: user.userId,
        username: user.username,
      ),
    );
    _clearUpdatedLabel(task.id);
    _notify();
    if (_online) unawaited(syncNow());
  }

  bool _syncing = false;

  /// Sends every PENDING event of the signed-in user, in Outbox order.
  Future<void> syncNow() async {
    final user = _session.user;
    if (_syncing || !_online || user == null) return;
    final batch = [
      for (final e in _outbox)
        if (e.status == OutboxStatus.pending && e.userId == user.userId) e,
    ];
    if (batch.isEmpty) return;
    _syncing = true;
    final now = DateTime.now().toUtc();
    _replaceAll(
      batch,
      (e) => e.copyWith(
        status: OutboxStatus.sending,
        attempts: e.attempts + 1,
        dispatchedAt: now,
      ),
    );
    await Future<void>.delayed(latency * 2);
    _syncing = false;

    if (!_online || syncScenario == MockSyncScenario.transportFailure) {
      _replaceAll(
        batch,
        (e) =>
            e.copyWith(status: OutboxStatus.pending, lastAttemptFailed: true),
      );
      return;
    }

    final accepted = DateTime.now().toUtc();
    _replaceAll(batch, (e) {
      final task = _tasks.where((t) => t.id == e.taskId).firstOrNull;
      if (task == null) {
        return e.copyWith(
          status: OutboxStatus.rejected,
          reason: RejectReason.notFound,
        );
      }
      if (task.systemLabel == SystemLabel.cancelled) {
        return e.copyWith(
          status: OutboxStatus.rejected,
          reason: RejectReason.planCancelled,
        );
      }
      if (task.systemLabel == SystemLabel.overridden) {
        return e.copyWith(
          status: OutboxStatus.rejected,
          reason: RejectReason.illegalTransition,
        );
      }
      _applyToTask(e, accepted);
      return e.copyWith(
        status: OutboxStatus.done,
        lastAttemptFailed: false,
        acceptedAt: accepted,
      );
    });
  }

  void _applyToTask(OutboxEvent e, DateTime at) {
    _tasks = [
      for (final t in _tasks)
        if (t.id != e.taskId)
          t
        else if (e.type == OutboxEventType.acknowledge)
          t.copyWith(acknowledgedAt: e.reportedAt)
        else
          t.copyWith(status: e.newStatus, statusAt: at),
    ];
    if (e.type == OutboxEventType.acknowledge) {
      // The server acknowledges every SENT row of the same task (MB-P19).
      _notifications = [
        for (final n in _notifications)
          n.taskId == e.taskId && n.status == NotificationStatus.sent
              ? n.copyWith(
                  status: NotificationStatus.acknowledged,
                  acknowledgedAt: e.reportedAt,
                )
              : n,
      ];
    }
  }

  void _replaceAll(
    List<OutboxEvent> batch,
    OutboxEvent Function(OutboxEvent) change,
  ) {
    final ids = {for (final e in batch) e.clientEventId};
    for (var i = 0; i < _outbox.length; i++) {
      if (ids.contains(_outbox[i].clientEventId)) {
        _outbox[i] = change(_outbox[i]);
      }
    }
    _notify();
  }

  /// Seeds one saved event for the P-56 previews.
  void seedEvent({
    required OutboxStatus status,
    bool failed = false,
    RejectReason? reason,
  }) {
    final user = _session.user ?? _session.lastUser;
    if (user == null || _tasks.isEmpty) return;
    final task = _tasks.first;
    final reported = DateTime.now().toUtc().subtract(
      const Duration(minutes: 1),
    );
    _eventSeq++;
    _outbox.add(
      OutboxEvent(
        clientEventId: 'evt-seed-$_eventSeq',
        type: OutboxEventType.statusUpdate,
        taskId: task.id,
        taskReference: task.reference,
        planReference: task.planReference,
        vesselName: task.vesselName,
        terminal: task.terminal,
        berth: task.berth,
        newStatus: TaskStatus.done,
        reportedAt: reported,
        userId: user.userId,
        username: user.username,
        status: status,
        attempts: status == OutboxStatus.pending && !failed ? 0 : 1,
        lastAttemptFailed: failed,
        reason: reason,
        dispatchedAt: status == OutboxStatus.pending && !failed
            ? null
            : reported.add(const Duration(seconds: 40)),
        acceptedAt: status == OutboxStatus.done
            ? reported.add(const Duration(seconds: 41))
            : null,
      ),
    );
    _notify();
  }

  void clearOutbox() {
    _outbox.clear();
    _notify();
  }

  // ---- P-19 ----------------------------------------------------------------

  bool notificationsFail = false;

  Future<List<FieldNotification>> fetchNotifications() async {
    await Future<void>.delayed(latency);
    if (_online && notificationsFail) {
      throw const ServerException(statusCode: 500);
    }
    return notifications;
  }

  /// Removes the notifications that match [where] (all when null).
  void removeNotifications([bool Function(FieldNotification)? where]) {
    _notifications = [
      for (final n in _notifications)
        if (where != null && !where(n)) n,
    ];
    _notify();
  }

  void _notify() => _changes.add(null);
}
