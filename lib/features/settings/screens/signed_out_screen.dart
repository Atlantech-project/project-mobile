import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/di/injection.dart';
import '../../../core/localization/app_formats.dart';
import '../../../core/localization/l10n/app_localizations.dart';
import '../../../core/models/outbox_event.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/router/session_state.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_sizes.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/widgets.dart';
import '../../sync/data/outbox_repository.dart';
import '../../sync/widgets/event_texts.dart';
import '../widgets/info_row.dart';

/// P-58 "Logout completed" (Figma 245:5394). Shown after Log Out until the
/// next sign-in. No account settings are shown here.
class SignedOutScreen extends StatelessWidget {
  const SignedOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final owner = getIt<SessionState>().lastUser;
    final unsent = [
      for (final e in getIt<OutboxRepository>().events)
        if (e.userId == owner?.userId &&
            (e.status == OutboxStatus.pending ||
                e.status == OutboxStatus.sending))
          e,
    ];
    final latest = unsent.isEmpty ? null : unsent.last;

    return AppScaffold(
      header: AppHeader(
        title: l10n.signedOutHeader,
        actions: const [AppLanguageButton()],
      ),
      body: AppPanel(
        maxWidth: AppSizes.panelWide,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(l10n.signedOutTitle, style: AppTextStyles.h3Size26),
          const SizedBox(height: AppSpacing.s6),
          Text(
            l10n.signedOutMessage,
            style: AppTextStyles.body18.copyWith(color: AppColors.textPrimary),
          ),
          if (latest != null) ...[
            const SizedBox(height: AppSpacing.s6),
            RetainedEventsBox(
              title: l10n.signedOutPendingTitle(unsent.length),
              message: l10n.signedOutPendingMessage(
                ltrIsolate(owner?.username ?? ''),
              ),
            ),
            const SizedBox(height: AppSpacing.s6),
            InfoRow(
              label: l10n.signedOutDeviceRecord,
              value: l10n.signedOutDeviceRecordValue(
                l10n.eventAction(latest),
                AppFormats.time(latest.reportedAt),
              ),
            ),
            const SizedBox(height: AppSpacing.s6),
            InfoRow(
              label: l10n.eventDispatchLabel,
              value: l10n.signedOutDispatchValue,
            ),
            const SizedBox(height: AppSpacing.s6),
            InfoRow(
              label: l10n.eventAcceptanceLabel,
              value: l10n.eventAcceptance(latest),
            ),
          ],
          const SizedBox(height: AppSpacing.s6),
          AppButton.primary(
            label: l10n.loginAction,
            icon: Icons.login,
            expand: true,
            onPressed: () => context.go(AppRoutes.loginPath),
          ),
          const SizedBox(height: AppSpacing.s6),
          Text(
            l10n.signedOutFootnote,
            style: AppTextStyles.bodyM.copyWith(color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}
