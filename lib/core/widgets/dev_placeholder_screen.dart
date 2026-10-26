// DEV-ONLY: replaced screen by screen as each P-xx task lands.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../di/injection.dart';
import '../localization/l10n/app_localizations.dart';
import '../localization/locale_cubit.dart';
import '../responsive/responsive.dart';
import '../router/app_routes.dart';
import '../router/session_state.dart';
import '../theme/app_shadows.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import 'app_button.dart';
import 'app_card.dart';
import 'app_connection_status.dart';
import 'app_header.dart';
import 'app_icon_button.dart';
import 'app_scaffold.dart';
import 'app_state_body.dart';

/// DEV-ONLY: a stand-in for a screen that is not built yet, with dev buttons
/// to walk the redirect flow.
class DevPlaceholderScreen extends StatelessWidget {
  const DevPlaceholderScreen({
    super.key,
    required this.title,
    this.devActions = const [],
    this.showNavigation = false,
    this.showBack = false,
    this.backdrop = false,
  });

  final String title;

  /// DEV-ONLY buttons that drive [SessionState] or navigation.
  final List<Widget> devActions;

  /// Show the Notifications / Settings header actions (signed-in screens).
  final bool showNavigation;

  /// Show the header back button.
  final bool showBack;

  /// Port photo behind the content, as on the sign-in screen.
  final bool backdrop;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final role = getIt<SessionState>().role;

    return AppScaffold(
      backdrop: backdrop,
      header: AppHeader(
        title: title,
        subtitle: role == null ? null : _roleLabel(l10n, role),
        onBack: showBack ? () => _back(context) : null,
        actions: [
          if (showNavigation) ...[
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
          ],
          // Before sign-in the header shows the connection state (info only).
          if (!showNavigation && !showBack) const AppConnectionStatus(),
          AppIconButton(
            icon: Icons.translate,
            tooltip: l10n.switchLanguage,
            onPressed: () => context.read<LocaleCubit>().toggle(),
          ),
        ],
      ),
      body: _DevStates(
        builder: (context, preview) => LayoutBuilder(
          builder: (context, box) {
            final margin = context.layout.margin;
            final card = AppCard(
              padding: const EdgeInsetsDirectional.all(AppSpacing.s7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: AppSpacing.s5,
                children: [
                  Text(title, style: AppTextStyles.tabletH2),
                  Text(l10n.placeholderNote, style: AppTextStyles.tabletBody),
                  ...devActions,
                  preview,
                ],
              ),
            );
            return SingleChildScrollView(
              padding: EdgeInsetsDirectional.all(margin),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: box.maxHeight - 2 * margin,
                ),
                child: Align(
                  alignment: backdrop
                      ? AlignmentDirectional.center
                      : AlignmentDirectional.topCenter,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 640),
                    child: backdrop
                        ? DecoratedBox(
                            decoration: BoxDecoration(
                              boxShadow: AppShadows.elevation3,
                            ),
                            child: card,
                          )
                        : card,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _back(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.tasksPath);
    }
  }

  static String _roleLabel(AppLocalizations l10n, FieldRole role) =>
      switch (role) {
        FieldRole.marinePilot => l10n.roleMarinePilot,
        FieldRole.tugMaster => l10n.roleTugMaster,
        FieldRole.ctSupervisor => l10n.roleCtSupervisor,
        FieldRole.nctSupervisor => l10n.roleNctSupervisor,
        FieldRole.unsupported => l10n.roleUnsupported,
      };
}

/// DEV-ONLY (MB-S01): lets the team see the loading, empty, error and offline
/// states on every page until the real pages and their Cubits land.
class _DevStates extends StatefulWidget {
  const _DevStates({required this.builder});

  /// Builds the placeholder content; `preview` is the row of state buttons.
  final Widget Function(BuildContext context, Widget preview) builder;

  @override
  State<_DevStates> createState() => _DevStatesState();
}

class _DevStatesState extends State<_DevStates> {
  AppViewStatus _status = AppViewStatus.ready;

  void _show(AppViewStatus status) {
    setState(() => _status = status);
    if (status == AppViewStatus.loading) {
      Future<void>.delayed(const Duration(seconds: 3), () {
        if (mounted && _status == AppViewStatus.loading) {
          setState(() => _status = AppViewStatus.ready);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final preview = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: AppSpacing.s3,
      children: [
        Text(l10n.devPreviewStates, style: AppTextStyles.labelL),
        Wrap(
          spacing: AppSpacing.s3,
          runSpacing: AppSpacing.s3,
          children: [
            for (final (status, label) in [
              (AppViewStatus.loading, l10n.loading),
              (AppViewStatus.empty, l10n.devStateEmpty),
              (AppViewStatus.error, l10n.devStateError),
              (AppViewStatus.offline, l10n.devStateOffline),
            ])
              AppButton.outline(
                label: label,
                size: AppButtonSize.web,
                onPressed: () => _show(status),
              ),
          ],
        ),
      ],
    );

    return AppStateBody(
      status: _status,
      onRetry: () => _show(AppViewStatus.loading),
      builder: (context) => widget.builder(context, preview),
    );
  }
}
