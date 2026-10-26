import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_sizes.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

/// Status tone shared by badges, notices and cards.
enum AppStatusTone { neutral, success, info, warning, danger }

/// Background, border and foreground for a status tone.
extension AppStatusToneColors on AppStatusTone {
  Color get bg => switch (this) {
    AppStatusTone.neutral => AppColors.statusNeutralBg,
    AppStatusTone.success => AppColors.statusSuccessBg,
    AppStatusTone.info => AppColors.statusInfoBg,
    AppStatusTone.warning => AppColors.statusWarningBg,
    AppStatusTone.danger => AppColors.statusDangerBg,
  };

  Color get border => switch (this) {
    AppStatusTone.neutral => AppColors.statusNeutralBorder,
    AppStatusTone.success => AppColors.statusSuccessBorder,
    AppStatusTone.info => AppColors.statusInfoBorder,
    AppStatusTone.warning => AppColors.statusWarningBorder,
    AppStatusTone.danger => AppColors.statusDangerBorder,
  };

  Color get fg => switch (this) {
    AppStatusTone.neutral => AppColors.statusNeutralFg,
    AppStatusTone.success => AppColors.statusSuccessFg,
    AppStatusTone.info => AppColors.statusInfoFg,
    AppStatusTone.warning => AppColors.statusWarningFg,
    AppStatusTone.danger => AppColors.statusDangerFg,
  };
}

/// Figma: Status badge (260:30). Status is always color plus a text label.
class AppStatusBadge extends StatelessWidget {
  const AppStatusBadge({
    super.key,
    required this.label,
    this.tone = AppStatusTone.neutral,
  });

  final String label;
  final AppStatusTone tone;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.s3,
        vertical: AppSizes.badgePaddingVertical,
      ),
      decoration: BoxDecoration(
        color: tone.bg,
        border: Border.all(color: tone.border, width: AppSizes.borderThin),
        borderRadius: AppRadius.smAll,
      ),
      child: Text(
        label,
        style: AppTextStyles.caption.copyWith(color: tone.fg),
        maxLines: 1,
      ),
    );
  }
}
