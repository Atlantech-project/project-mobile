import 'package:flutter/material.dart';

import '../../../core/localization/l10n/app_localizations.dart';
import '../../../core/widgets/dev_placeholder_screen.dart';

/// P-20 Access Denied.
class AccessDeniedScreen extends StatelessWidget {
  const AccessDeniedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return DevPlaceholderScreen(
      title: l10n.titleAccessDenied,
      showNavigation: false,
      showBack: false,
    );
  }
}
