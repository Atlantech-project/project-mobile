import 'package:flutter/painting.dart';

import 'app_palette.dart';

/// Semantic color tokens (Light). The only colors widgets may use.
abstract final class AppColors {
  // bg
  static const Color bgPage = AppPalette.neutral50;
  static const Color bgSurface = AppPalette.white;
  static const Color bgSubtle = AppPalette.neutral100;
  static const Color bgMuted = AppPalette.neutral200;
  static const Color bgInverse = AppPalette.navy800;
  static const Color bgBrandTint = AppPalette.teal100;
  static const Color bgOverlay = AppPalette.navy950;

  /// Dialog scrim: bg/overlay (navy/950) at 33% opacity.
  static final Color overlayScrim = AppPalette.navy950.withValues(alpha: 0.33);

  // text
  static const Color textPrimary = AppPalette.navy900;
  static const Color textSecondary = AppPalette.neutral700;
  static const Color textMuted = AppPalette.neutral600;
  static const Color textDisabled = AppPalette.neutral400;
  static const Color textInverse = AppPalette.white;
  static const Color textLink = AppPalette.teal700;
  static const Color textAccent = AppPalette.gold700;

  // border
  static const Color borderDefault = AppPalette.neutral200;
  static const Color borderStrong = AppPalette.neutral300;
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
