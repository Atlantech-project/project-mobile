import 'package:flutter/material.dart';

import '../responsive/responsive.dart';
import '../theme/app_sizes.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import 'app_status_badge.dart';

/// Figma: State notice (e.g. 245:7031). A tinted banner with a stripe on the
/// start edge, a heading and a message. Heading sits beside the message on
/// tablet and above it on phone.
class AppNotice extends StatelessWidget {
  const AppNotice({
    super.key,
    required this.title,
    this.message,
    this.tone = AppStatusTone.info,
  });

  final String title;
  final String? message;
  final AppStatusTone tone;

  @override
  Widget build(BuildContext context) {
    final heading = Text(
      title,
      style: AppTextStyles.h3.copyWith(color: tone.fg),
    );
    final body = message == null
        ? null
        : Text(message!, style: AppTextStyles.bodyL.copyWith(color: tone.fg));
    final side = BorderSide(color: tone.border, width: AppSizes.borderThin);

    return Container(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.s5,
        vertical: AppSpacing.s4,
      ),
      decoration: BoxDecoration(
        color: tone.bg,
        border: BorderDirectional(
          start: BorderSide(color: tone.border, width: AppSizes.noticeStripe),
          top: side,
          end: side,
          bottom: side,
        ),
      ),
      child: context.isTablet && body != null
          ? Row(
              spacing: AppSpacing.s7,
              children: [
                SizedBox(width: AppSizes.noticeHeadingWidth, child: heading),
                Expanded(child: body),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: AppSpacing.s2,
              children: [heading, ?body],
            ),
    );
  }
}
