import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_sizes.dart';
import '../theme/app_text_styles.dart';

/// Figma: "Information field". A muted label above a value.
class AppInfoField extends StatelessWidget {
  const AppInfoField({
    super.key,
    required this.label,
    required this.value,
    this.valueStyle,
  });

  final String label;
  final String value;

  /// Defaults to Heading/H4. Use [AppTextStyles.h2] or larger for the main
  /// value of a card.
  final TextStyle? valueStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      spacing: AppSizes.gapTight,
      children: [
        Text(
          label,
          style: AppTextStyles.bodyM.copyWith(color: AppColors.textMuted),
        ),
        Text(value, style: valueStyle ?? AppTextStyles.h4),
      ],
    );
  }
}
