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
        // DEV-ONLY (MB-P53): shows P-57 the way a 426 answer would.
        AppButton.outline(
          label: l10n.devMockUpdateRequired,
          expand: true,
          onPressed: () => getIt<SessionState>().setUpdateRequired(
            true,
            minAppVersion: '9.9.0',
          ),
        ),
        // DEV-ONLY (MB-P53): signs in as Pilot and shows P-20 the way a 403
        // answer would. "Back to My Tasks" then opens P-54.
        AppButton.outline(
          label: l10n.devMockAccessDenied,
          expand: true,
          onPressed: () => getIt<SessionState>()
            ..markPortIdentified()
            ..signIn(FieldRole.marinePilot)
            ..denyAccess(),
        ),
      ],
    );
  }
}
