import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

/// Light theme only. Shared widgets in `core/widgets/` carry their own styling.
abstract final class AppTheme {
  static ThemeData get light {
    const colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.brandPrimary,
      onPrimary: AppColors.textInverse,
      secondary: AppColors.brandSecondary,
      onSecondary: AppColors.textInverse,
      tertiary: AppColors.brandAccent,
      onTertiary: AppColors.textInverse,
      error: AppColors.statusDangerFg,
      onError: AppColors.textInverse,
      surface: AppColors.bgSurface,
      onSurface: AppColors.textPrimary,
      onSurfaceVariant: AppColors.textSecondary,
      outline: AppColors.borderStrong,
      outlineVariant: AppColors.borderDefault,
      scrim: AppColors.bgOverlay,
      shadow: AppColors.shadow,
    );

    final textTheme = TextTheme(
      displayLarge: AppTextStyles.numberDisplay,
      displayMedium: AppTextStyles.tabletH1,
      displaySmall: AppTextStyles.h1,
      headlineLarge: AppTextStyles.h3Size26,
      headlineMedium: AppTextStyles.h2Size24,
      headlineSmall: AppTextStyles.h2,
      titleLarge: AppTextStyles.h3Size20,
      titleMedium: AppTextStyles.h3,
      titleSmall: AppTextStyles.h4,
      bodyLarge: AppTextStyles.bodyL,
      bodyMedium: AppTextStyles.bodyM,
      bodySmall: AppTextStyles.caption,
      labelLarge: AppTextStyles.labelL,
      labelMedium: AppTextStyles.labelM,
      labelSmall: AppTextStyles.labelS,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.bgPage,
      canvasColor: AppColors.bgPage,
      fontFamily: AppFonts.inter,
      textTheme: textTheme,
      dividerColor: AppColors.borderDefault,
      dividerTheme: const DividerThemeData(
        color: AppColors.borderDefault,
        thickness: 1,
        space: 1,
      ),
      focusColor: AppColors.borderFocus,
      iconTheme: const IconThemeData(color: AppColors.textPrimary),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.textPrimary,
        selectionHandleColor: AppColors.brandSecondary,
      ),
      splashFactory: InkRipple.splashFactory,
    );
  }
}
