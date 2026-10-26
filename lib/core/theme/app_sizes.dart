/// Size, border and layout tokens.
abstract final class AppSizes {
  static const double controlSm = 32;
  static const double controlMd = 40;
  static const double controlLg = 48;

  /// Minimum touch target on every device type.
  static const double touch = 56;

  static const double iconSm = 16;
  static const double iconMd = 20;
  static const double iconLg = 24;

  static const double borderThin = 1;
  static const double borderMedium = 2;

  // Layout (tablet frame 1280 × 800).
  static const double headerHeight = 88;
  static const double footerHeight = 40;

  // Component metrics read from the Figma Components page (260:2) that have
  // no variable of their own. Kept here so widgets never hardcode them.
  /// Button Size=Web height.
  static const double buttonWeb = 36;

  /// Button Size=Compact height.
  static const double buttonCompact = 28;

  /// Gap between icon and label in buttons, and between field rows.
  static const double gapTight = 6;

  /// Status badge vertical padding (badge is 24 tall).
  static const double badgePaddingVertical = 3;

  /// Width of the status stripe on the start edge of a notice.
  static const double noticeStripe = 4;

  /// Heading column of a notice on tablet.
  static const double noticeHeadingWidth = 330;

  /// Gap between the connection dot and its label.
  static const double indicatorGap = 10;

  /// Connection indicator dot in the header.
  static const double indicatorDot = 10;

  /// ATLANTECH logo in the application header (148 × 22.8).
  static const double logoHeaderWidth = 148;

  /// Widest the splash lockup gets (tablet). Phones use a share of the width.
  static const double splashLockupMax = 360;

  /// Gold progress hairline under the splash lockup.
  static const double splashProgressWidth = 120;

  /// Loading symbol: full page, inside a section, inline.
  static const double loadingLg = 120;
  static const double loadingMd = 72;
  static const double loadingSm = 40;

  /// Empty and error states: the icon circle (compact), its icon, the badge
  /// on the symbol (full page) and the widest the text column gets.
  static const double stateArt = 72;
  static const double stateArtIcon = 32;
  static const double stateBadge = 40;
  static const double stateBadgeIcon = 22;
  static const double stateTextMax = 480;
}
