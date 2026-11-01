import 'package:flutter/material.dart';

import '../../../core/localization/app_formats.dart';
import '../../../core/localization/app_labels.dart';
import '../../../core/localization/l10n/app_localizations.dart';
import '../../../core/models/field_task.dart';
import '../../../core/models/outbox_event.dart';
import '../../../core/responsive/responsive.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_sizes.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/widgets.dart';

/// Figma "Assigned task card" (P-54).
class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.task,
    required this.latestEvent,
    required this.cached,
    required this.onOpen,
  });

  final FieldTask task;

  /// The user's newest Outbox event for this task.
  final OutboxEvent? latestEvent;

  /// Shown from the device cache while offline.
  final bool cached;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).languageCode;
    final isTablet = context.isTablet;
    final label = task.systemLabel;

    final reference = [
      task.reference,
      task.planReference,
      task.terminal,
      if (task.componentType == TaskComponentType.tug && task.tugs.isNotEmpty)
        l10n.taskTugRef(task.tugs.first),
      if (cached) l10n.taskCached,
    ].join(' · ');

    final event = latestEvent;
    final unsent =
        event != null &&
        (event.status == OutboxStatus.pending ||
            event.status == OutboxStatus.sending);

    final title = Row(
      spacing: AppSpacing.s4,
      children: [
        Flexible(
          child: Text(
            task.vesselName,
            style: isTablet ? AppTextStyles.h2Size24 : AppTextStyles.h3,
          ),
        ),
        if (label != null)
          AppStatusBadge(
            label: l10n.systemLabelText(label),
            tone: AppTones.systemLabel(label),
          ),
      ],
    );

    return Container(
      padding: const EdgeInsetsDirectional.all(AppSpacing.s6),
      decoration: BoxDecoration(
        color: AppColors.bgSurface,
        borderRadius: AppRadius.smAll,
        border: Border.all(
          color: AppColors.borderDefault,
          width: AppSizes.borderThin,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: AppSpacing.s4,
        children: [
          if (isTablet)
            Row(
              children: [
                Expanded(child: title),
                ServerStatusPill(task: task, cached: cached),
              ],
            )
          else ...[
            title,
            ServerStatusPill(task: task, cached: cached),
          ],
          AppFieldRow(
            flex: const [1, 2, 3],
            children: [
              AppInfoField(
                label: l10n.taskBerth,
                value: task.berth,
                valueStyle: AppTextStyles.h2,
                ltrValue: true,
              ),
              AppInfoField(
                label: l10n.taskScheduledTime,
                value:
                    '${AppFormats.date(task.plannedStart, locale)} · '
                    '${AppFormats.timeRange(task.plannedStart, task.plannedEnd)}',
              ),
              AppInfoField(
                label: l10n.taskType,
                value: l10n.taskTypeLabel(task.componentType),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsetsDirectional.all(AppSpacing.s4),
            decoration: const BoxDecoration(
              color: AppColors.bgMuted,
              borderRadius: AppRadius.smAll,
            ),
            child: AppFieldRow(
              children: [
                AppInfoField(
                  label: l10n.taskLocalUpdate,
                  value: unsent
                      ? l10n.taskLocalSaved(
                          event.type == OutboxEventType.acknowledge
                              ? l10n.eventAcknowledgement
                              : l10n.taskStatusLabel(event.newStatus!),
                        )
                      : l10n.taskLocalNone,
                ),
                AppInfoField(
                  label: l10n.taskSynchronization,
                  value: switch (event?.status) {
                    OutboxStatus.pending => l10n.taskSyncPending,
                    OutboxStatus.sending => l10n.taskSyncSending,
                    OutboxStatus.rejected => l10n.taskSyncRejected,
                    _ => l10n.taskSyncNone,
                  },
                ),
              ],
            ),
          ),
          Flex(
            direction: isTablet ? Axis.horizontal : Axis.vertical,
            crossAxisAlignment: isTablet
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.stretch,
            spacing: AppSpacing.s4,
            children: [
              if (isTablet)
                Expanded(child: _Reference(text: reference))
              else
                _Reference(text: reference),
              AppButton.primary(
                label: l10n.taskOpenAction,
                icon: Icons.arrow_forward,
                onPressed: onOpen,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Reference extends StatelessWidget {
  const _Reference({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) => Text(
    ltrIsolate(text),
    style: AppTextStyles.bodyM.copyWith(color: AppColors.textMuted),
  );
}

/// Figma "Current task status": the server-confirmed status, apart from any
/// local update.
class ServerStatusPill extends StatelessWidget {
  const ServerStatusPill({super.key, required this.task, this.cached = false});

  final FieldTask task;
  final bool cached;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final at = task.statusAt;
    final value = task.status == TaskStatus.assigned || at == null
        ? l10n.taskServerNoUpdate
        : '${l10n.taskStatusLabel(task.status)} · ${AppFormats.time(at)}';
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.s4,
        vertical: AppSpacing.s3,
      ),
      decoration: BoxDecoration(
        color: AppColors.bgMuted,
        borderRadius: AppRadius.smAll,
        border: Border.all(
          color: AppColors.borderStrong,
          width: AppSizes.borderThin,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: AppSpacing.s3,
        children: [
          Text(
            cached ? l10n.taskServerCached : l10n.taskServer,
            style: AppTextStyles.bodyM.copyWith(color: AppColors.textMuted),
          ),
          Text(
            value,
            style: AppTextStyles.strongM.copyWith(color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }
}
