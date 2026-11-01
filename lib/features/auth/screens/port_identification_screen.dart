import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/di/injection.dart';
import '../../../core/localization/l10n/app_localizations.dart';
import '../../../core/mock/mock_backend.dart';
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
import '../cubit/port_cubit.dart';
import '../data/auth_repository.dart';

/// P-53 Port Identification (Figma 245:8078). The port comes from the
/// server; the user can only confirm it or stop.
class PortIdentificationScreen extends StatelessWidget {
  const PortIdentificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          PortCubit(getIt<AuthRepository>(), getIt<SessionState>())..load(),
      child: const _PortView(),
    );
  }
}

class _PortView extends StatelessWidget {
  const _PortView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AppScaffold(
      header: AppHeader(
        subtitle: l10n.portHeaderSubtitle,
        actions: const [AppConnectionStatus(), AppLanguageButton()],
      ),
      body: BlocBuilder<PortCubit, PortState>(
        builder: (context, state) => DevScenarioMenu(
          scenarios: _devScenarios(context),
          child: state.status == PortStatus.loading
              ? AppLoadingView(message: l10n.portLoading)
              : _PortPanel(state: state),
        ),
      ),
    );
  }

  // DEV-ONLY (Flutter Screens)
  List<DevScenario> _devScenarios(BuildContext context) {
    final cubit = context.read<PortCubit>();
    final backend = getIt<MockBackend>();
    void run(MockPortScenario s, {bool online = true}) {
      backend
        ..portScenario = s
        ..setOnline(online);
      cubit.load();
    }

    return [
      DevScenario(
        'Server identity loaded',
        () => run(MockPortScenario.identified),
      ),
      DevScenario(
        'Server unavailable (offline)',
        () => run(MockPortScenario.serverUnavailable, online: false),
      ),
      DevScenario(
        'Identity verification failed',
        () => run(MockPortScenario.verificationFailed),
      ),
      DevScenario('Connected port appears incorrect', cubit.markIncorrect),
    ];
  }
}

class _PortPanel extends StatelessWidget {
  const _PortPanel({required this.state});

  final PortState state;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final cubit = context.read<PortCubit>();
    final muted = AppTextStyles.bodyM.copyWith(color: AppColors.textMuted);
    final verified = state.port != null;

    final (noticeTitle, noticeMessage) = switch (state.status) {
      PortStatus.unavailable => (
        l10n.portUnavailableTitle,
        l10n.portUnavailableMessage,
      ),
      PortStatus.verificationFailed => (
        l10n.portFailedTitle,
        l10n.portFailedMessage,
      ),
      PortStatus.incorrect => (
        l10n.portIncorrectTitle,
        l10n.portIncorrectMessage,
      ),
      _ => (l10n.portLoadedTitle, l10n.portLoadedMessage),
    };

    final hint = switch (state.status) {
      PortStatus.loaded => l10n.portContinueHint,
      PortStatus.incorrect => l10n.portIncorrectHint,
      _ => l10n.portBlockedHint,
    };

    final Widget firstAction = switch (state.status) {
      PortStatus.loaded => AppButton.outline(
        label: l10n.portNotMyPortAction,
        icon: Icons.report_outlined,
        expand: true,
        onPressed: cubit.markIncorrect,
      ),
      _ => AppButton.primary(
        label: l10n.retryAction,
        icon: Icons.refresh,
        expand: true,
        onPressed: cubit.load,
      ),
    };
    final continueButton = AppButton.primary(
      label: l10n.continueAction,
      expand: true,
      onPressed: state.canContinue
          ? () {
              cubit.confirm();
              context.go(AppRoutes.loginPath);
            }
          : null,
    );

    return AppPanel(
      maxWidth: AppSizes.panelWide,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppSpacing.s3,
          children: [
            Text(l10n.portTitle, style: AppTextStyles.h1),
            Text(
              l10n.portIntro,
              style: AppTextStyles.bodyL.copyWith(color: AppColors.textMuted),
            ),
          ],
        ),
        AppNotice(
          title: noticeTitle,
          message: noticeMessage,
          tone: AppStatusTone.neutral,
          stacked: true,
        ),
        _IdentityCard(state: state, verified: verified),
        Flex(
          direction: context.isTablet ? Axis.horizontal : Axis.vertical,
          spacing: AppSpacing.s5,
          children: [
            context.isTablet ? Expanded(child: firstAction) : firstAction,
            context.isTablet ? Expanded(child: continueButton) : continueButton,
          ],
        ),
        Text(hint, style: muted),
      ],
    );
  }
}

/// Figma "Server identity card".
class _IdentityCard extends StatelessWidget {
  const _IdentityCard({required this.state, required this.verified});

  final PortState state;
  final bool verified;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final port = state.port;
    final muted = AppTextStyles.bodyM.copyWith(color: AppColors.textMuted);
    final label = AppTextStyles.bodyL.copyWith(color: AppColors.textMuted);
    final source = !verified
        ? l10n.portSourceNotVerified
        : state.status == PortStatus.incorrect
        ? l10n.portSourceBlocked
        : l10n.portSourceServer;

    final name = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.s3,
      children: [
        Text(l10n.portNameLabel, style: label),
        Text(
          port?.portName ?? l10n.portUnavailableValue,
          style: AppTextStyles.h1,
        ),
      ],
    );
    final code = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.s3,
      children: [
        Text(l10n.portIdentifierLabel, style: label),
        port == null
            ? Text(l10n.portUnavailableValue, style: AppTextStyles.h2)
            : AppIdText(port.portCode, style: AppTextStyles.h2),
      ],
    );

    return Container(
      padding: const EdgeInsetsDirectional.all(AppSpacing.s5),
      decoration: BoxDecoration(
        color: AppColors.bgSubtle,
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
          Row(
            children: [
              Expanded(
                child: Text(l10n.portConnectedLabel, style: AppTextStyles.h3),
              ),
              Text(source, style: muted),
            ],
          ),
          if (context.isTablet)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppSpacing.s8,
              children: [
                Expanded(child: name),
                code,
              ],
            )
          else ...[
            name,
            code,
          ],
          Container(
            padding: const EdgeInsetsDirectional.only(top: AppSpacing.s4),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: AppColors.borderDefault,
                  width: AppSizes.borderThin,
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(child: Text(l10n.portLicenseLabel, style: label)),
                _LicenseBadge(
                  text: verified
                      ? l10n.portLicenseActive
                      : l10n.portLicenseUnknown,
                ),
              ],
            ),
          ),
          if (!verified) Text(l10n.portNoIdentityNote, style: muted),
        ],
      ),
    );
  }
}

/// Figma "License badge": a surface tag with Heading/H3 text.
class _LicenseBadge extends StatelessWidget {
  const _LicenseBadge({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.s4,
        vertical: AppSpacing.s3,
      ),
      decoration: BoxDecoration(
        color: AppColors.bgSurface,
        borderRadius: AppRadius.smAll,
        border: Border.all(
          color: AppColors.borderStrong,
          width: AppSizes.borderThin,
        ),
      ),
      child: Text(text, style: AppTextStyles.h3),
    );
  }
}
