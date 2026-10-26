import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_sizes.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

/// Figma: Button (260:19) · Type.
enum AppButtonVariant { primary, secondary, outline }

/// Figma: Button · Size. [tablet] is the default for the field app (56 tall).
enum AppButtonSize { tablet, web, compact }

/// The one button of the design system.
///
/// Disabled when [onPressed] is null (Figma Type=Disabled). Hover, pressed and
/// focus states follow the Figma variants.
class AppButton extends StatefulWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.tablet,
    this.icon,
    this.expand = false,
    this.isLoading = false,
  });

  const AppButton.primary({
    super.key,
    required this.label,
    required this.onPressed,
    this.size = AppButtonSize.tablet,
    this.icon,
    this.expand = false,
    this.isLoading = false,
  }) : variant = AppButtonVariant.primary;

  const AppButton.secondary({
    super.key,
    required this.label,
    required this.onPressed,
    this.size = AppButtonSize.tablet,
    this.icon,
    this.expand = false,
    this.isLoading = false,
  }) : variant = AppButtonVariant.secondary;

  const AppButton.outline({
    super.key,
    required this.label,
    required this.onPressed,
    this.size = AppButtonSize.tablet,
    this.icon,
    this.expand = false,
    this.isLoading = false,
  }) : variant = AppButtonVariant.outline;

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonSize size;

  /// Leading icon. Use a directional icon (e.g. `Icons.arrow_back`) when it
  /// must mirror in RTL.
  final IconData? icon;

  /// Fill the available width.
  final bool expand;

  /// Shows a progress indicator and blocks taps.
  final bool isLoading;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _hovered = false;
  bool _pressed = false;
  bool _focused = false;

  bool get _enabled => widget.onPressed != null && !widget.isLoading;

  double get _height => switch (widget.size) {
    AppButtonSize.tablet => AppSizes.touch,
    AppButtonSize.web => AppSizes.buttonWeb,
    AppButtonSize.compact => AppSizes.buttonCompact,
  };

  double get _paddingH =>
      widget.size == AppButtonSize.tablet ? AppSpacing.s6 : AppSpacing.s4;

  double get _iconSize =>
      widget.size == AppButtonSize.tablet ? AppSizes.iconMd : AppSizes.iconSm;

  // Tablet screens in the UI Design page use Heading/H3 (18/26) on buttons.
  TextStyle get _labelStyle => switch (widget.size) {
    AppButtonSize.tablet => AppTextStyles.h3,
    AppButtonSize.web => AppTextStyles.labelM13,
    AppButtonSize.compact => AppTextStyles.labelS,
  };

  ({Color bg, Color border, double borderWidth, Color fg}) _colors() {
    if (!_enabled) {
      return (
        bg: AppColors.bgSubtle,
        border: AppColors.borderDefault,
        borderWidth: AppSizes.borderThin,
        fg: AppColors.textMuted,
      );
    }
    if (_focused && !_pressed && !_hovered) {
      return (
        bg: widget.variant == AppButtonVariant.primary
            ? AppColors.brandPrimary
            : AppColors.bgSurface,
        border: AppColors.borderFocus,
        borderWidth: AppSizes.borderMedium,
        fg: widget.variant == AppButtonVariant.primary
            ? AppColors.textInverse
            : AppColors.textPrimary,
      );
    }
    switch (widget.variant) {
      case AppButtonVariant.primary:
        final bg = _pressed
            ? AppColors.brandPrimaryPressed
            : _hovered
            ? AppColors.brandPrimaryHover
            : AppColors.brandPrimary;
        return (
          bg: bg,
          border: bg,
          borderWidth: AppSizes.borderThin,
          fg: AppColors.textInverse,
        );
      case AppButtonVariant.secondary:
        return (
          bg: _pressed || _hovered ? AppColors.bgMuted : AppColors.bgSurface,
          border: _pressed ? AppColors.borderStrong : AppColors.borderDefault,
          borderWidth: AppSizes.borderThin,
          fg: AppColors.textPrimary,
        );
      case AppButtonVariant.outline:
        return (
          bg: _pressed
              ? AppColors.bgMuted
              : _hovered
              ? AppColors.bgSubtle
              : AppColors.bgSurface,
          border: AppColors.borderStrong,
          borderWidth: AppSizes.borderThin,
          fg: AppColors.textPrimary,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = _colors();
    final labelStyle = _labelStyle.copyWith(color: c.fg);

    final content = Row(
      mainAxisSize: widget.expand ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.isLoading)
          SizedBox.square(
            dimension: _iconSize,
            child: CircularProgressIndicator(
              strokeWidth: AppSizes.borderMedium,
              color: c.fg,
            ),
          )
        else if (widget.icon != null)
          Icon(widget.icon, size: _iconSize, color: c.fg),
        if (widget.isLoading || widget.icon != null)
          const SizedBox(width: AppSizes.gapTight),
        Flexible(
          child: Text(
            widget.label,
            style: labelStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );

    return Semantics(
      button: true,
      enabled: _enabled,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: _height,
          maxHeight: _height,
          minWidth: widget.expand ? double.infinity : 0,
        ),
        child: Material(
          color: c.bg,
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.smAll,
            side: BorderSide(color: c.border, width: c.borderWidth),
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: _enabled ? widget.onPressed : null,
            onHover: (v) => setState(() => _hovered = v),
            onHighlightChanged: (v) => setState(() => _pressed = v),
            onFocusChange: (v) => setState(() => _focused = v),
            splashFactory: NoSplash.splashFactory,
            overlayColor: const WidgetStatePropertyAll(Colors.transparent),
            child: Padding(
              padding: EdgeInsetsDirectional.symmetric(horizontal: _paddingH),
              child: content,
            ),
          ),
        ),
      ),
    );
  }
}
