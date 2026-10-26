import 'package:flutter/material.dart';

import '../../../core/localization/l10n/app_localizations.dart';
import '../../../core/widgets/app_ltr.dart';
import '../../../core/widgets/dev_placeholder_screen.dart';

/// P-55 Task Details.
class TaskDetailsScreen extends StatelessWidget {
  const TaskDetailsScreen({super.key, required this.taskId});

  final String taskId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return DevPlaceholderScreen(
      title: l10n.titleTaskDetails,
      showNavigation: true,
      showBack: true,
      devActions: [AppIdText(taskId)],
    );
  }
}
