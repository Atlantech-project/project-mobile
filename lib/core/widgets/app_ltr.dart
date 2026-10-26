import 'package:flutter/widgets.dart';

import '../theme/app_text_styles.dart';

/// Keeps IDs, codes and times left to right inside RTL layouts.
class AppLtr extends StatelessWidget {
  const AppLtr({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) =>
      Directionality(textDirection: TextDirection.ltr, child: child);
}

/// An ID such as PT-A-0109 or an IMO number: Roboto Mono, always LTR.
///
/// Uses Unicode isolation so the characters stay LTR while the text still
/// aligns to the start edge of an RTL layout.
class AppIdText extends StatelessWidget {
  const AppIdText(this.id, {super.key, this.style});

  final String id;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(ltrIsolate(id), style: style ?? AppTextStyles.monoM);
  }
}

/// Wraps [text] in a left-to-right isolate (LRI … PDI) for use inside RTL text.
String ltrIsolate(String text) => '\u2066$text\u2069';
