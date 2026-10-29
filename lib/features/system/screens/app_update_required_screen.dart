import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/injection.dart';
import '../../../core/localization/l10n/app_localizations.dart';
import '../../../core/localization/locale_cubit.dart';
import '../../../core/network/client_info.dart';
import '../../../core/router/session_state.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_connection_status.dart';
import '../../../core/widgets/app_header.dart';
import '../../../core/widgets/app_icon_button.dart';
import '../../../core/widgets/app_ltr.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/app_state_view.dart';

/// P-57 App Update Required.
///
/// The router shows this page, and only this page, once the server answers
/// 426 (`APP_UPDATE_REQUIRED`). The app cannot update itself on the closed
/// port network, so the page tells the user to have the new version
/// installed. A newly installed APK starts the app again, which clears the
/// block.
class AppUpdateRequiredScreen extends StatelessWidget {
  const AppUpdateRequiredScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final installed = getIt<ClientInfo>().appVersion;
    final required = getIt<SessionState>().minAppVersion;

    return AppScaffold(
      header: AppHeader(
        title: l10n.titleAppUpdateRequired,
        actions: [
          const AppConnectionStatus(),
          AppIconButton(
            icon: Icons.translate,
            tooltip: l10n.switchLanguage,
            onPressed: () => context.read<LocaleCubit>().toggle(),
          ),
        ],
      ),
      body: AppStateView.error(
        icon: Icons.system_update_outlined,
        title: l10n.updateRequiredTitle,
        message: l10n.updateRequiredMessage,
        details: AppCard(
          tone: AppCardTone.subtle,
          child: Column(
            spacing: AppSpacing.s3,
            children: [
              _VersionRow(
                label: l10n.updateInstalledVersion,
                version: installed,
              ),
              if (required != null)
                _VersionRow(
                  label: l10n.updateRequiredVersion,
                  version: required,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// One "label · version" line. The version stays LTR inside Arabic.
class _VersionRow extends StatelessWidget {
  const _VersionRow({required this.label, required this.version});

  final String label;
  final String version;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: AppTextStyles.labelL.copyWith(color: AppColors.textMuted),
          ),
        ),
        Text(ltrIsolate(version), style: AppTextStyles.h4),
      ],
    );
  }
}
