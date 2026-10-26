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
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import 'app_card.dart';
import 'app_footer.dart';
import 'app_header.dart';
import 'app_ltr.dart';
import 'app_scaffold.dart';

/// DEV-ONLY: a stand-in for a screen that is not built yet. Shows the screen
/// ID, the task that will build it, and dev buttons to walk the redirect flow.
class DevPlaceholderScreen extends StatelessWidget {
  const DevPlaceholderScreen({
    super.key,
    required this.screenId,
    required this.taskId,
    required this.title,
    this.devActions = const [],
    this.showNavigation = false,
    this.showBack = false,
  });

  final String screenId;
  final String taskId;
  final String title;

  /// DEV-ONLY buttons that drive [SessionState] or navigation.
  final List<Widget> devActions;

  /// Show the Notifications / Settings header actions (signed-in screens).
  final bool showNavigation;

  /// Show the header back button.
  final bool showBack;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final role = getIt<SessionState>().role;

    return AppScaffold(
      header: AppHeader(
        title: title,
        subtitle: role == null
            ? l10n.fieldOperations
            : '${_roleLabel(l10n, role)} · ${l10n.fieldOperations}',
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
          AppHeaderAction(
            icon: Icons.translate,
            label: l10n.switchLanguage,
            onPressed: () => context.read<LocaleCubit>().toggle(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsetsDirectional.all(context.layout.margin),
        child: Align(
          alignment: AlignmentDirectional.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: AppCard(
              padding: const EdgeInsetsDirectional.all(AppSpacing.s7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: AppSpacing.s5,
                children: [
                  AppIdText(
                    screenId,
                    style: AppTextStyles.numberM.copyWith(
                      color: AppColors.textAccent,
                    ),
                  ),
                  Text(title, style: AppTextStyles.tabletH2),
                  Text(
                    l10n.placeholderNote(taskId),
                    style: AppTextStyles.tabletBody,
                  ),
                  ...devActions,
                ],
              ),
            ),
          ),
        ),
      ),
      footer: AppFooter(
        start: '${l10n.appName} · ${l10n.fieldOperations}',
        end: screenId,
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
