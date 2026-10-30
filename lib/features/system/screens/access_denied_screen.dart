import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/injection.dart';
import '../../../core/localization/l10n/app_localizations.dart';
import '../../../core/localization/locale_cubit.dart';
import '../../../core/router/session_state.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_sizes.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_connection_status.dart';
import '../../../core/widgets/app_header.dart';
import '../../../core/widgets/app_icon_button.dart';
import '../../../core/widgets/app_panel.dart';
import '../../../core/widgets/app_scaffold.dart';

/// P-20 Access Denied (Figma 245:32971, "Access explanation" card).
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
    final muted = AppTextStyles.bodyM.copyWith(color: AppColors.textMuted);

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
      body: AppPanel(
        children: [
          const _ErrorMark(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppSpacing.s3,
            children: [
              Text(l10n.accessDeniedTitle, style: AppTextStyles.h1),
              Text(
                isRole
                    ? l10n.accessDeniedRoleMessage
                    : l10n.accessDeniedPermissionMessage,
                style: AppTextStyles.bodyL,
              ),
            ],
          ),
          _Reason(
            text: isRole
                ? l10n.accessDeniedReasonRole
                : l10n.accessDeniedReasonPermission,
          ),
          Text(
            isRole ? l10n.accessDeniedRoleContact : l10n.accessDeniedContact,
            style: muted,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppSpacing.s3,
            children: [
              AppButton.primary(
                label: isRole ? l10n.signOutAction : l10n.backToMyTasksAction,
                icon: Icons.arrow_back,
                onPressed: isRole ? session.signOut : session.clearAccessDenied,
              ),
              Text(
                isRole
                    ? l10n.accessDeniedSignOutHint
                    : l10n.accessDeniedBackHint,
                style: muted,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Figma "Neutral error placeholder": a small subtle tile with "!".
class _ErrorMark extends StatelessWidget {
  const _ErrorMark();

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: Container(
        width: AppSizes.panelMarkTile,
        height: AppSizes.panelMarkTile,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.bgSubtle,
          borderRadius: AppRadius.smAll,
          border: Border.all(
            color: AppColors.borderDefault,
            width: AppSizes.borderThin,
          ),
        ),
        child: Icon(
          Icons.priority_high,
          size: AppSizes.iconMd,
          color: AppColors.textMuted,
        ),
      ),
    );
  }
}

/// Figma "Reason": a subtle box with a small label above the reason.
class _Reason extends StatelessWidget {
  const _Reason({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsetsDirectional.all(AppSpacing.s5),
      decoration: BoxDecoration(
        color: AppColors.bgSubtle,
        border: Border.all(
          color: AppColors.borderDefault,
          width: AppSizes.borderThin,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSizes.gapTight,
        children: [
          Text(l10n.accessDeniedReasonLabel, style: AppTextStyles.strongM),
          Text(text, style: AppTextStyles.bodyL),
        ],
      ),
    );
  }
}
