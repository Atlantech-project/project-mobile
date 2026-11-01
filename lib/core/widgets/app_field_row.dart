import 'package:flutter/widgets.dart';

import '../responsive/responsive.dart';
import '../theme/app_spacing.dart';

/// Lays out [children] side by side on a tablet (equal widths, or [flex])
/// and stacked on a phone.
class AppFieldRow extends StatelessWidget {
  const AppFieldRow({
    super.key,
    required this.children,
    this.flex,
    this.spacing = AppSpacing.s7,
  });

  final List<Widget> children;

  /// Optional flex factor per child on tablet.
  final List<int>? flex;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    if (!context.isTablet) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpacing.s4,
        children: children,
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spacing,
      children: [
        for (var i = 0; i < children.length; i++)
          Expanded(flex: flex?[i] ?? 1, child: children[i]),
      ],
    );
  }
}
