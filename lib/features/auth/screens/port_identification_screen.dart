import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/di/injection.dart';
import '../../../core/localization/l10n/app_localizations.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/router/session_state.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/dev_placeholder_screen.dart';

/// P-53 Port Identification.
class PortIdentificationScreen extends StatelessWidget {
  const PortIdentificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return DevPlaceholderScreen(
      screenId: 'P-53',
      taskId: 'MB-P53',
      title: l10n.titlePortIdentification,
      devActions: [
        // DEV-ONLY: real port identification comes in MB-P53.
        AppButton.primary(
          label: l10n.continueAction,
          expand: true,
          onPressed: () {
            getIt<SessionState>().markPortIdentified();
            // P-53 stays reachable after identification, so move on explicitly.
            context.go(AppRoutes.loginPath);
          },
        ),
      ],
    );
  }
}
