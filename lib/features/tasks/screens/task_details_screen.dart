import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/di/injection.dart';
import '../../../core/localization/app_formats.dart';
import '../../../core/localization/app_labels.dart';
import '../../../core/localization/l10n/app_localizations.dart';
import '../../../core/mock/mock_backend.dart';
import '../../../core/models/field_task.dart';
import '../../../core/models/outbox_event.dart';
import '../../../core/network/connection_cubit.dart';
import '../../../core/responsive/responsive.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/router/session_state.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_sizes.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/dev_scenario_menu.dart';
import '../../../core/widgets/widgets.dart';
import '../../sync/data/outbox_repository.dart';
import '../../sync/widgets/event_texts.dart';
import '../cubit/task_details_cubit.dart';
import '../data/tasks_repository.dart';

/// P-55 Task Details and Status Update (Figma 245:6226).
class TaskDetailsScreen extends StatelessWidget {
  const TaskDetailsScreen({super.key, required this.taskId});

  final String taskId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TaskDetailsCubit(
        taskId,
        getIt<TasksRepository>(),
        getIt<OutboxRepository>(),
        getIt<SessionState>(),
        getIt<ConnectionCubit>(),
      )..load(),
      child: const _TaskDetailsView(),
    );
  }
}

class _TaskDetailsView extends StatelessWidget {
  const _TaskDetailsView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<TaskDetailsCubit, TaskDetailsState>(
      builder: (context, state) {
        final task = state.task;
        return AppScaffold(
          header: AppHeader(
            title: l10n.taskDetailsTitle,
            subtitle: task == null
                ? l10n.taskDetailsSubtitleEmpty
                : l10n.taskDetailsSubtitle(
                    ltrIsolate(task.reference),
                    l10n.taskTypeLabel(task.componentType),
                  ),
            leading: context.isTablet
                ? AppButton.outline(
                    label: l10n.titleMyTasks,
                    icon: Icons.arrow_back,
                    onPressed: () => _back(context),
                  )
                : null,
            onBack: context.isTablet ? null : () => _back(context),
            actions: const [AppConnectionStatus(), AppLanguageButton()],
          ),
          body: DevScenarioMenu(
            scenarios: _devScenarios(context, state),
            child: ListView(
              padding: EdgeInsetsDirectional.all(context.layout.margin),
              children: [
                _notice(context, state),
                const SizedBox(height: AppSpacing.s5),
                if (task == null)
                  _Unavailable(loading: state.status == AppViewStatus.loading)
                else if (context.isTablet)
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      spacing: AppSpacing.s7,
                      children: [
                        Expanded(
                          flex: 560,
                          child: _TaskInformation(task: task, state: state),
                        ),
                        Expanded(flex: 648, child: _Decisions(state: state)),
                      ],
                    ),
                  )
                else ...[
                  _TaskInformation(task: task, state: state),
                  const SizedBox(height: AppSpacing.s5),
                  _Decisions(state: state),
                ],
                const SizedBox(height: AppSpacing.s5),
                _SaveAndSync(state: state),
              ],
            ),
          ),
        );
      },
    );
  }

  void _back(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.tasksPath);
    }
  }

  Widget _notice(BuildContext context, TaskDetailsState state) {
    final l10n = AppLocalizations.of(context);
    final task = state.task;
    final event = state.latestStatusEvent;
    final action = event == null ? '' : l10n.eventAction(event);

    final (String title, String message, AppStatusTone tone) = switch (state) {
      TaskDetailsState(status: AppViewStatus.loading) => (
        l10n.taskLoadingTitle,
        l10n.taskLoadingMessage,
        AppStatusTone.info,
      ),
      _ when task == null => (
        l10n.taskNoDataNoticeTitle,
        l10n.taskNoDataNoticeMessage,
        AppStatusTone.danger,
      ),
      _ when task.systemLabel == SystemLabel.cancelled => (
        l10n.taskCancelledTitle,
        l10n.taskCancelledMessage,
        AppStatusTone.danger,
      ),
      _ when task.systemLabel == SystemLabel.overridden => (
        l10n.taskOverriddenTitle,
        l10n.taskOverriddenMessage,
        AppStatusTone.danger,
      ),
      _ when event?.status == OutboxStatus.rejected => (
        l10n.taskRejectedTitle,
        l10n.rejectReasonText(event!.reason ?? RejectReason.unknown),
        AppStatusTone.danger,
      ),
      _ when event != null && event.lastAttemptFailed => (
        l10n.taskSyncFailedTitle,
        l10n.taskSyncFailedMessage(action),
        AppStatusTone.danger,
      ),
      TaskDetailsState(online: false) => (
        l10n.taskOfflineTitle,
        l10n.taskOfflineMessage,
        AppStatusTone.warning,
      ),
      _ when task.systemLabel == SystemLabel.updated => (
        l10n.taskUpdatedTitle,
        l10n.taskUpdatedMessage,
        AppStatusTone.info,
      ),
      _
          when event != null &&
              (event.status == OutboxStatus.pending ||
                  event.status == OutboxStatus.sending) =>
        (
          l10n.taskPendingTitle,
          l10n.taskPendingMessage(action),
          AppStatusTone.success,
        ),
      _ when event?.status == OutboxStatus.done => (
        l10n.taskConfirmedTitle,
        l10n.taskConfirmedMessage(
          action,
          AppFormats.time(event!.acceptedAt ?? event.reportedAt),
        ),
        AppStatusTone.success,
      ),
      _ when state.isAcknowledged => (
        l10n.taskAcknowledgedTitle,
        l10n.taskAcknowledgedMessage,
        AppStatusTone.info,
      ),
      _ => (
        l10n.taskNotAcknowledgedTitle,
        l10n.taskNotAcknowledgedMessage,
        AppStatusTone.info,
      ),
    };
    return AppNotice(title: title, message: message, tone: tone);
  }

  // DEV-ONLY (Flutter Screens)
  List<DevScenario> _devScenarios(
    BuildContext context,
    TaskDetailsState state,
  ) {
    final cubit = context.read<TaskDetailsCubit>();
    final backend = getIt<MockBackend>();
    final taskId = state.task?.id;
    return [
      DevScenario('Loading task details', () {
        cubit.showLoading();
        Future<void>.delayed(const Duration(seconds: 2), cubit.load);
      }),
      DevScenario('No task data available', cubit.showNoData),
      DevScenario('Back to the task', cubit.load),
      DevScenario('Offline', () => backend.setOnline(false)),
      DevScenario('Online', () => backend.setOnline(true)),
      DevScenario('Next sync fails (transport)', () {
        backend.syncScenario = MockSyncScenario.transportFailure;
      }),
      DevScenario('Sync works again', () {
        backend.syncScenario = MockSyncScenario.accept;
        backend.syncNow();
      }),
      if (taskId != null) ...[
        DevScenario(
          'Updated plan notification',
          () => backend.applyPlanChange(taskId, SystemLabel.updated),
        ),
        DevScenario(
          'Overridden by newer plan',
          () => backend.applyPlanChange(taskId, SystemLabel.overridden),
        ),
        DevScenario(
          'Task cancelled',
          () => backend.applyPlanChange(taskId, SystemLabel.cancelled),
        ),
      ],
    ];
  }
}

/// A white card with the design's border, used by the P-55 sections.
class _Section extends StatelessWidget {
  const _Section({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.all(AppSpacing.s5),
      decoration: BoxDecoration(
        color: AppColors.bgSurface,
        borderRadius: AppRadius.smAll,
        border: Border.all(
          color: AppColors.borderDefault,
          width: AppSizes.borderThin,
        ),
      ),
      child: child,
    );
  }
}

/// Figma "Task information".
class _TaskInformation extends StatelessWidget {
  const _TaskInformation({required this.task, required this.state});

  final FieldTask task;
  final TaskDetailsState state;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).languageCode;
    final value = AppTextStyles.h3Size20;
    Widget row(Widget a, Widget b) =>
        AppFieldRow(spacing: AppSpacing.s7, children: [a, b]);

    return _Section(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: AppSpacing.s6,
        children: [
          Text(
            state.online ? l10n.taskInfoTitle : l10n.taskInfoTitleCached,
            style: AppTextStyles.h3Size20,
          ),
          row(
            AppInfoField(
              label: l10n.taskVesselName,
              value: task.vesselName,
              valueStyle: value,
            ),
            AppInfoField(
              label: l10n.taskPlannedTime,
              value:
                  '${AppFormats.date(task.plannedStart, locale)}\n'
                  '${AppFormats.timeRange(task.plannedStart, task.plannedEnd)}',
              valueStyle: value,
            ),
          ),
          row(
            AppInfoField(
              label: l10n.taskAssignedBerth,
              value: task.berth,
              valueStyle: value,
              ltrValue: true,
            ),
            AppInfoField(
              label: l10n.taskAssignedTugs,
              value: task.tugs.isEmpty ? '—' : task.tugs.join(' + '),
              valueStyle: value,
              ltrValue: true,
            ),
          ),
          row(
            AppInfoField(
              label: l10n.taskAssignedPilot,
              value: task.pilotName ?? '—',
              valueStyle: value,
            ),
            AppInfoField(
              label: l10n.taskPlanReference,
              value: '${ltrIsolate(task.planReference)} · ${task.terminal}',
              valueStyle: value,
            ),
          ),
        ],
      ),
    );
  }
}

/// Figma "Executor decisions": Acknowledge, then the status update.
class _Decisions extends StatelessWidget {
  const _Decisions({required this.state});

  final TaskDetailsState state;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final cubit = context.read<TaskDetailsCubit>();
    final task = state.task!;
    final ack = state.pendingAcknowledge;
    final latest = state.latestStatusEvent;
    final muted = AppTextStyles.bodyM.copyWith(color: AppColors.textMuted);

    final ackText = task.acknowledgedAt != null
        ? l10n.taskAckDone(AppFormats.time(task.acknowledgedAt!))
        : ack != null
        ? l10n.taskAckSaved(AppFormats.time(ack.reportedAt))
        : l10n.taskAckNotYet;

    final serverStatus = task.status == TaskStatus.assigned
        ? l10n.taskServerNoUpdate
        : '${l10n.taskStatusLabel(task.status)}'
              '${task.statusAt == null ? '' : ' · ${AppFormats.time(task.statusAt!)}'}';
    final localStatus = latest == null
        ? l10n.taskLocalNone
        : '${l10n.eventAction(latest)} · ${AppFormats.time(latest.reportedAt)}';

    final ackControl = state.isAcknowledged
        ? Container(
            height: AppSizes.touch,
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: AppSpacing.s5,
            ),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: AppColors.bgMuted,
              borderRadius: AppRadius.smAll,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: AppSizes.gapTight,
              children: [
                const Icon(
                  Icons.check,
                  size: AppSizes.iconMd,
                  color: AppColors.textPrimary,
                ),
                Text(l10n.taskAcknowledgedBadge, style: AppTextStyles.h3),
              ],
            ),
          )
        : AppButton.primary(
            label: l10n.taskAcknowledgeAction,
            icon: Icons.task_alt,
            onPressed: state.locked ? null : cubit.acknowledge,
          );

    final optionsEnabled = !state.locked && task.status != TaskStatus.done;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: AppSpacing.s5,
      children: [
        _Section(
          child: Flex(
            direction: context.isTablet ? Axis.horizontal : Axis.vertical,
            crossAxisAlignment: context.isTablet
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            spacing: AppSpacing.s6,
            children: [
              Flexible(
                fit: context.isTablet ? FlexFit.tight : FlexFit.loose,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: AppSizes.gapTight,
                  children: [
                    Text(l10n.taskAckTitle, style: AppTextStyles.h3Size20),
                    Text(ackText, style: AppTextStyles.bodyL),
                  ],
                ),
              ),
              ackControl,
            ],
          ),
        ),
        _Section(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: AppSpacing.s3,
            children: [
              Text(l10n.taskUpdateTitle, style: AppTextStyles.h3Size20),
              Text(
                l10n.taskServerConfirmed(serverStatus),
                style: AppTextStyles.bodyM.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                l10n.taskLatestLocal(localStatus),
                style: AppTextStyles.bodyM.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppSpacing.s2),
              Text(l10n.taskSelectionNote, style: muted),
              Row(
                spacing: AppSpacing.s4,
                children: [
                  for (final option in const [
                    TaskStatus.started,
                    TaskStatus.done,
                  ])
                    Expanded(
                      child: _StatusOption(
                        label: l10n.taskStatusLabel(option),
                        selected: state.selected == option,
                        onTap: optionsEnabled
                            ? () => cubit.select(option)
                            : null,
                      ),
                    ),
                ],
              ),
              AppButton.primary(
                label: l10n.taskSaveAction,
                icon: Icons.save_outlined,
                expand: true,
                onPressed: state.canSave ? cubit.save : null,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Figma "Status option": a 56 tall radio tile. Selected: muted fill with a
/// brand border.
class _StatusOption extends StatelessWidget {
  const _StatusOption({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;
    final fg = enabled ? AppColors.textPrimary : AppColors.textDisabled;
    return Semantics(
      inMutuallyExclusiveGroup: true,
      checked: selected,
      button: true,
      enabled: enabled,
      child: Material(
        color: selected ? AppColors.bgMuted : AppColors.bgSurface,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.smAll,
          side: BorderSide(
            color: selected ? AppColors.brandPrimary : AppColors.borderStrong,
            width: selected ? AppSizes.borderMedium : AppSizes.borderThin,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: SizedBox(
            height: AppSizes.touch,
            child: Padding(
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: AppSpacing.s4,
              ),
              child: Row(
                spacing: AppSpacing.s4,
                children: [
                  Icon(
                    selected
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked,
                    size: AppSizes.iconMd,
                    color: fg,
                  ),
                  Flexible(
                    child: Text(
                      label,
                      style: AppTextStyles.h3.copyWith(color: fg),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Figma "Unavailable task": loading or no task data.
class _Unavailable extends StatelessWidget {
  const _Unavailable({required this.loading});

  final bool loading;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AppCard(
      child: SizedBox(
        height: _height,
        child: loading
            ? AppLoadingView(message: l10n.taskLoadingData, compact: true)
            : AppStateView.empty(
                compact: true,
                icon: Icons.assignment_late_outlined,
                title: l10n.taskNoDataTitle,
                message: l10n.taskNoDataMessage,
                actionLabel: l10n.backToMyTasksAction,
                onAction: () => context.go(AppRoutes.tasksPath),
              ),
      ),
    );
  }

  /// Figma "Unavailable task" height.
  static const double _height = 400;
}

/// Figma "Save and synchronization": what was saved, sent and accepted.
class _SaveAndSync extends StatelessWidget {
  const _SaveAndSync({required this.state});

  final TaskDetailsState state;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final cubit = context.read<TaskDetailsCubit>();
    final e = state.latestStatusEvent;
    final task = state.task;
    final locale = Localizations.localeOf(context).languageCode;
    final muted = AppTextStyles.bodyS.copyWith(color: AppColors.textMuted);

    final (String title, String caption) = switch (e) {
      _ when task == null => (l10n.taskSyncNoTask, l10n.taskSyncNoTaskNote),
      null => (l10n.eventDeviceNone, l10n.taskSyncAckSeparate),
      OutboxEvent(status: OutboxStatus.rejected) => (
        l10n.taskSyncRejectedTitle,
        l10n.taskSyncRejectedNote,
      ),
      OutboxEvent(lastAttemptFailed: true) => (
        l10n.taskSyncFailedShort,
        l10n.taskSyncFailedNote,
      ),
      OutboxEvent(status: OutboxStatus.pending) when !state.online => (
        l10n.taskSyncPendingOffline,
        state.lastSync == null
            ? l10n.taskSyncWaitingNote
            : l10n.taskSyncCachedAt(
                AppFormats.dateTime(state.lastSync!, locale),
              ),
      ),
      OutboxEvent(status: OutboxStatus.pending) => (
        l10n.taskSyncPendingTitle,
        l10n.taskSyncWaitingNote,
      ),
      OutboxEvent(status: OutboxStatus.sending) => (
        l10n.taskSyncSendingTitle,
        l10n.taskSyncWaitingNote,
      ),
      OutboxEvent(status: OutboxStatus.done) => (
        l10n.taskSyncDoneTitle,
        l10n.taskSyncDoneNote(
          AppFormats.time(e.reportedAt),
          AppFormats.time(e.acceptedAt ?? e.reportedAt),
        ),
      ),
    };

    final needsRetry =
        e != null && e.lastAttemptFailed && e.status == OutboxStatus.pending;
    final outbox = needsRetry
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: AppSpacing.s3,
            children: [
              Text(
                l10n.taskOutboxRetained(state.unsentCount),
                style: AppTextStyles.bodyM.copyWith(color: AppColors.textMuted),
              ),
              AppButton.outline(
                label: l10n.taskRetrySyncAction,
                icon: Icons.sync,
                onPressed: state.online ? cubit.retrySync : null,
              ),
            ],
          )
        : e?.status == OutboxStatus.rejected
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: AppSpacing.s3,
            children: [
              Text(
                l10n.taskOutboxLabel,
                style: AppTextStyles.bodyM.copyWith(color: AppColors.textMuted),
              ),
              AppButton.outline(
                label: l10n.outboxAction,
                icon: Icons.outbox_outlined,
                onPressed: () => context.push(AppRoutes.syncPath),
              ),
            ],
          )
        : AppInfoField(
            label: l10n.taskOutboxLabel,
            value: state.unsentCount > 0
                ? l10n.taskOutboxWaiting(state.unsentCount)
                : l10n.taskOutboxEmpty,
          );

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
        flex: const [340, 238, 258, 284],
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppSizes.gapTight,
            children: [
              Text(
                l10n.taskSaveSyncLabel,
                style: AppTextStyles.bodyM.copyWith(color: AppColors.textMuted),
              ),
              Text(title, style: AppTextStyles.h3Size20),
              Text(caption, style: muted),
            ],
          ),
          AppInfoField(
            label: l10n.eventDeviceLabel,
            value: l10n.eventDevice(e),
          ),
          AppInfoField(
            label: l10n.eventAcceptanceLabel,
            value: l10n.eventAcceptance(e),
          ),
          outbox,
        ],
      ),
    );
  }
}
