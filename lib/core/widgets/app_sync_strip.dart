import 'package:flutter/material.dart';

import '../responsive/responsive.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_sizes.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import 'app_connection_status.dart';

/// Figma: "Connection and synchronization" (P-54, P-56, P-58). The connection
/// state, one line on the Outbox and a caption, with an optional action.
///
/// Connection is shown on its own: being online is not a sync confirmation.
class AppSyncStrip extends StatelessWidget {
  const AppSyncStrip({
    super.key,
    required this.title,
    this.caption,
    this.action,
    this.connectionUnknown = false,
  });

  final String title;
  final String? caption;
  final Widget? action;
  final bool connectionUnknown;

  @override
  Widget build(BuildContext context) {
    final text = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      spacing: AppSpacing.s2,
      children: [
        Text(title, style: AppTextStyles.h3),
        if (caption != null)
          Text(
            caption!,
            style: AppTextStyles.bodyM.copyWith(color: AppColors.textMuted),
          ),
      ],
    );
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.s5,
        vertical: AppSpacing.s3,
      ),
      decoration: BoxDecoration(
        color: AppColors.bgSurface,
        borderRadius: AppRadius.smAll,
        border: Border.all(
          color: AppColors.borderStrong,
          width: AppSizes.borderThin,
        ),
      ),
      child: context.isTablet
          ? Row(
              spacing: AppSpacing.s6,
              children: [
                AppConnectionStatus(isUnknown: connectionUnknown),
                Expanded(child: text),
                ?action,
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppSpacing.s3,
              children: [
                Row(
                  spacing: AppSpacing.s3,
                  children: [
                    AppConnectionStatus(isUnknown: connectionUnknown),
                    const Spacer(),
                    ?action,
                  ],
                ),
                text,
              ],
            ),
    );
  }
}
