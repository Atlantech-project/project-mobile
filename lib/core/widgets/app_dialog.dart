import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_shadows.dart';
import '../theme/app_sizes.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import 'app_button.dart';

/// Shows an [AppDialog] over the design-system scrim. Resolves to `true` on
/// confirm and `false` (or null when dismissed) on cancel.
Future<bool?> showAppDialog({
  required BuildContext context,
  required String title,
  required String body,
  required String confirmLabel,
  String? cancelLabel,
  bool barrierDismissible = true,
}) {
  return showDialog<bool>(
    context: context,
    barrierColor: AppColors.overlayScrim,
    barrierDismissible: barrierDismissible,
    builder: (context) => AppDialog(
      title: title,
      body: body,
      confirmLabel: confirmLabel,
      cancelLabel: cancelLabel,
      onConfirm: () => Navigator.of(context).pop(true),
      onCancel: cancelLabel == null
          ? null
          : () => Navigator.of(context).pop(false),
    ),
  );
}

/// Figma: Dialog (331:24900). Title, body, then Cancel / Confirm at the end.
class AppDialog extends StatelessWidget {
  const AppDialog({
    super.key,
    required this.title,
    required this.body,
    required this.confirmLabel,
    required this.onConfirm,
    this.cancelLabel,
    this.onCancel,
  });

  /// Figma dialog width.
  static const double width = 480;

  final String title;
  final String body;
  final String confirmLabel;
  final VoidCallback onConfirm;
  final String? cancelLabel;
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.all(AppSpacing.s7),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: width),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.bgSurface,
            borderRadius: AppRadius.mdAll,
            border: Border.all(
              color: AppColors.borderDefault,
              width: AppSizes.borderThin,
            ),
            boxShadow: AppShadows.elevation3,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.all(AppSpacing.s7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: AppSpacing.s3,
                  children: [
                    Text(title, style: AppTextStyles.h3),
                    Text(body, style: AppTextStyles.bodyM),
                  ],
                ),
              ),
              const Divider(height: AppSizes.borderThin),
              Padding(
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: AppSpacing.s7,
                  vertical: AppSpacing.s5,
                ),
                child: Wrap(
                  alignment: WrapAlignment.end,
                  spacing: AppSpacing.s4,
                  runSpacing: AppSpacing.s3,
                  children: [
                    if (cancelLabel != null)
                      AppButton.outline(
                        label: cancelLabel!,
                        onPressed: onCancel,
                      ),
                    AppButton.primary(
                      label: confirmLabel,
                      onPressed: onConfirm,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
