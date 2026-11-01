import 'package:flutter/material.dart';

import '../../../core/responsive/responsive.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_sizes.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/widgets.dart';

/// Figma "Read-only information row" (P-58): a fixed label column, then the
/// value. On phones the label goes above the value.
class InfoRow extends StatelessWidget {
  const InfoRow({
    super.key,
    required this.label,
    required this.value,
    this.ltrValue = false,
  });

  final String label;
  final String value;
  final bool ltrValue;

  @override
  Widget build(BuildContext context) {
    if (!context.isTablet) {
      return AppInfoField(label: label, value: value, ltrValue: ltrValue);
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      spacing: AppSpacing.s6,
      children: [
        SizedBox(
          width: AppSizes.infoRowLabel,
          child: Text(
            label,
            style: AppTextStyles.bodyL.copyWith(color: AppColors.textMuted),
          ),
        ),
        Expanded(
          child: Text(
            ltrValue ? ltrIsolate(value) : value,
            style: AppTextStyles.tabletLabel.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}

/// Figma "Information card" (P-58): a white card with a section title.
class InfoCard extends StatelessWidget {
  const InfoCard({super.key, required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: AppSpacing.s3,
        children: [
          Text(title, style: AppTextStyles.h2),
          const SizedBox(height: AppSpacing.s1),
          ...children,
        ],
      ),
    );
  }
}

/// Figma "Retained-event warning" / "Preserved pending updates": a tinted
/// box that says unsent events stay on the device.
class RetainedEventsBox extends StatelessWidget {
  const RetainedEventsBox({
    super.key,
    required this.title,
    required this.message,
  });

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.all(AppSpacing.s5),
      decoration: BoxDecoration(
        color: AppColors.statusWarningBg,
        borderRadius: AppRadius.smAll,
        border: Border.all(
          color: AppColors.statusWarningBorder,
          width: AppSizes.borderThin,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpacing.s3,
        children: [
          Text(title, style: AppTextStyles.h3),
          Text(
            message,
            style: AppTextStyles.bodyL.copyWith(color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }
}
