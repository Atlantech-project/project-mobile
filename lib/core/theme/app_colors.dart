import 'package:flutter/painting.dart';

import 'app_palette.dart';

/// Semantic color tokens (Light). The only colors widgets may use.
///
/// Values follow the Figma variables. A few semantic tokens in Figma are set
/// to their own value instead of a primitive (bg/page, bg/subtle,
/// text/primary, text/secondary, text/accent, border/default,
/// border/strong); those are written as hex here.
abstract final class AppColors {
  // bg
  static const Color bgPage = Color(0xFFF7F5F2);
  static const Color bgSurface = AppPalette.white;
  static const Color bgSubtle = Color(0xFFF2EFEB);
  static const Color bgMuted = AppPalette.neutral200;
  static const Color bgInverse = AppPalette.navy800;
  static const Color bgBrandTint = AppPalette.teal100;
  static const Color bgOverlay = AppPalette.navy950;

  /// Dialog scrim: bg/overlay (navy/950) at 33% opacity.
  static final Color overlayScrim = AppPalette.navy950.withValues(alpha: 0.33);

  // text
  static const Color textPrimary = Color(0xFF0F2A36);
  static const Color textSecondary = Color(0xFF4B5F68);
  static const Color textMuted = AppPalette.neutral600;
  static const Color textDisabled = AppPalette.neutral400;
  static const Color textInverse = AppPalette.neutral200;
  static const Color textLink = AppPalette.teal700;
  static const Color textAccent = Color(0xFF7A6440);

  // border
  static const Color borderDefault = Color(0xFFD3DEDF);
  static const Color borderStrong = Color(0xFF8FA3AA);
  static const Color borderFocus = AppPalette.teal500;
  static const Color borderInverse = AppPalette.navy700;

  // brand
  static const Color brandPrimary = AppPalette.navy800;
  static const Color brandPrimaryHover = AppPalette.navy700;
  static const Color brandPrimaryPressed = AppPalette.navy900;
  static const Color brandSecondary = AppPalette.teal500;
  static const Color brandSecondaryHover = AppPalette.teal600;
  static const Color brandAccent = AppPalette.gold500;
  static const Color brandAccentTint = AppPalette.gold100;

  // status/info
  static const Color statusInfoBg = AppPalette.teal100;
  static const Color statusInfoBorder = AppPalette.teal300;
  static const Color statusInfoFg = AppPalette.teal800;

  // status/success
  static const Color statusSuccessBg = AppPalette.success50;
  static const Color statusSuccessBorder = AppPalette.success200;
  static const Color statusSuccessFg = AppPalette.success700;

  // status/warning
  static const Color statusWarningBg = AppPalette.warning50;
  static const Color statusWarningBorder = AppPalette.warning200;
  static const Color statusWarningFg = AppPalette.warning800;

  // status/danger
  static const Color statusDangerBg = AppPalette.danger50;
  static const Color statusDangerBorder = AppPalette.danger200;
  static const Color statusDangerFg = AppPalette.danger700;

  // status/neutral
  static const Color statusNeutralBg = AppPalette.neutral100;
  static const Color statusNeutralBorder = AppPalette.neutral300;
  static const Color statusNeutralFg = AppPalette.neutral700;

  // brand cover: the splash screen, the one dark brand moment of the app.
  // The reversed lockup sits on navy that deepens towards the edges.
  static const Color coverGlow = AppPalette.navy800;
  static const Color coverEdge = AppPalette.navy950;
  static const Color coverSea = AppPalette.teal500;
  static const Color coverSeaDeep = AppPalette.navy800;
  static const Color coverText = AppPalette.neutral200;
  static const Color coverAccent = AppPalette.gold400;
  static const Color coverTrack = AppPalette.teal200;

  // loading: the brand symbol filling with water.
  static const Color loadingEmpty = AppPalette.neutral300;
  static const Color loadingWaterBack = AppPalette.teal300;
  static const Color loadingWater = AppPalette.navy800;

  /// Shadow base for every elevation style (navy/800).
  static const Color shadow = AppPalette.navy800;
}
