import 'package:flutter/widgets.dart';

import '../theme/app_sizes.dart';

/// The ATLANTECH wordmark with the "Intelligent Port Operations" line.
class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.width = AppSizes.logoHeaderWidth});

  static const String asset = 'assets/images/atlantech_logo.png';

  final double width;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      asset,
      width: width,
      fit: BoxFit.contain,
      semanticLabel: 'ATLANTECH',
      filterQuality: FilterQuality.medium,
    );
  }
}
