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
}
