import 'package:flutter/material.dart';

import '../../../core/localization/l10n/app_localizations.dart';
import '../../../core/widgets/dev_placeholder_screen.dart';

/// P-57 App Update Required.
class AppUpdateRequiredScreen extends StatelessWidget {
  const AppUpdateRequiredScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return DevPlaceholderScreen(
      screenId: 'P-57',
      taskId: 'MB-P57',
      title: l10n.titleAppUpdateRequired,
      showNavigation: false,
      showBack: false,
    );
  }
}
