import 'package:flutter/painting.dart';

import 'app_colors.dart';

/// Elevation styles. Shadow color is navy/800.
abstract final class AppShadows {
  /// Elevation/1 · card.
  static final List<BoxShadow> elevation1 = [
    BoxShadow(
      color: AppColors.shadow.withValues(alpha: 0.08),
      offset: const Offset(0, 1),
      blurRadius: 2,
    ),
  ];

  /// Elevation/2 · dropdown.
  static final List<BoxShadow> elevation2 = [
    BoxShadow(
      color: AppColors.shadow.withValues(alpha: 0.12),
      offset: const Offset(0, 4),
      blurRadius: 12,
    ),
  ];

  /// Elevation/3 · dialog (used over [AppColors.overlayScrim]).
  static final List<BoxShadow> elevation3 = [
    BoxShadow(
      color: AppColors.shadow.withValues(alpha: 0.20),
      offset: const Offset(0, 12),
      blurRadius: 32,
    ),
  ];

  /// Focus ring: spread 3, blur 0, teal/500 at 45%.
  static final List<BoxShadow> focusRing = [
    BoxShadow(
      color: AppColors.borderFocus.withValues(alpha: 0.45),
      spreadRadius: 3,
    ),
  ];
}
