import 'package:flutter/material.dart';

import '../../../core/localization/l10n/app_localizations.dart';
import '../../../core/widgets/dev_placeholder_screen.dart';

/// P-19 Notifications.
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return DevPlaceholderScreen(
      screenId: 'P-19',
      taskId: 'MB-P19',
      title: l10n.titleNotifications,
      showNavigation: false,
      showBack: true,
    );
  }
}
