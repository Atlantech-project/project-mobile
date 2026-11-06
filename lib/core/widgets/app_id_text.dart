import 'package:flutter/widgets.dart';

import '../theme/app_text_styles.dart';

/// An ID such as PT-A-0109 or an IMO number, in Roboto Mono.
class AppIdText extends StatelessWidget {
  const AppIdText(this.id, {super.key, this.style});

  final String id;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(id, style: style ?? AppTextStyles.monoM);
  }
}
