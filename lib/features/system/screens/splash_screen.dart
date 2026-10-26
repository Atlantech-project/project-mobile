import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../../core/localization/l10n/app_localizations.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_sizes.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../widgets/splash_lockup.dart';
import '../widgets/splash_sea.dart';

/// Splash: the reversed lockup builds itself over a moving sea while the app
/// starts up, then hands over to the router, whose redirect picks the first
/// real page (port, sign-in or My Tasks).
///
/// The brand cover is the one dark screen of the app. It follows the Android
/// launch screen (same navy), so the hand-over from the system is seamless.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, this.startup});

  /// Start-up work to finish before leaving the splash.
  // TODO(MB-F3): restore the session from secure storage here.
  final Future<void> Function()? startup;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  /// Length of the logo build, in seconds.
  static const double _total = 3.4;

  late final AnimationController _build = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 3400),
  );
  late final AnimationController _sea = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 12),
  )..repeat();

  /// The logo has played but start-up work is still running.
  bool _waiting = false;
  bool _started = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started) return;
    _started = true;
    unawaited(_run(MediaQuery.disableAnimationsOf(context)));
  }

  Future<void> _run(bool reduceMotion) async {
    final startup = (widget.startup ?? () async {})();
    var startupDone = false;
    unawaited(startup.whenComplete(() => startupDone = true));
    if (reduceMotion) {
      // No build animation: show the finished lockup for a moment.
      _build.value = 1;
      _sea.stop();
      await Future<void>.delayed(const Duration(milliseconds: 900));
    } else {
      await _build.forward().orCancel.catchError((_) {});
    }
    if (!mounted) return;
    if (!startupDone) setState(() => _waiting = true);
    await startup;
    if (mounted) context.go(AppRoutes.portPath);
  }

  @override
  void dispose() {
    _build.dispose();
    _sea.dispose();
    super.dispose();
  }

  double _p(double a, double b, [Curve curve = Curves.linear]) {
    final t = ((_build.value * _total - a) / (b - a)).clamp(0.0, 1.0);
    return curve.transform(t);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.coverEdge,
        body: LayoutBuilder(
          builder: (context, box) {
            final seaHeight = box.maxHeight * 0.24;
            final lockupWidth = math.min(
              math.min(box.maxWidth * 0.62, AppSizes.splashLockupMax),
              // Keep room for the status line on short (landscape) phones.
              (box.maxHeight - seaHeight) * 0.9,
            );

            return AnimatedBuilder(
              animation: Listenable.merge([_build, _sea]),
              builder: (context, _) => Stack(
                fit: StackFit.expand,
                children: [
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        center: Alignment(0, -0.25),
                        radius: 1.1,
                        colors: [AppColors.coverGlow, AppColors.coverEdge],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    height: seaHeight,
                    child: Opacity(
                      opacity: _p(0, 1.2, Curves.easeOut),
                      child: SplashSea(phase: _sea.value),
                    ),
                  ),
                  Positioned.fill(
                    bottom: seaHeight,
                    child: SafeArea(
                      bottom: false,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          spacing: AppSpacing.s10,
                          children: [
                            SplashLockup(width: lockupWidth, p: _p),
                            Opacity(
                              opacity: _p(2.2, 2.9, Curves.easeOut),
                              child: _Status(
                                text: l10n.splashStatus,
                                progress: _build.value,
                                waiting: _waiting,
                                pulse: _sea.value,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

/// A short gold hairline that fills while the logo builds, with a status
/// line. If start-up work outlasts the logo, a gold segment keeps sliding
/// along the hairline so the app never looks frozen.
class _Status extends StatelessWidget {
  const _Status({
    required this.text,
    required this.progress,
    required this.waiting,
    required this.pulse,
  });

  final String text;
  final double progress;
  final bool waiting;

  /// 0 → 1, looping.
  final double pulse;

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    // Arabic letters join, so they get no tracking and no upper case.
    final style = AppTextStyles.labelM.copyWith(
      color: AppColors.coverText.withValues(alpha: 0.75),
      letterSpacing: isRtl ? 0 : 1.6,
    );

    const segment = 0.3;
    // 12 s sea loop → the segment crosses the hairline every 2 s.
    final sweep = (pulse * 6) % 1;
    final alignX = -1 - segment + sweep * (2 + 2 * segment);

    return Semantics(
      liveRegion: true,
      label: text,
      child: ExcludeSemantics(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: AppSpacing.s4,
          children: [
            SizedBox(
              width: AppSizes.splashProgressWidth,
              height: AppSizes.borderThin,
              child: ClipRect(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ColoredBox(
                      color: AppColors.coverTrack.withValues(alpha: 0.22),
                    ),
                    if (waiting)
                      Align(
                        alignment: Alignment(alignX, 0),
                        child: const FractionallySizedBox(
                          widthFactor: segment,
                          child: ColoredBox(color: AppColors.coverAccent),
                        ),
                      )
                    else
                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: FractionallySizedBox(
                          widthFactor: progress.clamp(0.0, 1.0),
                          child: const ColoredBox(color: AppColors.coverAccent),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Text(isRtl ? text : text.toUpperCase(), style: style),
          ],
        ),
      ),
    );
  }
}
