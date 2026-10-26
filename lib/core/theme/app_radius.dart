import 'package:flutter/painting.dart';

/// Corner radius tokens.
abstract final class AppRadius {
  static const double none = 0;

  /// Buttons, inputs, badges.
  static const double sm = 4;

  /// Cards, dialogs.
  static const double md = 8;

  /// Large panels.
  static const double lg = 12;

  /// Pills.
  static const double full = 999;

  static const BorderRadius noneAll = BorderRadius.zero;
  static const BorderRadius smAll = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius mdAll = BorderRadius.all(Radius.circular(md));
  static const BorderRadius lgAll = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius fullAll = BorderRadius.all(Radius.circular(full));
}
