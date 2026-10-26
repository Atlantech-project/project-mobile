import 'package:flutter/material.dart';

import '../../../core/di/injection.dart';
import '../../../core/localization/l10n/app_localizations.dart';
import '../../../core/router/session_state.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/dev_placeholder_screen.dart';

/// P-52 Tablet Login.
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final session = getIt<SessionState>();
    return DevPlaceholderScreen(
      screenId: 'P-52',
      taskId: 'MB-P52',
      title: l10n.titleSignIn,
      devActions: [
        // DEV-ONLY: the real sign-in comes in MB-P52.
        AppButton.primary(
          label: l10n.devMockSignIn,
          expand: true,
          onPressed: () => session.signIn(FieldRole.marinePilot),
        ),
        // DEV-ONLY
        AppButton.outline(
          label: l10n.devMockSignInUnsupported,
          expand: true,
          onPressed: () => session.signIn(FieldRole.unsupported),
        ),
      ],
    );
  }
}
