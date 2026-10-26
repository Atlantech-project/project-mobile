import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_sizes.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

/// Figma: Card · Tone (331:24899).
enum AppCardTone { normal, subtle, info }

/// Figma: Card. Optional [title] and [description], then any [child].
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    this.title,
    this.description,
    this.child,
    this.tone = AppCardTone.normal,
    this.padding = const EdgeInsetsDirectional.all(AppSpacing.s5),
    this.onTap,
  });

  final String? title;
  final String? description;
  final Widget? child;
  final AppCardTone tone;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final (bg, border) = switch (tone) {
      AppCardTone.normal => (AppColors.bgSurface, AppColors.borderDefault),
      AppCardTone.subtle => (AppColors.bgSubtle, AppColors.borderDefault),
      AppCardTone.info => (AppColors.statusInfoBg, AppColors.statusInfoBorder),
    };

    final children = <Widget>[
      if (title != null) Text(title!, style: AppTextStyles.h4),
      if (description != null)
        Text(
          description!,
          style: AppTextStyles.bodyS.copyWith(color: AppColors.textMuted),
        ),
      ?child,
    ];

    return Material(
      color: bg,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.smAll,
        side: BorderSide(color: border, width: AppSizes.borderThin),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            spacing: AppSpacing.s3,
            children: children,
          ),
        ),
      ),
    );
  }
}
