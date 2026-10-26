import 'package:flutter/material.dart';

import '../localization/l10n/app_localizations.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_sizes.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

/// [tablet] follows the tablet screens (56 tall input, 18 sp text).
/// [compact] follows the Form field component (331:24877, 40 tall).
enum AppTextFieldSize { tablet, compact }

/// Figma: Form field. States: default, focus, error ([errorText]) and
/// disabled ([enabled] false).
class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.label,
    this.controller,
    this.focusNode,
    this.hintText,
    this.helperText,
    this.errorText,
    this.isRequired = false,
    this.enabled = true,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
    this.trailing,
    this.size = AppTextFieldSize.tablet,
    this.textDirection,
  });

  final String label;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hintText;
  final String? helperText;

  /// When set, the field shows the error state and this text replaces the helper.
  final String? errorText;
  final bool isRequired;
  final bool enabled;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  /// Widget at the end of the input, e.g. the password Show/Hide control.
  final Widget? trailing;
  final AppTextFieldSize size;

  /// Force LTR for usernames, IDs or codes inside RTL screens.
  final TextDirection? textDirection;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  FocusNode? _ownFocusNode;
  FocusNode get _focusNode =>
      widget.focusNode ?? (_ownFocusNode ??= FocusNode());
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void didUpdateWidget(covariant AppTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.focusNode != widget.focusNode) {
      (oldWidget.focusNode ?? _ownFocusNode)?.removeListener(_onFocusChange);
      _focusNode.addListener(_onFocusChange);
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _ownFocusNode?.dispose();
    super.dispose();
  }

  void _onFocusChange() => setState(() => _focused = _focusNode.hasFocus);

  @override
  Widget build(BuildContext context) {
    final isTablet = widget.size == AppTextFieldSize.tablet;
    final hasError = widget.errorText != null;

    final labelStyle = isTablet
        ? AppTextStyles.h4
        : AppTextStyles.labelM.copyWith(color: AppColors.textPrimary);
    final inputStyle =
        (isTablet ? AppTextStyles.tabletBody : AppTextStyles.bodyM).copyWith(
          color: widget.enabled
              ? AppColors.textPrimary
              : AppColors.textDisabled,
        );
    final hintStyle = inputStyle.copyWith(
      color: widget.enabled ? AppColors.textMuted : AppColors.textDisabled,
    );
    final supportStyle = isTablet
        ? AppTextStyles.labelM
        : AppTextStyles.caption;

    final Color borderColor;
    final double borderWidth;
    if (!widget.enabled) {
      borderColor = AppColors.borderDefault;
      borderWidth = isTablet ? AppSizes.borderMedium : AppSizes.borderThin;
    } else if (_focused) {
      borderColor = AppColors.borderFocus;
      borderWidth = AppSizes.borderMedium;
    } else if (hasError) {
      borderColor = AppColors.statusDangerFg;
      borderWidth = isTablet ? AppSizes.borderMedium : AppSizes.borderThin;
    } else {
      borderColor = isTablet ? AppColors.borderStrong : AppColors.borderDefault;
      borderWidth = isTablet ? AppSizes.borderMedium : AppSizes.borderThin;
    }

    final support = widget.errorText ?? widget.helperText;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      spacing: AppSizes.gapTight,
      children: [
        Row(
          spacing: AppSpacing.s2,
          children: [
            Flexible(child: Text(widget.label, style: labelStyle)),
            if (widget.isRequired)
              Semantics(
                label: AppLocalizations.of(context).requiredMark,
                child: ExcludeSemantics(
                  child: Text(
                    '*',
                    style: labelStyle.copyWith(color: AppColors.statusDangerFg),
                  ),
                ),
              ),
          ],
        ),
        Container(
          height: isTablet ? AppSizes.touch : AppSizes.controlMd,
          decoration: BoxDecoration(
            color: widget.enabled ? AppColors.bgSurface : AppColors.bgSubtle,
            borderRadius: AppRadius.smAll,
            border: Border.all(color: borderColor, width: borderWidth),
          ),
          padding: EdgeInsetsDirectional.only(
            start: isTablet ? AppSpacing.s5 : AppSpacing.s4,
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  focusNode: _focusNode,
                  enabled: widget.enabled,
                  obscureText: widget.obscureText,
                  keyboardType: widget.keyboardType,
                  textInputAction: widget.textInputAction,
                  onChanged: widget.onChanged,
                  onSubmitted: widget.onSubmitted,
                  textDirection: widget.textDirection,
                  style: inputStyle,
                  cursorColor: AppColors.textPrimary,
                  decoration: InputDecoration.collapsed(
                    hintText: widget.hintText,
                    hintStyle: hintStyle,
                  ),
                ),
              ),
              if (widget.trailing != null)
                widget.trailing!
              else
                SizedBox(width: isTablet ? AppSpacing.s5 : AppSpacing.s4),
            ],
          ),
        ),
        if (support != null)
          Text(
            support,
            style: supportStyle.copyWith(
              color: hasError ? AppColors.statusDangerFg : AppColors.textMuted,
            ),
          ),
      ],
    );
  }
}
