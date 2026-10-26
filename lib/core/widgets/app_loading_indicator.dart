import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../localization/l10n/app_localizations.dart';
import '../theme/app_colors.dart';
import '../theme/app_sizes.dart';
import 'app_wave_path.dart';

/// The ATLANTECH symbol filling with water: the app's loading indicator.
///
/// Without [value] the tide rises and falls until the work is done. With a
/// [value] (0 → 1) the water level follows it, for work with a known
/// progress such as a sync. With "remove animations" on in the phone's
/// settings, the symbol shows half full and still.
class AppLoadingIndicator extends StatefulWidget {
  const AppLoadingIndicator({
    super.key,
    this.size = AppSizes.loadingLg,
    this.value,
  });

  /// Width of the symbol. Use [AppSizes.loadingLg], [AppSizes.loadingMd] or
  /// [AppSizes.loadingSm].
  final double size;

  /// Known progress, 0 → 1. Null means indeterminate.
  final double? value;

  @override
  State<AppLoadingIndicator> createState() => _AppLoadingIndicatorState();
}

class _AppLoadingIndicatorState extends State<AppLoadingIndicator>
    with TickerProviderStateMixin {
  static const String _symbol = 'assets/images/brand/symbol.png';

  /// Width / height of the symbol artwork (707 × 484 px).
  static const double _aspect = 707 / 484;

  // Lowest and highest tide while indeterminate.
  static const double _low = 0.12;
  static const double _high = 0.92;

  late final AnimationController _swell = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1600),
  );
  late final AnimationController _tide = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2600),
  );
  late final CurvedAnimation _tideCurve = CurvedAnimation(
    parent: _tide,
    curve: Curves.easeInOut,
  );

  /// Level the determinate water animates from.
  double _from = 0;
  late final AnimationController _level = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 450),
    value: 1,
  );

  bool _still = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _still = MediaQuery.disableAnimationsOf(context);
    if (_still) {
      _swell.stop();
      _tide.stop();
    } else {
      if (!_swell.isAnimating) _swell.repeat();
      if (widget.value == null && !_tide.isAnimating) {
        _tide.repeat(reverse: true);
      }
    }
  }

  @override
  void didUpdateWidget(AppLoadingIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _from = oldWidget.value ?? _currentTide;
      _level.forward(from: 0);
      if (widget.value == null && !_still) {
        _tide.repeat(reverse: true);
      } else {
        _tide.stop();
      }
    }
  }

  double get _currentTide => _low + (_high - _low) * _tideCurve.value;

  double get _waterLevel {
    if (_still) return widget.value ?? 0.5;
    final target = widget.value?.clamp(0.0, 1.0) ?? _currentTide;
    final t = Curves.easeOut.transform(_level.value);
    return _from + (target - _from) * t;
  }

  @override
  void dispose() {
    _tideCurve.dispose();
    _swell.dispose();
    _tide.dispose();
    _level.dispose();
    super.dispose();
  }

  Widget _tinted(Color color) => Image.asset(
    _symbol,
    width: widget.size,
    height: widget.size / _aspect,
    fit: BoxFit.fill,
    color: color,
    colorBlendMode: BlendMode.srcIn,
    filterQuality: FilterQuality.medium,
    excludeFromSemantics: true,
  );

  @override
  Widget build(BuildContext context) {
    final value = widget.value;
    return Semantics(
      label: AppLocalizations.of(context).loading,
      value: value == null ? null : '${(value * 100).round()}%',
      child: RepaintBoundary(
        child: AnimatedBuilder(
          animation: Listenable.merge([_swell, _tide, _level]),
          builder: (context, _) {
            final level = _waterLevel;
            final phase = _swell.value * 2 * math.pi;
            return Stack(
              children: [
                _tinted(AppColors.loadingEmpty),
                ClipPath(
                  clipper: _WaterClipper(
                    level: level + 0.04,
                    phase: -phase + 1.3,
                  ),
                  child: _tinted(AppColors.loadingWaterBack),
                ),
                ClipPath(
                  clipper: _WaterClipper(level: level, phase: phase),
                  child: _tinted(AppColors.loadingWater),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// Keeps the part of the symbol under the water line. [level] 0 is empty,
/// 1 is full.
class _WaterClipper extends CustomClipper<Path> {
  const _WaterClipper({required this.level, required this.phase});

  final double level;
  final double phase;

  @override
  Path getClip(Size size) {
    // The swell flattens near empty and full so the ends look calm.
    final calm = math.sin(level.clamp(0.0, 1.0) * math.pi);
    final amplitude = size.height * 0.045 * (0.35 + 0.65 * calm);
    // Overfill a little so 1.0 covers the crests too.
    final crest = size.height * (1 - level) - amplitude * (level >= 1 ? 2 : 0);
    return AppWavePath.body(
      size,
      crest: crest,
      amplitude: amplitude,
      wavelength: size.width * 0.75,
      phase: phase,
    );
  }

  @override
  bool shouldReclip(_WaterClipper oldClipper) =>
      oldClipper.level != level || oldClipper.phase != phase;
}
