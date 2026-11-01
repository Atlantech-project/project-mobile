import 'package:flutter/material.dart';

import '../localization/l10n/app_localizations.dart';
import '../responsive/responsive.dart';
import '../theme/app_colors.dart';
import '../theme/app_sizes.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import 'app_button.dart';
import 'app_icon_button.dart';
import 'app_logo.dart';

/// Figma: Application header (245:7008, 88 tall). The app has no bottom
/// navigation; moving between pages goes through the header actions.
///
/// With [title] it shows the screen identity (title + [subtitle]). With only
/// [subtitle] it shows one muted line, as on the sign-in screens.
class AppHeader extends StatelessWidget {
  const AppHeader({
    super.key,
    this.title,
    this.subtitle,
    this.actions = const [],
    this.onBack,
    this.showLogo = true,
    this.leading,
  });

  final String? title;
  final String? subtitle;

  /// Usually [AppHeaderAction]s or an [AppConnectionStatus].
  final List<Widget> actions;

  /// Shows a back button at the start edge when set.
  final VoidCallback? onBack;
  final bool showLogo;

  /// A control between the logo and the title, e.g. P-55 "My Tasks".
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    final isTablet = context.isTablet;
    final margin = context.layout.margin;
    final gap = isTablet ? AppSpacing.s7 : AppSpacing.s4;

    Widget? identity;
    if (title != null) {
      identity = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpacing.s2,
        children: [
          Text(
            title!,
            style: isTablet ? AppTextStyles.h3Size26 : AppTextStyles.h3,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          if (subtitle != null)
            Text(
              subtitle!,
              style: AppTextStyles.bodyL.copyWith(color: AppColors.textMuted),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
        ],
      );
    } else if (subtitle != null) {
      identity = Text(
        subtitle!,
        style: AppTextStyles.body18.copyWith(color: AppColors.textMuted),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
    }

    return Container(
      height: AppSizes.headerHeight,
      padding: EdgeInsetsDirectional.symmetric(horizontal: margin),
      decoration: const BoxDecoration(
        color: AppColors.bgSurface,
        border: Border(
          bottom: BorderSide(
            color: AppColors.borderDefault,
            width: AppSizes.borderThin,
          ),
        ),
      ),
      child: Row(
        spacing: gap,
        children: [
          if (onBack != null) _BackButton(onPressed: onBack!),
          // Phones keep the width for the screen title.
          if (showLogo && isTablet) const AppLogo(),
          ?leading,
          Expanded(child: identity ?? const SizedBox.shrink()),
          ...actions,
        ],
      ),
    );
  }
}

/// A header action: outline tablet button with icon and label. On phones it
/// collapses to an icon-only 56 × 56 button with the label as tooltip.
class AppHeaderAction extends StatelessWidget {
  const AppHeaderAction({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    if (context.isTablet) {
      return AppButton.outline(label: label, icon: icon, onPressed: onPressed);
    }
    return AppIconButton(icon: icon, tooltip: label, onPressed: onPressed);
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    // Icons.arrow_back mirrors automatically in RTL.
    return AppIconButton(
      icon: Icons.arrow_back,
      tooltip: AppLocalizations.of(context).backAction,
      onPressed: onPressed,
    );
  }
}
