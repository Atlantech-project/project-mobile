import 'package:flutter/material.dart';

import '../responsive/responsive.dart';
import '../theme/app_colors.dart';
import '../theme/app_sizes.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

/// Figma: footer strip (245:7072, 40 tall). Muted text at the start and end.
class AppFooter extends StatelessWidget {
  const AppFooter({super.key, this.start, this.end});

  final String? start;
  final String? end;

  @override
  Widget build(BuildContext context) {
    final style = AppTextStyles.bodyS.copyWith(color: AppColors.textMuted);
    return Container(
      height: AppSizes.footerHeight,
      padding: EdgeInsetsDirectional.symmetric(
        horizontal: context.layout.margin,
      ),
      alignment: AlignmentDirectional.centerStart,
      child: Row(
        spacing: AppSpacing.s5,
        children: [
          Expanded(
            child: Text(
              start ?? '',
              style: style,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (end != null) Text(end!, style: style, maxLines: 1),
        ],
      ),
    );
  }
}
