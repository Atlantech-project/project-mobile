import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/localization/l10n/app_localizations.dart';
import '../../../core/localization/locale_cubit.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/widgets/app_header.dart';
import '../../../core/widgets/app_icon_button.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/app_state_view.dart';

/// Shown by the router for a link that matches no page.
class PageNotFoundScreen extends StatelessWidget {
  const PageNotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AppScaffold(
      header: AppHeader(
        actions: [
          AppIconButton(
            icon: Icons.translate,
            tooltip: l10n.switchLanguage,
            onPressed: () => context.read<LocaleCubit>().toggle(),
          ),
        ],
      ),
      body: AppStateView(
        kind: AppStateKind.error,
        icon: Icons.explore_off_outlined,
        title: l10n.pageNotFoundTitle,
        message: l10n.pageNotFoundMessage,
        actionLabel: l10n.backToStartAction,
        // The redirect sends the user to the right first page.
        onAction: () => context.go(AppRoutes.portPath),
      ),
    );
  }
}
