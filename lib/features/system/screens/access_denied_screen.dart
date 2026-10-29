import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/injection.dart';
import '../../../core/localization/l10n/app_localizations.dart';
import '../../../core/localization/locale_cubit.dart';
import '../../../core/router/session_state.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_connection_status.dart';
import '../../../core/widgets/app_header.dart';
import '../../../core/widgets/app_icon_button.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/app_state_view.dart';

/// P-20 Access Denied.
///
/// The router shows this page while [SessionState.accessDeniedReason] is set:
/// - [AccessDeniedReason.permission]: the server answered 403 (role or
///   terminal scope). "Back to My Tasks" clears it and the router returns to
///   P-54.
/// - [AccessDeniedReason.role]: signed in with a non-field role. There is no
///   page to go back to, so the action signs out.
///
/// The Outbox is kept in both cases.
class AccessDeniedScreen extends StatelessWidget {
  const AccessDeniedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final session = getIt<SessionState>();
    final isRole = session.accessDeniedReason == AccessDeniedReason.role;

    return AppScaffold(
      header: AppHeader(
        title: l10n.titleAccessDenied,
        actions: [
          const AppConnectionStatus(),
          AppIconButton(
            icon: Icons.translate,
            tooltip: l10n.switchLanguage,
            onPressed: () => context.read<LocaleCubit>().toggle(),
          ),
        ],
      ),
      body: AppStateView(
        kind: AppStateKind.error,
        icon: Icons.lock_outline,
        title: l10n.accessDeniedTitle,
        message: isRole
            ? l10n.accessDeniedRoleMessage
            : l10n.accessDeniedPermissionMessage,
        details: AppCard(
          tone: AppCardTone.subtle,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  l10n.accessDeniedReasonLabel,
                  style: AppTextStyles.labelL.copyWith(
                    color: AppColors.textMuted,
                  ),
                ),
              ),
              Text(
                isRole
                    ? l10n.accessDeniedReasonRole
                    : l10n.accessDeniedReasonPermission,
                style: AppTextStyles.h4,
              ),
            ],
          ),
        ),
        actionLabel: isRole ? l10n.signOutAction : l10n.backToMyTasksAction,
        onAction: isRole ? session.signOut : session.clearAccessDenied,
      ),
    );
  }
}
