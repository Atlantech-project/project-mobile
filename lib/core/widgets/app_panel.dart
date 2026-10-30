import 'package:flutter/material.dart';

import '../responsive/responsive.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_sizes.dart';
import '../theme/app_spacing.dart';

/// Figma: the centered panel of a blocking page (P-57 "Mandatory update
/// panel", P-20 "Access explanation"). A surface card at most [maxWidth]
/// wide, centered in the body, scrolling when it does not fit.
class AppPanel extends StatelessWidget {
  const AppPanel({
    super.key,
    required this.children,
    this.maxWidth = AppSizes.panelNarrow,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  final List<Widget> children;
  final double maxWidth;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final isTablet = context.isTablet;
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsetsDirectional.all(context.layout.margin),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Container(
            padding: EdgeInsetsDirectional.all(
              isTablet ? AppSpacing.s8 : AppSpacing.s6,
            ),
            decoration: BoxDecoration(
              color: AppColors.bgSurface,
              borderRadius: AppRadius.smAll,
              border: Border.all(
                color: AppColors.borderDefault,
                width: AppSizes.borderThin,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: crossAxisAlignment,
              spacing: AppSpacing.s6,
              children: children,
            ),
          ),
        ),
      ),
    );
  }
}
