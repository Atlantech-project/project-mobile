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
import 'app_card.dart';
import 'app_connection_status.dart';
import 'app_header.dart';
import 'app_icon_button.dart';
import 'app_scaffold.dart';

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
          // DEV-ONLY: fixed to online until connectivity lands (MB-F2).
          if (!showNavigation && !showBack)
            const AppConnectionStatus(isOnline: true),
          AppIconButton(
            icon: Icons.translate,
            tooltip: l10n.switchLanguage,
            onPressed: () => context.read<LocaleCubit>().toggle(),
          ),
        ],
      ),
      body: LayoutBuilder(
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
