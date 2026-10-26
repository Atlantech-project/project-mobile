import 'package:flutter/widgets.dart';

import '../theme/app_sizes.dart';
import '../theme/app_spacing.dart';

enum DeviceType { phone, tablet }

/// Shortest side at or above which the device is treated as a tablet.
const double kTabletBreakpoint = 600;

extension ResponsiveContext on BuildContext {
  DeviceType get deviceType =>
      MediaQuery.sizeOf(this).shortestSide >= kTabletBreakpoint
      ? DeviceType.tablet
      : DeviceType.phone;

  bool get isTablet => deviceType == DeviceType.tablet;

  bool get isPhone => deviceType == DeviceType.phone;

  /// Grid values for the current device type.
  ResponsiveLayout get layout => ResponsiveLayout.of(deviceType);
}

/// Grid per device type. Tablet values come from the tokens (1280 × 800 frame).
class ResponsiveLayout {
  const ResponsiveLayout._({
    required this.columns,
    required this.gutter,
    required this.margin,
  });

  static const ResponsiveLayout tablet = ResponsiveLayout._(
    columns: 8,
    gutter: AppSpacing.s5,
    margin: AppSpacing.s7,
  );
  static const ResponsiveLayout phone = ResponsiveLayout._(
    columns: 4,
    gutter: AppSpacing.s5,
    margin: AppSpacing.s5,
  );

  static ResponsiveLayout of(DeviceType type) =>
      type == DeviceType.tablet ? tablet : phone;

  final int columns;
  final double gutter;
  final double margin;

  /// Minimum touch target on both device types.
  double get minTouchTarget => AppSizes.touch;
}

/// Builds a different layout per device type. [phone] falls back to [tablet].
class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({super.key, required this.tablet, this.phone});

  final WidgetBuilder tablet;
  final WidgetBuilder? phone;

  @override
  Widget build(BuildContext context) {
    if (context.isPhone && phone != null) return phone!(context);
    return tablet(context);
  }
}
