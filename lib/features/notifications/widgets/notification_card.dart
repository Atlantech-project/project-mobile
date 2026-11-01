import 'package:flutter/material.dart';

import '../../../core/localization/app_formats.dart';
import '../../../core/localization/app_labels.dart';
import '../../../core/localization/l10n/app_localizations.dart';
import '../../../core/models/field_notification.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_sizes.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/widgets.dart';

/// One P-19 row: type, related task, time, status with its meaning, and the
/// actions the status allows.
class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    required this.notification,
    required this.ackPending,
    required this.online,
    required this.onAcknowledge,
    required this.onOpenTask,
  });

  final FieldNotification notification;

  /// An `ACKNOWLEDGE` for this task is saved and not yet accepted.
  final bool ackPending;
  final bool online;
  final VoidCallback onAcknowledge;
  final VoidCallback onOpenTask;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).languageCode;
    final n = notification;
    final failed = n.status == NotificationStatus.failed;

    final note = switch (n.status) {
      NotificationStatus.sent when ackPending => l10n.notifNoteAckPending,
      NotificationStatus.sent => l10n.notifNoteSent,
      NotificationStatus.failed => l10n.notifNoteFailed,
      NotificationStatus.acknowledged => l10n.notifNoteAcknowledged(
        AppFormats.time(n.acknowledgedAt ?? n.createdAt),
      ),
    };

    final message = switch (n.type) {
      NotificationType.planAssignment => l10n.notifMessageAssignment,
      NotificationType.preExecutionReminder => l10n.notifMessageReminder,
      NotificationType.planCancelled => l10n.notifMessageCancelled,
    };

    return Container(
      padding: const EdgeInsetsDirectional.all(AppSpacing.s5),
      decoration: BoxDecoration(
        color: AppColors.bgSurface,
        borderRadius: AppRadius.smAll,
        border: Border.all(
          color: failed ? AppColors.statusDangerBorder : AppColors.borderStrong,
          width: AppSizes.borderThin,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: AppSpacing.s4,
        children: [
          Row(
            spacing: AppSpacing.s4,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: AppSpacing.s1,
                  children: [
                    Text(
                      l10n.notificationTypeLabel(n.type),
                      style: AppTextStyles.h3Size20,
                    ),
                    Text(
                      message,
                      style: AppTextStyles.bodyL.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              AppStatusBadge(
                label: ackPending && n.status == NotificationStatus.sent
                    ? l10n.notifAckSavedBadge
                    : l10n.notificationStatusLabel(n.status),
                tone: ackPending && n.status == NotificationStatus.sent
                    ? AppStatusTone.warning
                    : AppTones.notification(n.status),
              ),
            ],
          ),
          AppFieldRow(
            children: [
              AppInfoField(
                label: l10n.notifRelatedTask,
                value:
                    '${ltrIsolate(n.taskReference)} · ${n.vesselName}\n'
                    '${l10n.syncRelatedValue(n.terminal, ltrIsolate(n.berth))}',
              ),
              AppInfoField(
                label: l10n.notifTimestamp,
                value: AppFormats.dateTime(n.createdAt, locale),
              ),
            ],
          ),
          Text(
            note,
            style: AppTextStyles.bodyM.copyWith(
              color: failed ? AppColors.statusDangerFg : AppColors.textMuted,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            spacing: AppSpacing.s4,
            children: [
              AppButton.outline(
                label: l10n.notifOpenTask,
                icon: Icons.open_in_new,
                onPressed: onOpenTask,
              ),
              if (n.status == NotificationStatus.sent &&
                  n.type != NotificationType.planCancelled)
                AppButton.primary(
                  label: ackPending
                      ? l10n.notifAckSavedAction
                      : l10n.notifAcknowledge,
                  icon: Icons.check,
                  onPressed: ackPending ? null : onAcknowledge,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
