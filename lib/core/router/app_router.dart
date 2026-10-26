import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/port_identification_screen.dart';
import '../../features/notifications/screens/notifications_screen.dart';
import '../../features/settings/screens/settings_screen.dart';
import '../../features/sync/screens/sync_outbox_screen.dart';
import '../../features/system/screens/access_denied_screen.dart';
import '../../features/system/screens/app_update_required_screen.dart';
import '../../features/tasks/screens/my_tasks_screen.dart';
import '../../features/tasks/screens/task_details_screen.dart';
import 'app_routes.dart';
import 'session_state.dart';

/// Owns the single [GoRouter]. Re-evaluates the redirect whenever
/// [SessionState] changes.
class AppRouter {
  AppRouter(this._session);

  final SessionState _session;

  late final GoRouter router = GoRouter(
    initialLocation: AppRoutes.portPath,
    refreshListenable: _session,
    redirect: _redirect,
    routes: [
      GoRoute(
        path: AppRoutes.portPath,
        name: AppRoutes.portName,
        builder: (context, state) => const PortIdentificationScreen(),
      ),
      GoRoute(
        path: AppRoutes.loginPath,
        name: AppRoutes.loginName,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.tasksPath,
        name: AppRoutes.tasksName,
        builder: (context, state) => const MyTasksScreen(),
        routes: [
          GoRoute(
            path: AppRoutes.taskDetailsSubPath,
            name: AppRoutes.taskDetailsName,
            builder: (context, state) => TaskDetailsScreen(
              taskId: state.pathParameters[AppRoutes.taskIdParam]!,
            ),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.syncPath,
        name: AppRoutes.syncName,
        builder: (context, state) => const SyncOutboxScreen(),
      ),
      GoRoute(
        path: AppRoutes.notificationsPath,
        name: AppRoutes.notificationsName,
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: AppRoutes.accessDeniedPath,
        name: AppRoutes.accessDeniedName,
        builder: (context, state) => const AccessDeniedScreen(),
      ),
      GoRoute(
        path: AppRoutes.updateRequiredPath,
        name: AppRoutes.updateRequiredName,
        builder: (context, state) => const AppUpdateRequiredScreen(),
      ),
      GoRoute(
        path: AppRoutes.settingsPath,
        name: AppRoutes.settingsName,
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  );

  String? _redirect(BuildContext context, GoRouterState state) {
    final location = state.matchedLocation;

    // 1. A forced update blocks everything else.
    if (_session.updateRequired) {
      return location == AppRoutes.updateRequiredPath
          ? null
          : AppRoutes.updateRequiredPath;
    }

    // 2. The port must be identified first.
    if (!_session.portIdentified) {
      return location == AppRoutes.portPath ? null : AppRoutes.portPath;
    }

    // 3. Not signed in: only P-53 and P-52 are reachable.
    if (!_session.isAuthenticated) {
      final onEntry =
          location == AppRoutes.portPath || location == AppRoutes.loginPath;
      return onEntry ? null : AppRoutes.loginPath;
    }

    // 4. A non-field role only sees P-20.
    if (_session.role == FieldRole.unsupported) {
      return location == AppRoutes.accessDeniedPath
          ? null
          : AppRoutes.accessDeniedPath;
    }

    // 5. Signed in on an entry screen (or a leftover gate screen): go to My Tasks.
    const entryPaths = {
      AppRoutes.portPath,
      AppRoutes.loginPath,
      AppRoutes.accessDeniedPath,
      AppRoutes.updateRequiredPath,
    };
    if (entryPaths.contains(location)) return AppRoutes.tasksPath;

    // 6. No redirect.
    return null;
  }
}
