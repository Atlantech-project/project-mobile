import 'package:flutter/painting.dart';

import 'app_colors.dart';

/// Font family names registered in pubspec.yaml.
abstract final class AppFonts {
  static const String montserrat = 'Montserrat';
  static const String inter = 'Inter';
  static const String robotoMono = 'RobotoMono';
}

/// One style per Figma text style. Height = lineHeight / fontSize.
///
/// Headings and numbers default to [AppColors.textPrimary], body text to
/// [AppColors.textSecondary]. Arabic falls back to the system font by design.
abstract final class AppTextStyles {
  static TextStyle _montserrat(
    double size,
    double lineHeight,
    FontWeight weight,
  ) => TextStyle(
    fontFamily: AppFonts.montserrat,
    fontSize: size,
    height: lineHeight / size,
    fontWeight: weight,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  static TextStyle _inter(double size, double lineHeight, FontWeight weight) =>
      TextStyle(
        fontFamily: AppFonts.inter,
        fontSize: size,
        height: lineHeight / size,
        fontWeight: weight,
        letterSpacing: 0,
        color: AppColors.textSecondary,
      );

  // Heading
  static final TextStyle h1 = _montserrat(28, 36, FontWeight.w600);
  static final TextStyle h2 = _montserrat(22, 30, FontWeight.w600);
  static final TextStyle h2Size24 = _montserrat(24, 32, FontWeight.w600);
  static final TextStyle h3 = _montserrat(18, 26, FontWeight.w600);
  static final TextStyle h3Size20 = _montserrat(20, 28, FontWeight.w600);
  static final TextStyle h3Size26 = _montserrat(26, 34, FontWeight.w600);
  static final TextStyle h4 = _montserrat(16, 24, FontWeight.w600);

  // Number
  static final TextStyle numberDisplay = _montserrat(32, 40, FontWeight.w700);
  static final TextStyle numberM = _montserrat(22, 28, FontWeight.w600);

  // Body
  static final TextStyle bodyL = _inter(16, 24, FontWeight.w400);
  static final TextStyle bodyM = _inter(14, 20, FontWeight.w400);
  static final TextStyle bodyS = _inter(13, 18, FontWeight.w400);
  static final TextStyle body18 = _inter(18, 26, FontWeight.w400);

  // Label
  static final TextStyle labelL = _inter(16, 22, FontWeight.w500);
  static final TextStyle labelM = _inter(14, 20, FontWeight.w500);
  static final TextStyle labelM13 = _inter(13, 18, FontWeight.w500);
  static final TextStyle labelS = _inter(12, 16, FontWeight.w500);

  // Strong
  static final TextStyle strongM = _inter(14, 20, FontWeight.w600);
  static final TextStyle strongS = _inter(13, 18, FontWeight.w600);
  static final TextStyle strongXS = _inter(12, 16, FontWeight.w600);

  static final TextStyle caption = _inter(12, 16, FontWeight.w400);

  /// Overline. Uppercase is applied by the caller (`text.toUpperCase()`).
  static final TextStyle overline = _inter(
    11,
    16,
    FontWeight.w600,
  ).copyWith(letterSpacing: 11 * 0.04);

  /// IDs and codes such as PT-A-0109 or an IMO number.
  static const TextStyle monoM = TextStyle(
    fontFamily: AppFonts.robotoMono,
    fontSize: 13,
    height: 20 / 13,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    color: AppColors.textSecondary,
  );

  // Tablet
  static final TextStyle tabletH1 = _montserrat(32, 40, FontWeight.w600);
  static final TextStyle tabletH2 = _montserrat(24, 32, FontWeight.w600);
  static final TextStyle tabletBody = _inter(18, 26, FontWeight.w400);
  static final TextStyle tabletLabel = _inter(18, 24, FontWeight.w500);
  static final TextStyle tabletCaption = _inter(14, 20, FontWeight.w400);
}
