import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/di/injection.dart';
import '../../../core/localization/app_formats.dart';
import '../../../core/localization/app_labels.dart';
import '../../../core/localization/l10n/app_localizations.dart';
import '../../../core/mock/mock_backend.dart';
import '../../../core/mock/mock_data.dart';
import '../../../core/models/field_task.dart';
import '../../../core/models/field_user.dart';
import '../../../core/models/outbox_event.dart';
import '../../../core/network/connection_cubit.dart';
import '../../../core/responsive/responsive.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/router/session_state.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/dev_scenario_menu.dart';
import '../../../core/widgets/widgets.dart';
import '../../sync/data/outbox_repository.dart';
import '../../sync/widgets/delivery_summary.dart';
import '../cubit/tasks_cubit.dart';
import '../data/tasks_repository.dart';
import '../widgets/task_card.dart';

/// P-54 My Tasks (Figma 245:7006). The signed-in user's tasks only.
class MyTasksScreen extends StatelessWidget {
  const MyTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TasksCubit(
        getIt<TasksRepository>(),
        getIt<OutboxRepository>(),
        getIt<SessionState>(),
        getIt<ConnectionCubit>(),
      )..load(),
      child: const _MyTasksView(),
    );
  }
}

class _MyTasksView extends StatelessWidget {
  const _MyTasksView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final session = getIt<SessionState>();
    return AppScaffold(
      header: AppHeader(
        title: l10n.titleMyTasks,
        subtitle: l10n.userLine(session),
        actions: [
          AppHeaderAction(
            icon: Icons.notifications_none,
            label: l10n.titleNotifications,
            onPressed: () => context.push(AppRoutes.notificationsPath),
          ),
          AppHeaderAction(
            icon: Icons.tune,
            label: l10n.titleSettings,
            onPressed: () => context.push(AppRoutes.settingsPath),
          ),
          const AppLanguageButton(),
        ],
      ),
      body: BlocBuilder<TasksCubit, TasksState>(
        builder: (context, state) => DevScenarioMenu(
          scenarios: _devScenarios(context),
          child: RefreshIndicator(
            onRefresh: context.read<TasksCubit>().refresh,
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

  List<Widget> _content(BuildContext context, TasksState state) {
    final l10n = AppLocalizations.of(context);
    final cubit = context.read<TasksCubit>();
    final user = getIt<SessionState>().user;
    final unsent = state.unsent.length;
    final loading = state.status == AppViewStatus.loading;
    final isCt = user?.role == FieldRole.ctSupervisor;

    final listTitle = state.tasks.isEmpty || state.status != AppViewStatus.ready
        ? (isCt ? l10n.tasksListTitleCt : l10n.tasksListTitle)
        : (isCt
              ? l10n.tasksListTitleCtCount(state.tasks.length)
              : l10n.tasksListTitleCount(state.tasks.length));

    final refreshButton = state.status == AppViewStatus.error
        ? AppButton.outline(
            label: l10n.retryAction,
            icon: Icons.refresh,
            onPressed: cubit.load,
          )
        : AppButton.outline(
            label: state.refreshing
                ? l10n.tasksRefreshing
                : l10n.tasksRefreshAction,
            icon: Icons.refresh,
            onPressed: state.online && !state.refreshing ? cubit.refresh : null,
          );

    return [
      AppSyncStrip(
        title: loading
            ? l10n.tasksSyncLoading
            : unsent > 0
            ? l10n.tasksSyncPending(unsent)
            : l10n.tasksSyncNone,
        caption: state.online ? l10n.tasksFeedOnline : l10n.tasksFeedOffline,
        action: AppButton.outline(
          label: l10n.outboxAction,
          icon: Icons.outbox_outlined,
          onPressed: () => context.push(AppRoutes.syncPath),
        ),
      ),
      Row(
        children: [
          Expanded(child: Text(listTitle, style: AppTextStyles.h3Size20)),
          refreshButton,
        ],
      ),
      _notice(context, state, user),
      if (state.status == AppViewStatus.ready && state.tasks.isNotEmpty)
        for (final task in state.tasks)
          TaskCard(
            task: task,
            latestEvent: state.latestEventFor(task.id),
            cached: !state.online,
            onOpen: () => context.push('${AppRoutes.tasksPath}/${task.id}'),
          )
      else
        AppCard(
          child: SizedBox(
            height: _stateHeight,
            child: AppStateBody(
              status: state.status == AppViewStatus.ready
                  ? AppViewStatus.empty
                  : state.status,
              compact: true,
              loadingMessage: l10n.tasksLoadingMessage,
              emptyTitle: l10n.tasksEmptyTitle,
              emptyMessage: l10n.tasksEmptyMessage,
              emptyIcon: Icons.assignment_outlined,
              errorMessage: l10n.tasksErrorMessage,
              onRetry: cubit.load,
              builder: (_) => const SizedBox.shrink(),
            ),
          ),
        ),
      DeliverySummary(event: state.latestEvent),
    ];
  }

  /// Figma "Task list state" card height.
  static const double _stateHeight = 288;

  Widget _notice(BuildContext context, TasksState state, FieldUser? user) {
    final l10n = AppLocalizations.of(context);
    final name = user?.displayName ?? '';
    final unsent = state.unsent;
    final updated = state.updatedTask;
    final locale = Localizations.localeOf(context).languageCode;

    final (String title, String message, AppStatusTone tone) = switch (state) {
      TasksState(status: AppViewStatus.error) => (
        l10n.tasksErrorNoticeTitle,
        l10n.tasksErrorNoticeMessage,
        AppStatusTone.danger,
      ),
      TasksState(status: AppViewStatus.loading) => (
        l10n.tasksLoadingNoticeTitle,
        l10n.tasksLoadingNoticeMessage,
        AppStatusTone.info,
      ),
      TasksState(status: AppViewStatus.offline) => (
        l10n.tasksOfflineEmptyTitle,
        l10n.tasksOfflineEmptyMessage(name),
        AppStatusTone.warning,
      ),
      TasksState(online: false) => (
        l10n.tasksOfflineCachedTitle,
        state.lastSync == null
            ? l10n.tasksOfflineCachedMessageNoTime
            : l10n.tasksOfflineCachedMessage(
                AppFormats.dateTime(state.lastSync!, locale),
              ),
        AppStatusTone.warning,
      ),
      _ when updated != null => (
        updated.systemLabel == SystemLabel.updated
            ? l10n.tasksUpdateTitle
            : l10n.tasksLockedTitle,
        updated.systemLabel == SystemLabel.updated
            ? l10n.tasksUpdateMessage(updated.reference)
            : l10n.tasksLockedMessage(updated.reference),
        updated.systemLabel == SystemLabel.updated
            ? AppStatusTone.warning
            : AppStatusTone.danger,
      ),
      _ when unsent.isNotEmpty => (
        l10n.tasksPendingTitle(unsent.length),
        l10n.tasksPendingMessage(
          l10n.taskStatusLabel(unsent.last.newStatus ?? TaskStatus.assigned),
          AppFormats.time(unsent.last.reportedAt),
        ),
        AppStatusTone.success,
      ),
      TasksState(status: AppViewStatus.empty) => (
        l10n.tasksEmptyNoticeTitle,
        l10n.tasksEmptyNoticeMessage(name),
        AppStatusTone.info,
      ),
      _ => (
        switch (user?.role) {
          FieldRole.tugMaster => l10n.tasksScopeTugTitle,
          FieldRole.ctSupervisor => l10n.tasksScopeCtTitle,
          _ => l10n.tasksScopeTitle,
        },
        switch (user?.role) {
          FieldRole.ctSupervisor => l10n.tasksScopeCtMessage(name),
          _ => l10n.tasksScopeMessage(name),
        },
        AppStatusTone.info,
      ),
    };
    return AppNotice(title: title, message: message, tone: tone);
  }

  // DEV-ONLY (Flutter Screens)
  List<DevScenario> _devScenarios(BuildContext context) {
    final cubit = context.read<TasksCubit>();
    final backend = getIt<MockBackend>();
    final session = getIt<SessionState>();

    void as(FieldUser user) {
      backend
        ..tasksScenario = MockTasksScenario.normal
        ..clearOutbox()
        ..prepareUser(user)
        ..setOnline(true);
      session.signIn(user.role, user: user);
      cubit.load();
    }

    void tasks(MockTasksScenario s, {bool online = true}) {
      backend
        ..tasksScenario = s
        ..setOnline(online);
      cubit.load();
    }

    return [
      DevScenario('Assigned Marine Pilot tasks', () => as(MockData.pilot)),
      DevScenario('Assigned Tug Master tasks', () => as(MockData.tugMaster)),
      DevScenario(
        'CT supervisor terminal reporting',
        () => as(MockData.ctSupervisor),
      ),
      DevScenario(
        'Loading assigned tasks',
        () => tasks(MockTasksScenario.normal),
      ),
      DevScenario('No tasks assigned', () => tasks(MockTasksScenario.empty)),
      DevScenario('Could not load tasks', () => tasks(MockTasksScenario.fails)),
      DevScenario(
        'Offline cached tasks',
        () => tasks(MockTasksScenario.normal, online: false),
      ),
      DevScenario(
        'Offline no cached tasks',
        () => tasks(MockTasksScenario.empty, online: false),
      ),
      DevScenario('Sync pending', () {
        backend
          ..syncScenario = MockSyncScenario.transportFailure
          ..seedEvent(status: OutboxStatus.pending);
      }),
      DevScenario('Assignment update received', () {
        final first = backend.tasks.firstOrNull;
        if (first != null) {
          backend.applyPlanChange(first.id, SystemLabel.updated);
        }
      }),
      DevScenario('Plan cancelled', () {
        final first = backend.tasks.firstOrNull;
        if (first != null) {
          backend.applyPlanChange(first.id, SystemLabel.cancelled);
        }
      }),
      DevScenario('Sync works again', () {
        backend.syncScenario = MockSyncScenario.accept;
        backend.syncNow();
      }),
    ];
  }
}
