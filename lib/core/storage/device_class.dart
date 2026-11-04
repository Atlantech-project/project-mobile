import 'dart:ui';

import '../models/outbox_event.dart';
import '../responsive/responsive.dart';

/// Detects the device class from the physical screen, not the app window,
/// so split screen does not change it: a shortest side of
/// [kTabletBreakpoint] dp or more is `TABLET`, otherwise `MOBILE` (MB-F3).
SyncSource detectDeviceClass() {
  final dispatcher = PlatformDispatcher.instance;
  final display = dispatcher.displays.firstOrNull;
  final view = dispatcher.implicitView;
  final Size size;
  if (display != null && !display.size.isEmpty) {
    size = display.size / display.devicePixelRatio;
  } else if (view != null) {
    size = view.physicalSize / view.devicePixelRatio;
  } else {
    // No screen reported: the app is tablet first.
    return SyncSource.tablet;
  }
  return size.shortestSide >= kTabletBreakpoint
      ? SyncSource.tablet
      : SyncSource.mobile;
}
