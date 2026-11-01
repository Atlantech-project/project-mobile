// DEV-ONLY (Flutter Screens): lets the team walk every Figma state of a
// screen while the backend is not wired. Shows only in debug builds with
// mock data on. Labels are dev text, not user-facing, so they are not in the
// ARB files.
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../config/app_config.dart';
import '../theme/app_colors.dart';
import '../theme/app_sizes.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

/// DEV-ONLY: one state to preview.
class DevScenario {
  const DevScenario(this.label, this.apply);

  final String label;
  final VoidCallback apply;
}

/// DEV-ONLY: a small button at the bottom end of [child] that lists
/// [scenarios]. Renders [child] alone in release builds or without mocks.
class DevScenarioMenu extends StatelessWidget {
  const DevScenarioMenu({
    super.key,
    required this.scenarios,
    required this.child,
  });

  final List<DevScenario> scenarios;
  final Widget child;

  static bool get enabled => kDebugMode && AppConfig.useMockData;

  @override
  Widget build(BuildContext context) {
    if (!enabled || scenarios.isEmpty) return child;
    return Stack(
      children: [
        Positioned.fill(child: child),
        PositionedDirectional(
          end: AppSpacing.s5,
          bottom: AppSpacing.s5,
          child: Tooltip(
            message: 'Preview states (dev)',
            child: Material(
              color: AppColors.brandAccent,
              shape: const CircleBorder(),
              elevation: 2,
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: () => _open(context),
                child: const SizedBox.square(
                  dimension: AppSizes.touch,
                  child: Icon(
                    Icons.science_outlined,
                    color: AppColors.textInverse,
                    size: AppSizes.iconLg,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _open(BuildContext context) async {
    final picked = await showModalBottomSheet<DevScenario>(
      context: context,
      backgroundColor: AppColors.bgSurface,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) => SafeArea(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(context).height * 0.7,
          ),
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsetsDirectional.only(bottom: AppSpacing.s5),
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: AppSpacing.s7,
                  vertical: AppSpacing.s3,
                ),
                child: Text('Preview states (dev)', style: AppTextStyles.h3),
              ),
              for (final s in scenarios)
                ListTile(
                  minTileHeight: AppSizes.touch,
                  title: Text(s.label, style: AppTextStyles.bodyL),
                  onTap: () => Navigator.of(context).pop(s),
                ),
            ],
          ),
        ),
      ),
    );
    picked?.apply();
  }
}
