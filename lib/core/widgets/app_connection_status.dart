import 'package:flutter/material.dart';

import '../localization/l10n/app_localizations.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_sizes.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

/// Figma: header "Connection" (245:7739). A dot plus a text label. Info only,
/// not tappable; 56 tall to line up with the other header controls.
class AppConnectionStatus extends StatelessWidget {
  const AppConnectionStatus({super.key, required this.isOnline});

  final bool isOnline;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
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
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: AppSizes.indicatorGap,
        children: [
          Container(
            width: AppSizes.indicatorDot,
            height: AppSizes.indicatorDot,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isOnline
                  ? AppColors.statusSuccessFg
                  : AppColors.statusDangerFg,
            ),
          ),
          Text(
            isOnline ? l10n.connectionOnline : l10n.connectionOffline,
            style: AppTextStyles.h3,
          ),
        ],
      ),
    );
  }
}
