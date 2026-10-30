import 'package:flutter/material.dart';

import '../../../core/di/injection.dart';
import '../../../core/localization/l10n/app_localizations.dart';
import '../../../core/network/client_info.dart';
import '../../../core/responsive/responsive.dart';
import '../../../core/router/session_state.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_sizes.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_ltr.dart';
import '../../../core/widgets/app_notice.dart';
import '../../../core/widgets/app_panel.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/app_status_badge.dart';

/// P-57 App Update Required (Figma 245:8406, "Update link unavailable").
///
/// The router shows this page, and only this page, once the server answers
/// 426 (`APP_UPDATE_REQUIRED`). There is no update link: the new APK reaches
/// the port as a file or is installed by an administrator, so the page has
/// no action. A newly installed APK starts the app again, which clears the
/// block. Like the design, the page has no header.
class AppUpdateRequiredScreen extends StatelessWidget {
  const AppUpdateRequiredScreen({super.key});

  static const String _lockup = 'assets/images/brand/lockup_color.png';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isTablet = context.isTablet;
    final installed = getIt<ClientInfo>().appVersion;
    final required = getIt<SessionState>().minAppVersion;

    return AppScaffold(
      body: AppPanel(
        maxWidth: AppSizes.panelWide,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Image.asset(
              _lockup,
              width: AppSizes.logoLockupWidth,
              fit: BoxFit.contain,
              semanticLabel: 'ATLANTECH',
              filterQuality: FilterQuality.medium,
            ),
          ),
          Text(
            l10n.updateRequiredTitle,
            style: isTablet ? AppTextStyles.tabletH1 : AppTextStyles.h1,
            textAlign: TextAlign.center,
          ),
          Text(
            l10n.updateRequiredMessage,
            style: isTablet ? AppTextStyles.tabletBody : AppTextStyles.bodyL,
            textAlign: TextAlign.center,
          ),
          _VersionInfo(
            installed: installed,
            required: required ?? l10n.updateRequiredVersionUnknown,
          ),
          AppNotice(
            title: l10n.updateNoticeTitle,
            message: l10n.updateNoticeMessage,
            tone: AppStatusTone.neutral,
            stacked: true,
          ),
          Text(
            l10n.updateGuidance,
            style: AppTextStyles.h3,
            textAlign: TextAlign.center,
          ),
          Text(
            l10n.updateBlocked,
            style: AppTextStyles.h4,
            textAlign: TextAlign.center,
          ),
          Text(
            l10n.updateOutboxNote,
            style: AppTextStyles.bodyM.copyWith(color: AppColors.textMuted),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// Figma "Version information": installed and required side by side between
/// two rules, stacked on phone. Versions stay LTR inside Arabic.
class _VersionInfo extends StatelessWidget {
  const _VersionInfo({required this.installed, required this.required});

  final String installed;
  final String required;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final fields = [
      _VersionField(label: l10n.updateInstalledVersion, value: installed),
      _VersionField(label: l10n.updateRequiredVersion, value: required),
    ];
    const rule = BorderSide(
      color: AppColors.borderDefault,
      width: AppSizes.borderThin,
    );

    return Container(
      padding: const EdgeInsetsDirectional.symmetric(vertical: AppSpacing.s5),
      decoration: const BoxDecoration(
        border: Border(top: rule, bottom: rule),
      ),
      child: context.isTablet
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppSpacing.s7,
              children: [for (final f in fields) Expanded(child: f)],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: AppSpacing.s5,
              children: fields,
            ),
    );
  }
}

class _VersionField extends StatelessWidget {
  const _VersionField({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSizes.gapTight,
      children: [
        Text(
          label,
          style: AppTextStyles.bodyL.copyWith(color: AppColors.textMuted),
        ),
        Text(ltrIsolate(value), style: AppTextStyles.h3),
      ],
    );
  }
}
