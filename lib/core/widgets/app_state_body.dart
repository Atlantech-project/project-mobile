import 'package:flutter/widgets.dart';

import 'app_loading_view.dart';
import 'app_state_view.dart';

/// Where a page's data stands. A screen's Cubit state carries one of these.
enum AppViewStatus { loading, ready, empty, error, offline }

/// Picks the body for a page from its [status]: the loading view, the empty,
/// error or offline state, or [builder] once the data is [AppViewStatus.ready].
///
/// One place decides how every page looks while it has no content, so pages
/// only describe their own content and wording.
class AppStateBody extends StatelessWidget {
  const AppStateBody({
    super.key,
    required this.status,
    required this.builder,
    this.onRetry,
    this.loadingMessage,
    this.emptyTitle,
    this.emptyMessage,
    this.emptyIcon,
    this.errorMessage,
    this.compact = false,
  });

  final AppViewStatus status;
  final WidgetBuilder builder;

  /// Shown as "Try again" on error and offline.
  final VoidCallback? onRetry;

  final String? loadingMessage;
  final String? emptyTitle;
  final String? emptyMessage;
  final IconData? emptyIcon;
  final String? errorMessage;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final child = switch (status) {
      AppViewStatus.ready => builder(context),
      AppViewStatus.loading => AppLoadingView(
        message: loadingMessage,
        compact: compact,
      ),
      AppViewStatus.empty => AppStateView.empty(
        title: emptyTitle,
        message: emptyMessage,
        icon: emptyIcon,
        compact: compact,
      ),
      AppViewStatus.error => AppStateView.error(
        message: errorMessage,
        onRetry: onRetry,
        compact: compact,
      ),
      AppViewStatus.offline => AppStateView.offline(
        onRetry: onRetry,
        compact: compact,
      ),
    };
    // A short cross-fade so the content does not jump in.
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: KeyedSubtree(key: ValueKey(status), child: child),
    );
  }
}
