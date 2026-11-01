// DEV-ONLY (Flutter Screens): sample records that match the Figma frames.
import '../models/field_notification.dart';
import '../models/field_task.dart';
import '../models/field_user.dart';
import '../models/port_info.dart';
import '../router/session_state.dart';

/// DEV-ONLY: one mock account.
class MockAccount {
  const MockAccount(
    this.user, {
    this.disabled = false,
    this.mustChangePassword = false,
  });

  final FieldUser user;
  final bool disabled;
  final bool mustChangePassword;
}

/// DEV-ONLY: sample data. Any password signs in except [wrongPassword].
abstract final class MockData {
  static const String wrongPassword = 'wrong';

  static const PortInfo port = PortInfo(
    portId: '1',
    portCode: 'PORT-ALX',
    portName: 'Alexandria Port',
    minAppVersion: '1.0.0',
  );

  static const FieldUser pilot = FieldUser(
    userId: 'u-101',
    username: 'm.farid',
    displayName: 'M. Farid',
    role: FieldRole.marinePilot,
    terminalIds: ['A'],
  );

  static const FieldUser tugMaster = FieldUser(
    userId: 'u-102',
    username: 's.hassan',
    displayName: 'S. Hassan',
    role: FieldRole.tugMaster,
    terminalIds: ['A'],
  );

  static const FieldUser ctSupervisor = FieldUser(
    userId: 'u-103',
    username: 'n.adel',
    displayName: 'N. Adel',
    role: FieldRole.ctSupervisor,
    terminalIds: ['A'],
  );

  /// Usernames to try on P-52.
  static const Map<String, MockAccount> accounts = {
    'm.farid': MockAccount(pilot),
    's.hassan': MockAccount(tugMaster),
    'n.adel': MockAccount(ctSupervisor),
    'new.pilot': MockAccount(
      FieldUser(
        userId: 'u-104',
        username: 'new.pilot',
        displayName: 'A. Salem',
        role: FieldRole.marinePilot,
        terminalIds: ['A'],
      ),
      mustChangePassword: true,
    ),
    'disabled.user': MockAccount(
      FieldUser(
        userId: 'u-105',
        username: 'disabled.user',
        displayName: 'K. Omar',
        role: FieldRole.marinePilot,
      ),
      disabled: true,
    ),
    'web.user': MockAccount(
      FieldUser(
        userId: 'u-106',
        username: 'web.user',
        displayName: 'H. Nabil',
        role: FieldRole.unsupported,
      ),
    ),
  };

  static DateTime _today(int hour, int minute) {
    final now = DateTime.now().toUtc();
    return DateTime.utc(now.year, now.month, now.day, hour, minute);
  }

  static List<FieldTask> tasksFor(FieldUser user) {
    final type = switch (user.role) {
      FieldRole.tugMaster => TaskComponentType.tug,
      FieldRole.ctSupervisor ||
      FieldRole.nctSupervisor => TaskComponentType.terminalOps,
      _ => TaskComponentType.pilot,
    };
    final prefix = switch (type) {
      TaskComponentType.pilot => 'PT',
      TaskComponentType.tug => 'TG',
      TaskComponentType.terminalOps => 'CT',
    };
    return [
      FieldTask(
        id: '${prefix}1',
        reference: '$prefix-A-0109',
        planReference: 'OP-A-0109',
        terminal: 'Terminal A',
        componentType: type,
        vesselName: 'Delta Hope',
        berth: 'A-01',
        plannedStart: _today(11, 50),
        plannedEnd: _today(12, 45),
        version: 'v1',
        tugs: const ['T-01', 'T-02'],
        pilotName: pilot.displayName,
        notificationId: 'NT-1',
      ),
      FieldTask(
        id: '${prefix}2',
        reference: '$prefix-A-0112',
        planReference: 'OP-A-0112',
        terminal: 'Terminal A',
        componentType: type,
        vesselName: 'Nile Star',
        berth: 'A-03',
        plannedStart: _today(14, 30),
        plannedEnd: _today(15, 20),
        version: 'v3',
        tugs: const ['T-03'],
        pilotName: pilot.displayName,
        status: TaskStatus.started,
        statusAt: _today(14, 32),
        acknowledgedAt: _today(13, 58),
        systemLabel: SystemLabel.updated,
        notificationId: 'NT-2',
      ),
      FieldTask(
        id: '${prefix}3',
        reference: '$prefix-A-0098',
        planReference: 'OP-A-0098',
        terminal: 'Terminal A',
        componentType: type,
        vesselName: 'Red Sea Pearl',
        berth: 'A-02',
        plannedStart: _today(8, 10),
        plannedEnd: _today(9, 0),
        version: 'v2',
        tugs: const ['T-01'],
        pilotName: pilot.displayName,
        status: TaskStatus.done,
        statusAt: _today(9, 4),
        acknowledgedAt: _today(7, 40),
      ),
    ];
  }

  static List<FieldNotification> notificationsFor(
    FieldUser user,
    List<FieldTask> tasks,
  ) {
    FieldNotification n(
      String id,
      NotificationType type,
      FieldTask task,
      DateTime at, {
      NotificationStatus status = NotificationStatus.sent,
      DateTime? acknowledgedAt,
    }) => FieldNotification(
      id: id,
      type: type,
      taskId: task.id,
      taskReference: task.reference,
      vesselName: task.vesselName,
      berth: task.berth,
      terminal: task.terminal,
      createdAt: at,
      status: status,
      acknowledgedAt: acknowledgedAt,
    );

    return [
      n(
        'NT-4',
        NotificationType.preExecutionReminder,
        tasks[0],
        _today(11, 20),
      ),
      n('NT-1', NotificationType.planAssignment, tasks[0], _today(10, 26)),
      n(
        'NT-2',
        NotificationType.planAssignment,
        tasks[1],
        _today(10, 24),
        status: NotificationStatus.failed,
      ),
      n(
        'NT-3',
        NotificationType.planAssignment,
        tasks[2],
        _today(7, 30),
        status: NotificationStatus.acknowledged,
        acknowledgedAt: _today(7, 40),
      ),
    ];
  }
}
