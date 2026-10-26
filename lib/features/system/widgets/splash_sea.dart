import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_wave_path.dart';

/// Three layers of swell in the brand teals with a thin gold waterline on top.
/// [phase] (0 → 1) loops the swell.
class SplashSea extends StatelessWidget {
  const SplashSea({super.key, required this.phase});

  final double phase;

  @override
  Widget build(BuildContext context) =>
      CustomPaint(painter: _SeaPainter(phase * 2 * math.pi));
}

class _SeaPainter extends CustomPainter {
  _SeaPainter(this.phase);

  final double phase;

  // (crest as a share of the box, amplitude, wavelength, colour, speed)
  static final _layers = <(double, double, double, Color, double)>[
    (0.18, 7, 260, AppColors.coverSea.withValues(alpha: 0.20), 1),
    (0.42, 9, 340, AppColors.coverSea.withValues(alpha: 0.28), -1),
    (0.66, 11, 420, AppColors.coverSeaDeep.withValues(alpha: 0.85), 1),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    for (var i = 0; i < _layers.length; i++) {
      final (share, amplitude, wavelength, colour, speed) = _layers[i];
      final crest = size.height * share;
      final wavePhase = phase * speed + i;
      canvas.drawPath(
        AppWavePath.body(
          size,
          crest: crest,
          amplitude: amplitude,
          wavelength: wavelength,
          phase: wavePhase,
        ),
        Paint()..color = colour,
      );
      if (i == 0) {
        // Gold waterline along the first crest, fading out at both ends.
        canvas.drawPath(
          AppWavePath.line(
            size,
            crest: crest,
            amplitude: amplitude,
            wavelength: wavelength,
            phase: wavePhase,
          ),
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1
            ..shader = LinearGradient(
              colors: [
                AppColors.coverAccent.withValues(alpha: 0),
                AppColors.coverAccent,
                AppColors.coverAccent.withValues(alpha: 0),
              ],
            ).createShader(Offset.zero & size),
        );
      }
    }
  }

  @override
  bool shouldRepaint(_SeaPainter oldDelegate) => oldDelegate.phase != phase;
}
