import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/di/injection.dart';
import '../../../core/localization/app_formats.dart';
import '../../../core/localization/app_labels.dart';
import '../../../core/localization/l10n/app_localizations.dart';
import '../../../core/mock/mock_backend.dart';
import '../../../core/models/field_notification.dart';
import '../../../core/models/field_task.dart';
import '../../../core/network/connection_cubit.dart';
import '../../../core/responsive/responsive.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/router/session_state.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/dev_scenario_menu.dart';
import '../../../core/widgets/widgets.dart';
import '../../sync/data/outbox_repository.dart';
import '../cubit/notifications_cubit.dart';
import '../data/notifications_repository.dart';
import '../widgets/notification_card.dart';

/// P-19 Notifications, tablet layout. Figma has only the web frames
/// (245:32986); this keeps their content in the field app shell.
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NotificationsCubit(
        getIt<NotificationsRepository>(),
        getIt<OutboxRepository>(),
        getIt<SessionState>(),
        getIt<ConnectionCubit>(),
      )..load(),
      child: const _NotificationsView(),
    );
  }
}

class _NotificationsView extends StatelessWidget {
  const _NotificationsView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final session = getIt<SessionState>();
    return AppScaffold(
      header: AppHeader(
        title: l10n.titleNotifications,
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
      body: BlocBuilder<NotificationsCubit, NotificationsState>(
        builder: (context, state) => DevScenarioMenu(
          scenarios: _devScenarios(context),
          child: RefreshIndicator(
            onRefresh: context.read<NotificationsCubit>().load,
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
      ),
    );
  }

  List<Widget> _content(BuildContext context, NotificationsState state) {
    final l10n = AppLocalizations.of(context);
    final cubit = context.read<NotificationsCubit>();
    final locale = Localizations.localeOf(context).languageCode;
    final visible = state.visible;
    final ready = state.status == AppViewStatus.ready;

    final stripTitle = switch (state.status) {
      AppViewStatus.loading => l10n.notifStripLoading,
      AppViewStatus.error => l10n.notifStripError,
      _ when !state.online => l10n.notifStripOffline,
      _ => l10n.notifStripReceived,
    };
    final stripCaption = switch (state.status) {
      AppViewStatus.loading => l10n.notifStripLoadingCaption,
      _ when state.lastSync != null => l10n.notifLastSync(
        AppFormats.dateTime(state.lastSync!, locale),
      ),
      _ => l10n.notifCachedCaption,
    };

    final (String, String, AppStatusTone)? notice = switch (state) {
      NotificationsState(status: AppViewStatus.error) => (
        l10n.notifErrorTitle,
        l10n.notifErrorMessage,
        AppStatusTone.danger,
      ),
      NotificationsState(online: false) => (
        l10n.notifOfflineTitle,
        l10n.notifOfflineMessage,
        AppStatusTone.warning,
      ),
      _ when state.items.any((n) => n.status == NotificationStatus.failed) => (
        l10n.notifFailedTitle,
        l10n.notifFailedMessage,
        AppStatusTone.danger,
      ),
      _ => null,
    };

    final filterLabels = [
      l10n.notifFilterAll,
      l10n.notificationStatusSent,
      l10n.notificationStatusFailed,
      l10n.notificationStatusAcknowledged,
    ];

    return [
      AppSyncStrip(
        title: stripTitle,
        caption: stripCaption,
        action: AppButton.outline(
          label: l10n.tasksRefreshAction,
          icon: Icons.refresh,
          onPressed: state.online && state.status != AppViewStatus.loading
              ? cubit.load
              : null,
        ),
      ),
      if (notice != null)
        AppNotice(title: notice.$1, message: notice.$2, tone: notice.$3),
      AppTabs(
        labels: filterLabels,
        selectedIndex: state.filter.index,
        onChanged: (i) => cubit.setFilter(NotificationFilter.values[i]),
      ),
      Text(
        ready ? l10n.notifListTitleCount(visible.length) : l10n.notifListTitle,
        style: AppTextStyles.h3Size20,
      ),
      if (ready && visible.isNotEmpty)
        for (final n in visible)
          NotificationCard(
            notification: n,
            ackPending: state.pendingAckTaskIds.contains(n.taskId),
            online: state.online,
            onAcknowledge: () => cubit.acknowledge(n),
            onOpenTask: () =>
                context.push('${AppRoutes.tasksPath}/${n.taskId}'),
          )
      else
        AppCard(
          child: SizedBox(
            height: _stateHeight,
            child: ready
                ? AppStateView.empty(
                    compact: true,
                    icon: Icons.filter_alt_off_outlined,
                    title: l10n.notifFilteredEmptyTitle,
                    message: l10n.notifFilteredEmptyMessage(
                      filterLabels[state.filter.index],
                    ),
                    actionLabel: l10n.notifClearFilter,
                    onAction: () => cubit.setFilter(NotificationFilter.all),
                  )
                : AppStateBody(
                    status: state.status,
                    compact: true,
                    loadingMessage: l10n.notifLoadingMessage,
                    emptyTitle: l10n.notifEmptyTitle,
                    emptyMessage: l10n.notifEmptyMessage,
                    emptyIcon: Icons.notifications_none,
                    errorMessage: l10n.notifErrorListMessage,
                    onRetry: cubit.load,
                    builder: (_) => const SizedBox.shrink(),
                  ),
          ),
        ),
      AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppSpacing.s3,
          children: [
            Text(l10n.notifExplainTitle, style: AppTextStyles.h3),
            Text(
              l10n.notifExplainStatus,
              style: AppTextStyles.bodyL.copyWith(color: AppColors.textPrimary),
            ),
            Text(
              l10n.notifExplainOffline,
              style: AppTextStyles.bodyM.copyWith(color: AppColors.textMuted),
            ),
          ],
        ),
      ),
    ];
  }

  /// Same height as the P-54 list state card.
  static const double _stateHeight = 288;

  // DEV-ONLY (Flutter Screens)
  List<DevScenario> _devScenarios(BuildContext context) {
    final cubit = context.read<NotificationsCubit>();
    final backend = getIt<MockBackend>();
    final session = getIt<SessionState>();
    void reset() {
      backend
        ..notificationsFail = false
        ..tasksScenario = MockTasksScenario.normal
        ..syncScenario = MockSyncScenario.accept
        ..clearOutbox()
        ..setOnline(true);
      final user = session.user;
      if (user != null) backend.prepareUser(user);
    }

    return [
      DevScenario('Populated', () {
        reset();
        cubit.load();
      }),
      DevScenario('Loading', cubit.load),
      DevScenario('Empty', () {
        reset();
        backend.removeNotifications();
        cubit.load();
      }),
      DevScenario('Filtered no-results', () {
        reset();
        backend.removeNotifications(
          (n) => n.status == NotificationStatus.acknowledged,
        );
        cubit
          ..load()
          ..setFilter(NotificationFilter.acknowledged);
      }),
      DevScenario('Connection error', () {
        reset();
        backend.notificationsFail = true;
        cubit.load();
      }),
      DevScenario('Offline · cached list', () {
        reset();
        backend.setOnline(false);
        cubit.load();
      }),
      DevScenario('Plan cancelled notice arrives', () {
        final task = backend.tasks.firstOrNull;
        if (task != null) {
          backend.applyPlanChange(task.id, SystemLabel.cancelled);
        }
      }),
    ];
  }
}
