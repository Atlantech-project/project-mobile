import 'package:flutter/material.dart';

import '../../../core/localization/l10n/app_localizations.dart';
import '../../../core/widgets/dev_placeholder_screen.dart';

/// P-58 Settings.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return DevPlaceholderScreen(
      title: l10n.titleSettings,
      showNavigation: false,
      showBack: true,
    );
  }
}
