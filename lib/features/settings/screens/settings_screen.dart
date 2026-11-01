import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/di/injection.dart';
import '../../../core/localization/app_labels.dart';
import '../../../core/localization/l10n/app_localizations.dart';
import '../../../core/mock/mock_backend.dart';
import '../../../core/models/outbox_event.dart';
import '../../../core/network/client_info.dart';
import '../../../core/network/connection_cubit.dart';
import '../../../core/responsive/responsive.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/router/session_state.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/theme/app_sizes.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/dev_scenario_menu.dart';
import '../../../core/widgets/widgets.dart';
import '../../auth/data/auth_repository.dart';
import '../../sync/data/outbox_repository.dart';
import '../../sync/widgets/event_texts.dart';
import '../cubit/settings_cubit.dart';
import '../widgets/info_row.dart';

/// P-58 Settings & Session (Figma 245:5329). Read-only, plus Log Out.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SettingsCubit(
        getIt<AuthRepository>(),
        getIt<OutboxRepository>(),
        getIt<SessionState>(),
        getIt<ConnectionCubit>(),
      )..load(),
      child: const _SettingsView(),
    );
  }
}

class _SettingsView extends StatelessWidget {
  const _SettingsView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final session = getIt<SessionState>();
    return AppScaffold(
      header: AppHeader(
        title: l10n.settingsTitle,
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
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) => DevScenarioMenu(
          scenarios: _devScenarios(context),
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

  List<Widget> _content(BuildContext context, SettingsState state) {
    final l10n = AppLocalizations.of(context);
    if (state.loading) {
      return [
        AppCard(
          child: SizedBox(
            height: _loadingHeight,
            child: AppLoadingView(message: l10n.settingsLoading),
          ),
        ),
      ];
    }

    // DEV-ONLY (Flutter Screens): the real "unknown" state comes with the
    // connectivity work; the mock flag stands in for it.
    final unknown = getIt<MockBackend>().connectionUnknown;
    final unsent = state.unsent;
    final latest = unsent.isEmpty ? null : unsent.last;

    final String stripTitle;
    final String stripCaption;
    if (unknown) {
      stripTitle = l10n.settingsStripUnknown;
      stripCaption = l10n.settingsStripNone;
    } else if (latest == null) {
      stripTitle = l10n.settingsStripNoEvents;
      stripCaption = l10n.settingsStripNone;
    } else {
      stripTitle = l10n.settingsStripPending(unsent.length);
      stripCaption = l10n.settingsStripPendingCaption(l10n.eventAction(latest));
    }

    final (String, String, AppStatusTone) notice = switch (null) {
      _ when unknown => (
        l10n.settingsUnknownTitle,
        l10n.settingsUnknownMessage,
        AppStatusTone.neutral,
      ),
      _ when unsent.isNotEmpty => (
        l10n.settingsPendingTitle,
        l10n.settingsPendingMessage,
        AppStatusTone.warning,
      ),
      _ => (
        l10n.settingsReadOnlyTitle,
        l10n.settingsReadOnlyMessage,
        AppStatusTone.info,
      ),
    };

    final left = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: AppSpacing.s5,
      children: [_Account(), _Port()],
    );
    final right = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: AppSpacing.s5,
      children: [
        _Application(online: state.online, unknown: unknown),
        _Session(state: state),
      ],
    );

    return [
      AppSyncStrip(
        title: stripTitle,
        caption: stripCaption,
        connectionUnknown: unknown,
      ),
      AppNotice(title: notice.$1, message: notice.$2, tone: notice.$3),
      if (context.isTablet)
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppSpacing.s7,
          children: [
            Expanded(child: left),
            Expanded(child: right),
          ],
        )
      else ...[
        left,
        right,
      ],
    ];
  }

  /// Figma "Loading" workspace height.
  static const double _loadingHeight = 200;

  // DEV-ONLY (Flutter Screens)
  List<DevScenario> _devScenarios(BuildContext context) {
    final cubit = context.read<SettingsCubit>();
    final backend = getIt<MockBackend>();
    void reset() {
      backend
        ..syncScenario = MockSyncScenario.accept
        ..clearOutbox()
        ..setOnline(true);
    }

    return [
      DevScenario('Normal settings', reset),
      DevScenario('Loading', cubit.load),
      DevScenario('Pending events before logout', () {
        reset();
        backend
          ..syncScenario = MockSyncScenario.transportFailure
          ..setOnline(false)
          ..seedEvent(status: OutboxStatus.pending)
          ..setOnline(true);
      }),
      DevScenario('Connection status unavailable', () {
        reset();
        backend.connectionUnknown = true;
        cubit.load();
      }),
    ];
  }
}

class _Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final user = getIt<SessionState>().user;
    return InfoCard(
      title: l10n.settingsAccountTitle,
      children: [
        InfoRow(
          label: l10n.settingsAccountName,
          value: user?.displayName ?? l10n.settingsNotAvailable,
        ),
        InfoRow(
          label: l10n.settingsUsername,
          value: user?.username ?? l10n.settingsNotAvailable,
          ltrValue: true,
        ),
        InfoRow(
          label: l10n.settingsRole,
          value: user == null
              ? l10n.settingsNotAvailable
              : l10n.roleLabel(user.role),
        ),
      ],
    );
  }
}

class _Port extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final port = getIt<SessionState>().port;
    return InfoCard(
      title: l10n.settingsPortTitle,
      children: [
        InfoRow(
          label: l10n.settingsPortName,
          value: port?.portName ?? l10n.settingsNotAvailable,
        ),
        InfoRow(
          label: l10n.settingsPortId,
          value: port?.portCode ?? l10n.settingsNotAvailable,
          ltrValue: port != null,
        ),
        Text(
          l10n.settingsPortNote,
          style: AppTextStyles.bodyM.copyWith(color: AppColors.textMuted),
        ),
      ],
    );
  }
}

class _Application extends StatelessWidget {
  const _Application({required this.online, required this.unknown});

  final bool online;
  final bool unknown;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final client = getIt<ClientInfo>();
    return InfoCard(
      title: l10n.settingsAppTitle,
      children: [
        InfoRow(
          label: l10n.settingsVersion,
          value: client.appVersion,
          ltrValue: true,
        ),
        InfoRow(
          label: l10n.settingsDevice,
          value: client.deviceId ?? l10n.settingsNotAvailable,
          ltrValue: client.deviceId != null,
        ),
        InfoRow(
          label: l10n.settingsConnection,
          value: unknown
              ? l10n.connectionUnknown
              : online
              ? l10n.connectionOnline
              : l10n.connectionOffline,
        ),
        Text(
          l10n.settingsAppNote,
          style: AppTextStyles.bodyM.copyWith(color: AppColors.textMuted),
        ),
      ],
    );
  }
}

/// Figma "Current device session".
class _Session extends StatelessWidget {
  const _Session({required this.state});

  final SettingsState state;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final pending = state.unsent.length;
    final logout = AppButton.primary(
      label: l10n.settingsLogOut,
      icon: Icons.logout,
      expand: pending == 0,
      isLoading: state.loggingOut,
      onPressed: state.loggingOut ? null : () => _confirm(context),
    );
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: AppSpacing.s4,
        children: [
          Text(l10n.settingsSessionTitle, style: AppTextStyles.h2),
          Text(
            pending == 0
                ? l10n.settingsSessionMessage
                : l10n.settingsSessionPending(pending),
            style: AppTextStyles.bodyL.copyWith(color: AppColors.textPrimary),
          ),
          if (pending == 0)
            logout
          else
            Row(
              spacing: AppSpacing.s4,
              children: [
                Expanded(
                  child: AppButton.outline(
                    label: l10n.settingsReviewOutbox,
                    icon: Icons.outbox_outlined,
                    expand: true,
                    onPressed: () => context.push(AppRoutes.syncPath),
                  ),
                ),
                logout,
              ],
            ),
        ],
      ),
    );
  }

  Future<void> _confirm(BuildContext context) async {
    final cubit = context.read<SettingsCubit>();
    final result = await showDialog<_LogoutChoice>(
      context: context,
      barrierColor: AppColors.overlayScrim,
      builder: (_) => _LogoutDialog(
        unsent: state.unsent,
        username: getIt<SessionState>().user?.username ?? '',
      ),
    );
    if (!context.mounted) return;
    switch (result) {
      case _LogoutChoice.confirm:
        await cubit.logout();
      case _LogoutChoice.review:
        await context.push(AppRoutes.syncPath);
      case null:
        break;
    }
  }
}

enum _LogoutChoice { confirm, review }

/// Figma "Logout confirmation dialog" (245:5486).
class _LogoutDialog extends StatelessWidget {
  const _LogoutDialog({required this.unsent, required this.username});

  final List<OutboxEvent> unsent;
  final String username;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final pending = unsent.length;
    final nav = Navigator.of(context);
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.all(AppSpacing.s7),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: AppSizes.panelWide),
        child: Container(
          padding: const EdgeInsetsDirectional.all(AppSpacing.s8),
          decoration: BoxDecoration(
            color: AppColors.bgSurface,
            borderRadius: AppRadius.mdAll,
            border: Border.all(
              color: AppColors.borderDefault,
              width: AppSizes.borderThin,
            ),
            boxShadow: AppShadows.elevation3,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: AppSpacing.s6,
              children: [
                Text(l10n.logoutDialogTitle, style: AppTextStyles.h3Size26),
                Text(
                  pending == 0
                      ? l10n.logoutDialogMessage
                      : l10n.logoutDialogMessagePending(pending),
                  style: AppTextStyles.body18.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                if (pending > 0) ...[
                  RetainedEventsBox(
                    title: l10n.logoutRetainedTitle(
                      l10n.eventAction(unsent.last),
                    ),
                    message: l10n.logoutRetainedMessage(ltrIsolate(username)),
                  ),
                  AppButton.outline(
                    label: l10n.logoutReviewPending,
                    icon: Icons.outbox_outlined,
                    expand: true,
                    onPressed: () => nav.pop(_LogoutChoice.review),
                  ),
                ],
                Row(
                  spacing: AppSpacing.s5,
                  children: [
                    Expanded(
                      child: AppButton.secondary(
                        label: l10n.cancelAction,
                        expand: true,
                        onPressed: () => nav.pop(),
                      ),
                    ),
                    Expanded(
                      child: AppButton.primary(
                        label: l10n.logoutConfirm,
                        expand: true,
                        onPressed: () => nav.pop(_LogoutChoice.confirm),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
