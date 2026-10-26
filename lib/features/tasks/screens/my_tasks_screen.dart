import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/di/injection.dart';
import '../../../core/localization/l10n/app_localizations.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/router/session_state.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/dev_placeholder_screen.dart';

/// P-54 My Tasks.
class MyTasksScreen extends StatelessWidget {
  const MyTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return DevPlaceholderScreen(
      screenId: 'P-54',
      taskId: 'MB-P54',
      title: l10n.titleMyTasks,
      showNavigation: true,
      devActions: [
        // DEV-ONLY: sample navigation until the task list exists.
        AppButton.secondary(
          label: l10n.devOpenSampleTask,
          expand: true,
          onPressed: () => context.push('${AppRoutes.tasksPath}/PT-A-0109'),
        ),
        // DEV-ONLY
        AppButton.secondary(
          label: l10n.titleSyncOutbox,
          icon: Icons.sync,
          expand: true,
          onPressed: () => context.push(AppRoutes.syncPath),
        ),
        // DEV-ONLY: real sign-out comes with the session work (MB-F3).
        AppButton.outline(
          label: l10n.devMockSignOut,
          expand: true,
          onPressed: () => getIt<SessionState>().signOut(),
        ),
      ],
    );
  }
}
