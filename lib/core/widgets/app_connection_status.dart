import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../localization/l10n/app_localizations.dart';
import '../network/connection_cubit.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_sizes.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

/// Figma: header "Connection" (245:7739). A dot plus a text label. Info only,
/// not tappable; 56 tall to line up with the other header controls.
///
/// Follows the device's real connection ([ConnectionCubit]) unless [isOnline]
/// is given.
class AppConnectionStatus extends StatelessWidget {
  const AppConnectionStatus({super.key, this.isOnline, this.isUnknown = false});

  final bool? isOnline;

  /// The app cannot tell the connection (P-58). Not the same as offline.
  final bool isUnknown;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isOnline = this.isOnline ?? context.watch<ConnectionCubit>().state;
    return Container(
      height: AppSizes.touch,
      padding: const EdgeInsetsDirectional.symmetric(horizontal: AppSpacing.s5),
      decoration: BoxDecoration(
        borderRadius: AppRadius.smAll,
        border: Border.all(
          color: AppColors.borderStrong,
          width: AppSizes.borderThin,
        ),
      ),
      child: Semantics(
        liveRegion: true,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: AppSizes.indicatorGap,
          children: [
            Container(
              width: AppSizes.indicatorDot,
              height: AppSizes.indicatorDot,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isUnknown
                    ? AppColors.statusNeutralFg
                    : isOnline
                    ? AppColors.statusSuccessFg
                    : AppColors.statusDangerFg,
              ),
            ),
            Text(
              isUnknown
                  ? l10n.connectionUnknown
                  : isOnline
                  ? l10n.connectionOnline
                  : l10n.connectionOffline,
              style: AppTextStyles.h3,
            ),
          ],
        ),
      ),
    );
  }
}
