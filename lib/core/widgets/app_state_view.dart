import 'package:flutter/material.dart';

import '../localization/l10n/app_localizations.dart';
import '../responsive/responsive.dart';
import '../theme/app_colors.dart';
import '../theme/app_sizes.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import 'app_button.dart';
import 'app_status_badge.dart';

/// Which state a page (or a section of one) is in when it has no content.
enum AppStateKind {
  /// Loaded fine, nothing to show (no tasks, no notifications).
  empty,

  /// Loading failed.
  error,

  /// No connection and nothing saved on the device to show.
  offline,
}

/// Empty, error and offline states: art, a title, a message and up to two
/// actions. Every kind has default wording, so `AppStateView.error(onRetry:
/// cubit.load)` is enough on most pages; pass [title] and [message] to say
/// something specific ("No tasks assigned yet").
///
/// Full pages show the brand symbol (the loading symbol, emptied) with a
/// status badge. Use it as the `body` of an [AppScaffold].
class AppStateView extends StatelessWidget {
  const AppStateView({
    super.key,
    required this.kind,
    this.title,
    this.message,
    this.icon,
    this.actionLabel,
    this.onAction,
    this.secondaryLabel,
    this.onSecondary,
    this.compact = false,
  });

  const AppStateView.empty({
    super.key,
    this.title,
    this.message,
    this.icon,
    this.actionLabel,
    this.onAction,
    this.secondaryLabel,
    this.onSecondary,
    this.compact = false,
  }) : kind = AppStateKind.empty;

  /// [onRetry] shows a "Try again" button.
  const AppStateView.error({
    super.key,
    this.title,
    this.message,
    this.icon,
    VoidCallback? onRetry,
    this.secondaryLabel,
    this.onSecondary,
    this.compact = false,
  }) : kind = AppStateKind.error,
       actionLabel = null,
       onAction = onRetry;

  /// [onRetry] shows a "Try again" button.
  const AppStateView.offline({
    super.key,
    this.title,
    this.message,
    this.icon,
    VoidCallback? onRetry,
    this.secondaryLabel,
    this.onSecondary,
    this.compact = false,
  }) : kind = AppStateKind.offline,
       actionLabel = null,
       onAction = onRetry;

  final AppStateKind kind;
  final String? title;
  final String? message;

  /// Replaces the kind's default icon (e.g. a bell for no notifications).
  final IconData? icon;

  /// Primary action. Error and offline default to "Try again".
  final String? actionLabel;
  final VoidCallback? onAction;

  final String? secondaryLabel;
  final VoidCallback? onSecondary;

  /// Fits a card or a list: a status icon in a circle instead of the brand
  /// symbol, and smaller buttons.
  final bool compact;

  AppStatusTone get _tone => switch (kind) {
    AppStateKind.empty => AppStatusTone.neutral,
    AppStateKind.error => AppStatusTone.danger,
    AppStateKind.offline => AppStatusTone.warning,
  };

  IconData get _icon =>
      icon ??
      switch (kind) {
        AppStateKind.empty => Icons.inbox_outlined,
        AppStateKind.error => Icons.error_outline,
        AppStateKind.offline => Icons.cloud_off_outlined,
      };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final big = !compact && context.isTablet;

    final heading =
        title ??
        switch (kind) {
          AppStateKind.empty => l10n.stateEmptyTitle,
          AppStateKind.error => l10n.stateErrorTitle,
          AppStateKind.offline => l10n.stateOfflineTitle,
        };
    final body =
        message ??
        switch (kind) {
          AppStateKind.empty => l10n.stateEmptyMessage,
          AppStateKind.error => l10n.stateErrorMessage,
          AppStateKind.offline => l10n.stateOfflineMessage,
        };
    final primaryLabel =
        actionLabel ?? (kind == AppStateKind.empty ? null : l10n.retryAction);

    final buttons = <Widget>[
      if (onAction != null && primaryLabel != null)
        AppButton.primary(
          label: primaryLabel,
          icon: kind == AppStateKind.empty ? null : Icons.refresh,
          onPressed: onAction,
          size: compact ? AppButtonSize.web : AppButtonSize.tablet,
        ),
      if (onSecondary != null && secondaryLabel != null)
        AppButton.secondary(
          label: secondaryLabel!,
          onPressed: onSecondary,
          size: compact ? AppButtonSize.web : AppButtonSize.tablet,
        ),
    ];

    final content = ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: AppSizes.stateTextMax),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          !compact
              ? _SymbolArt(
                  tone: _tone,
                  icon: _icon,
                  showBadge: kind != AppStateKind.empty || icon != null,
                  width: big
                      ? AppSizes.loadingLg + AppSpacing.s7
                      : AppSizes.loadingLg,
                )
              : _IconArt(tone: _tone, icon: _icon),
          SizedBox(height: big ? AppSpacing.s7 : AppSpacing.s5),
          Text(
            heading,
            style: big ? AppTextStyles.tabletH2 : AppTextStyles.h3,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.s3),
          Text(
            body,
            style: (big ? AppTextStyles.tabletBody : AppTextStyles.bodyL)
                .copyWith(color: AppColors.textMuted),
            textAlign: TextAlign.center,
          ),
          if (buttons.isNotEmpty) ...[
            SizedBox(height: big ? AppSpacing.s7 : AppSpacing.s5),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: AppSpacing.s4,
              runSpacing: AppSpacing.s4,
              children: buttons,
            ),
          ],
        ],
      ),
    );

    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsetsDirectional.all(
          compact ? AppSpacing.s5 : context.layout.margin,
        ),
        child: Semantics(
          liveRegion: kind != AppStateKind.empty,
          child: content,
        ),
      ),
    );
  }
}

/// The brand symbol in neutral (the loading symbol, emptied), with a status
/// badge on its end corner.
class _SymbolArt extends StatelessWidget {
  const _SymbolArt({
    required this.tone,
    required this.icon,
    required this.showBadge,
    required this.width,
  });

  static const String _symbol = 'assets/images/brand/symbol.png';
  static const double _aspect = 707 / 484;

  final AppStatusTone tone;
  final IconData icon;
  final bool showBadge;
  final double width;

  @override
  Widget build(BuildContext context) {
    final height = width / _aspect;
    return SizedBox(
      width: width + AppSizes.stateBadge / 2,
      height: height + AppSpacing.s3,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          PositionedDirectional(
            start: 0,
            top: 0,
            child: Image.asset(
              _symbol,
              width: width,
              height: height,
              fit: BoxFit.fill,
              color: AppColors.loadingEmpty,
              colorBlendMode: BlendMode.srcIn,
              filterQuality: FilterQuality.medium,
              excludeFromSemantics: true,
            ),
          ),
          if (showBadge)
            PositionedDirectional(
              end: 0,
              bottom: 0,
              child: Container(
                width: AppSizes.stateBadge,
                height: AppSizes.stateBadge,
                decoration: BoxDecoration(
                  color: tone.bg,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: tone.border,
                    width: AppSizes.borderMedium,
                  ),
                ),
                child: Icon(
                  icon,
                  size: AppSizes.stateBadgeIcon,
                  color: tone.fg,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// A status-tinted circle with the kind's icon (compact states).
class _IconArt extends StatelessWidget {
  const _IconArt({required this.tone, required this.icon});

  final AppStatusTone tone;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSizes.stateArt,
      height: AppSizes.stateArt,
      decoration: BoxDecoration(
        color: tone.bg,
        shape: BoxShape.circle,
        border: Border.all(color: tone.border, width: AppSizes.borderThin),
      ),
      child: Icon(icon, size: AppSizes.stateArtIcon, color: tone.fg),
    );
  }
}
