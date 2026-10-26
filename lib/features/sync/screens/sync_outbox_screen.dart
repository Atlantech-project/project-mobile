import 'package:flutter/material.dart';

import '../../../core/localization/l10n/app_localizations.dart';
import '../../../core/widgets/dev_placeholder_screen.dart';

/// P-56 Sync / Outbox.
class SyncOutboxScreen extends StatelessWidget {
  const SyncOutboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return DevPlaceholderScreen(
      screenId: 'P-56',
      taskId: 'MB-P56',
      title: l10n.titleSyncOutbox,
      showNavigation: true,
      showBack: true,
    );
  }
}
