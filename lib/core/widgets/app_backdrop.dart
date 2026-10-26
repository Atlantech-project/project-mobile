import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Figma: P-52 sign-in background. The port photo at 60% opacity over
/// bg/inverse (navy/800), cropped to cover.
class AppBackdrop extends StatelessWidget {
  const AppBackdrop({super.key, required this.child});

  static const String asset = 'assets/images/login_background.jpg';

  /// Image opacity from the design.
  static const double imageOpacity = 0.6;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const ColoredBox(color: AppColors.bgInverse),
        Opacity(
          opacity: imageOpacity,
          child: Image.asset(
            asset,
            fit: BoxFit.cover,
            excludeFromSemantics: true,
          ),
        ),
        child,
      ],
    );
  }
}
