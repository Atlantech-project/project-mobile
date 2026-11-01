/// Route paths and names. Screen IDs follow the UI spec.
abstract final class AppRoutes {
  // Splash (first screen at every start)
  static const String splashPath = '/splash';
  static const String splashName = 'splash';

  // P-53
  static const String portPath = '/port';
  static const String portName = 'port';

  // P-52
  static const String loginPath = '/login';
  static const String loginName = 'login';

  // P-54
  static const String tasksPath = '/tasks';
  static const String tasksName = 'tasks';

  // P-55 (child of /tasks)
  static const String taskDetailsPath = '/tasks/:taskId';
  static const String taskDetailsSubPath = ':taskId';
  static const String taskDetailsName = 'taskDetails';
  static const String taskIdParam = 'taskId';

  // P-56
  static const String syncPath = '/sync';
  static const String syncName = 'sync';

  // P-19
  static const String notificationsPath = '/notifications';
  static const String notificationsName = 'notifications';

  // P-20
  static const String accessDeniedPath = '/access-denied';
  static const String accessDeniedName = 'accessDenied';

  // P-57
  static const String updateRequiredPath = '/update-required';
  static const String updateRequiredName = 'updateRequired';

  // P-58
  static const String settingsPath = '/settings';
  static const String settingsName = 'settings';

  // P-58 "Logout completed"
  static const String signedOutPath = '/signed-out';
  static const String signedOutName = 'signedOut';
}
