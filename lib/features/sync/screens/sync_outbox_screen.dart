import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/di/injection.dart';
import '../../../core/localization/app_formats.dart';
import '../../../core/localization/app_labels.dart';
import '../../../core/localization/l10n/app_localizations.dart';
import '../../../core/mock/mock_backend.dart';
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
import '../cubit/sync_cubit.dart';
import '../data/outbox_repository.dart';
import '../widgets/event_texts.dart';

/// P-56 Sync Status and Outbox (Figma 245:5631).
class SyncOutboxScreen extends StatelessWidget {
  const SyncOutboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SyncCubit(
        getIt<OutboxRepository>(),
        getIt<SessionState>(),
        getIt<ConnectionCubit>(),
      ),
      child: const _SyncView(),
    );
  }
}

class _SyncView extends StatelessWidget {
  const _SyncView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final session = getIt<SessionState>();
    return AppScaffold(
      header: AppHeader(
        title: l10n.syncTitle,
        subtitle: l10n.userLine(session),
        actions: [
          AppHeaderAction(
            icon: Icons.arrow_back,
            label: l10n.titleMyTasks,
            onPressed: () => context.canPop()
                ? context.pop()
                : context.go(AppRoutes.tasksPath),
          ),
          const AppLanguageButton(),
        ],
      ),
      body: BlocBuilder<SyncCubit, SyncState>(
        builder: (context, state) => DevScenarioMenu(
          scenarios: _devScenarios(),
          child: ListView(
            padding: EdgeInsetsDirectional.all(context.layout.margin),
            children: [
              ..._content(
                context,
                state,
              ).expand((w) => [w, const SizedBox(height: AppSpacing.s5)]),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _content(BuildContext context, SyncState state) {
    final l10n = AppLocalizations.of(context);
    final cubit = context.read<SyncCubit>();
    final rejected = state.count(OutboxStatus.rejected);
    final user = getIt<SessionState>().user;

    final stripTitle = switch (state) {
      SyncState(sending: true) => l10n.syncStripSending,
      SyncState(failed: true) => l10n.syncStripFailed(state.pending),
      SyncState(online: false) when state.pending > 0 => l10n.syncStripOffline,
      _ when rejected > 0 && state.pending == 0 => l10n.syncStripRejected(
        rejected,
      ),
      _ when state.pending > 0 => l10n.tasksSyncPending(state.pending),
      _ when state.events.isNotEmpty => l10n.syncStripConfirmed,
      _ => l10n.syncStripNone,
    };

    final Widget action = switch (state) {
      SyncState(sending: true) => AppButton.outline(
        label: l10n.syncSendingAction,
        onPressed: null,
      ),
      SyncState(failed: true) => AppButton.primary(
        label: l10n.syncRetryAction,
        icon: Icons.sync,
        onPressed: state.online ? cubit.syncNow : null,
      ),
      _ => AppButton.outline(
        label: l10n.syncRefreshAction,
        icon: Icons.refresh,
        onPressed: state.online ? cubit.syncNow : null,
      ),
    };

    return [
      AppSyncStrip(title: stripTitle, caption: l10n.syncStripCaption),
      ?_notice(l10n, state),
      AppFieldRow(
        spacing: AppSpacing.s5,
        children: [
          _Counter(value: state.pending, label: l10n.syncCountPending),
          _Counter(
            value: state.count(OutboxStatus.done),
            label: l10n.syncCountDone,
          ),
          _Counter(
            value: rejected,
            label: l10n.syncCountRejected,
            highlight: rejected > 0,
          ),
        ],
      ),
      Row(
        children: [
          Expanded(
            child: Text(
              l10n.syncListTitle(state.events.length),
              style: AppTextStyles.h3Size20,
            ),
          ),
          action,
        ],
      ),
      if (state.events.isEmpty)
        AppCard(
          child: AppStateView.empty(
            compact: true,
            icon: Icons.outbox_outlined,
            title: l10n.syncEmptyTitle,
            message: l10n.syncEmptyMessage,
          ),
        )
      else
        for (final e in state.events)
          _EventCard(event: e, online: state.online),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpacing.s1,
        children: [
          Text(
            l10n.syncOwnership(ltrIsolate(user?.username ?? '')),
            style: AppTextStyles.strongM.copyWith(color: AppColors.textPrimary),
          ),
          Text(
            l10n.syncOwnershipNote,
            style: AppTextStyles.bodyM.copyWith(color: AppColors.textMuted),
          ),
        ],
      ),
    ];
  }

  Widget? _notice(AppLocalizations l10n, SyncState state) {
    final (String, String, AppStatusTone)? n = switch (state) {
      _ when getIt<MockBackend>().deviceWiped => (
        l10n.syncWipedTitle,
        l10n.syncWipedMessage,
        AppStatusTone.danger,
      ),
      SyncState(sending: true) => (
        l10n.syncSendingTitle,
        l10n.syncSendingMessage,
        AppStatusTone.info,
      ),
      SyncState(failed: true) => (
        l10n.syncFailedTitle,
        l10n.syncFailedMessage,
        AppStatusTone.danger,
      ),
      SyncState(online: false) when state.pending > 0 => (
        l10n.syncOfflineTitle,
        l10n.syncOfflineMessage(state.pending),
        AppStatusTone.warning,
      ),
      _ when state.count(OutboxStatus.rejected) > 0 => (
        l10n.syncRejectedTitle,
        l10n.syncRejectedMessage,
        AppStatusTone.danger,
      ),
      _ when state.pending > 0 => (
        l10n.syncWaitingTitle,
        l10n.syncWaitingMessage,
        AppStatusTone.info,
      ),
      _ when state.events.isNotEmpty => (
        l10n.syncConfirmedTitle,
        l10n.syncConfirmedMessage,
        AppStatusTone.success,
      ),
      _ => null,
    };
    if (n == null) return null;
    return AppNotice(title: n.$1, message: n.$2, tone: n.$3);
  }

  // DEV-ONLY (Flutter Screens)
  List<DevScenario> _devScenarios() {
    final backend = getIt<MockBackend>();
    void reset() {
      backend
        ..deviceWiped = false
        ..syncScenario = MockSyncScenario.accept
        ..clearOutbox()
        ..setOnline(true);
    }

    return [
      DevScenario('No pending events (empty)', reset),
      DevScenario('Pending offline', () {
        reset();
        backend
          ..setOnline(false)
          ..seedEvent(status: OutboxStatus.pending);
      }),
      DevScenario('Syncing in progress', () {
        reset();
        backend
          ..seedEvent(status: OutboxStatus.pending)
          ..syncNow();
      }),
      DevScenario('Server-confirmed Done events', () {
        reset();
        backend.seedEvent(status: OutboxStatus.done);
      }),
      DevScenario('Sync failure · pending kept', () {
        reset();
        backend.seedEvent(status: OutboxStatus.pending, failed: true);
      }),
      DevScenario('Retry in progress', () {
        reset();
        backend
          ..seedEvent(status: OutboxStatus.pending, failed: true)
          ..syncScenario = MockSyncScenario.transportFailure
          ..syncNow();
      }),
      DevScenario('Rejected cancelled-plan event', () {
        reset();
        backend.seedEvent(
          status: OutboxStatus.rejected,
          reason: RejectReason.planCancelled,
        );
      }),
      DevScenario('Device wiped warning', () {
        reset();
        backend
          ..deviceWiped = true
          ..seedEvent(status: OutboxStatus.done);
      }),
    ];
  }
}

/// Figma "Event count".
class _Counter extends StatelessWidget {
  const _Counter({
    required this.value,
    required this.label,
    this.highlight = false,
  });

  final int value;
  final String label;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.all(AppSpacing.s5),
      decoration: BoxDecoration(
        color: AppColors.bgSurface,
        borderRadius: AppRadius.smAll,
        border: Border.all(
          color: highlight ? AppColors.brandPrimary : AppColors.borderDefault,
          width: AppSizes.borderThin,
        ),
      ),
      child: Row(
        spacing: AppSpacing.s5,
        children: [
          Text(ltrIsolate('$value'), style: AppTextStyles.numberDisplay),
          Flexible(child: Text(label, style: AppTextStyles.bodyL)),
        ],
      ),
    );
  }
}

/// Figma "Outbox event".
class _EventCard extends StatelessWidget {
  const _EventCard({required this.event, required this.online});

  final OutboxEvent event;
  final bool online;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).languageCode;
    final e = event;
    final rejected = e.status == OutboxStatus.rejected;

    final footnote = switch (e) {
      OutboxEvent(status: OutboxStatus.rejected) => l10n.syncEventRejectedNote(
        l10n.rejectReasonText(e.reason ?? RejectReason.unknown),
      ),
      OutboxEvent(status: OutboxStatus.done) => l10n.syncEventDoneNote,
      OutboxEvent(lastAttemptFailed: true) => l10n.syncEventFailedNote,
      _ => l10n.syncEventPendingNote,
    };

    final dispatch =
        e.status == OutboxStatus.pending && !e.lastAttemptFailed && !online
        ? l10n.syncDispatchOffline
        : l10n.eventDispatch(e);

    return Container(
      padding: const EdgeInsetsDirectional.all(AppSpacing.s5),
      decoration: BoxDecoration(
        color: AppColors.bgSurface,
        borderRadius: AppRadius.smAll,
        border: Border.all(
          color: rejected ? AppColors.brandPrimary : AppColors.borderStrong,
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
                child: Text(
                  '${e.vesselName} · '
                  '${ltrIsolate('${e.taskReference} · ${e.planReference}')}',
                  style: AppTextStyles.h3Size20,
                ),
              ),
              AppStatusBadge(
                label: l10n.outboxStatusLabel(e.status),
                tone: AppTones.outbox(e.status),
              ),
            ],
          ),
          AppFieldRow(
            children: [
              AppInfoField(
                label: l10n.syncEventLabel,
                value: e.type == OutboxEventType.acknowledge
                    ? l10n.eventAcknowledgement
                    : l10n.syncEventStatus(l10n.eventAction(e)),
              ),
              AppInfoField(
                label: l10n.syncRecordedLabel,
                value: AppFormats.dateTime(e.reportedAt, locale),
              ),
              AppInfoField(
                label: l10n.syncRelatedLabel,
                value: l10n.syncRelatedValue(e.terminal, ltrIsolate(e.berth)),
              ),
            ],
          ),
          AppFieldRow(
            children: [
              AppInfoField(
                label: l10n.syncDeviceSaveLabel,
                value: l10n.syncDeviceSaved,
              ),
              AppInfoField(label: l10n.eventDispatchLabel, value: dispatch),
              AppInfoField(
                label: l10n.eventAcceptanceLabel,
                value: l10n.eventAcceptance(e),
              ),
            ],
          ),
          Text(
            footnote,
            style: AppTextStyles.bodyM.copyWith(color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}
