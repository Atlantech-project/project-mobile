import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_sizes.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

/// Figma: Tabs (331:24883) built from Tab (331:24882).
class AppTabs extends StatelessWidget {
  const AppTabs({
    super.key,
    required this.labels,
    required this.selectedIndex,
    required this.onChanged,
  });

  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.borderDefault,
            width: AppSizes.borderThin,
          ),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (var i = 0; i < labels.length; i++)
              AppTab(
                label: labels[i],
                selected: i == selectedIndex,
                onTap: () => onChanged(i),
              ),
          ],
        ),
      ),
    );
  }
}

/// A single tab: default, hover and active states.
class AppTab extends StatefulWidget {
  const AppTab({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  State<AppTab> createState() => _AppTabState();
}

class _AppTabState extends State<AppTab> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final Color indicator;
    final TextStyle style;
    if (widget.selected) {
      indicator = AppColors.textPrimary;
      style = AppTextStyles.labelM.copyWith(color: AppColors.textPrimary);
    } else if (_hovered) {
      indicator = AppColors.borderStrong;
      style = AppTextStyles.bodyM.copyWith(color: AppColors.textPrimary);
    } else {
      indicator = Colors.transparent;
      style = AppTextStyles.bodyM.copyWith(color: AppColors.textMuted);
    }

    return Semantics(
      selected: widget.selected,
      button: true,
      child: InkWell(
        onTap: widget.onTap,
        onHover: (v) => setState(() => _hovered = v),
        child: Container(
          constraints: const BoxConstraints(minHeight: AppSizes.touch),
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: AppSpacing.s5,
            vertical: AppSpacing.s4,
          ),
          alignment: AlignmentDirectional.center,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: indicator,
                width: AppSizes.borderMedium,
              ),
            ),
          ),
          child: Text(widget.label, style: style),
        ),
      ),
    );
  }
}
