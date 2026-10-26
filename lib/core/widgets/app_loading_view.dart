import 'package:flutter/material.dart';

import '../responsive/responsive.dart';
import '../theme/app_colors.dart';
import '../theme/app_sizes.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import 'app_loading_indicator.dart';

/// A page body (or a section of one) that is loading: the filling symbol
/// with an optional line saying what is loading.
///
/// Use it as the `body` of an [AppScaffold] so the header stays usable while
/// the content loads. [compact] fits it inside a card or a list.
class AppLoadingView extends StatelessWidget {
  const AppLoadingView({
    super.key,
    this.message,
    this.value,
    this.compact = false,
  });

  /// What is loading, e.g. "Loading your tasks".
  final String? message;

  /// Known progress, 0 → 1. Null means indeterminate.
  final double? value;

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final size = compact
        ? AppSizes.loadingMd
        : context.isTablet
        ? AppSizes.loadingLg
        : AppSizes.loadingMd;
    final style =
        (compact || context.isPhone
                ? AppTextStyles.bodyL
                : AppTextStyles.tabletBody)
            .copyWith(color: AppColors.textMuted);

    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsetsDirectional.all(
          compact ? AppSpacing.s5 : context.layout.margin,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: compact ? AppSpacing.s4 : AppSpacing.s6,
          children: [
            AppLoadingIndicator(size: size, value: value),
            if (message != null)
              Text(message!, style: style, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
