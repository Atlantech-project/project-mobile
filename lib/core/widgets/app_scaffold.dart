import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'app_backdrop.dart';
import 'app_footer.dart';
import 'app_header.dart';

/// The app shell from the design: header (88) on top, body, footer (40) at
/// the bottom. No bottom navigation bar.
class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.header,
    required this.body,
    this.footer,
    this.backdrop = false,
  });

  final AppHeader header;
  final Widget body;
  final AppFooter? footer;

  /// Puts the port photo behind the body, as on the sign-in screen.
  final bool backdrop;

  @override
  Widget build(BuildContext context) {
    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(child: body),
        ?footer,
      ],
    );

    return Scaffold(
      backgroundColor: AppColors.bgPage,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            header,
            Expanded(child: backdrop ? AppBackdrop(child: content) : content),
          ],
        ),
      ),
    );
  }
}
