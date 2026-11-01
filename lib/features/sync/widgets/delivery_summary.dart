import 'package:flutter/material.dart';

import '../../../core/localization/l10n/app_localizations.dart';
import '../../../core/models/outbox_event.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_sizes.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/widgets.dart';
import 'event_texts.dart';

/// Figma "Save dispatch and acceptance" (P-54): device record, dispatch and
/// server acceptance of the latest event, side by side.
class DeliverySummary extends StatelessWidget {
  const DeliverySummary({super.key, required this.event});

  final OutboxEvent? event;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsetsDirectional.all(AppSpacing.s5),
      decoration: BoxDecoration(
        color: AppColors.bgSurface,
        borderRadius: AppRadius.smAll,
        border: Border.all(
          color: AppColors.borderStrong,
          width: AppSizes.borderThin,
        ),
      ),
      child: AppFieldRow(
        children: [
          AppInfoField(
            label: l10n.eventDeviceLabel,
            value: l10n.eventDevice(event),
          ),
          AppInfoField(
            label: l10n.eventDispatchLabel,
            value: l10n.eventDispatch(event),
          ),
          AppInfoField(
            label: l10n.eventAcceptanceLabel,
            value: l10n.eventAcceptance(event),
          ),
        ],
      ),
    );
  }
}
