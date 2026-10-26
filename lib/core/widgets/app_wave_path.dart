import 'dart:math' as math;

import 'package:flutter/painting.dart';

/// One swell line shared by the splash sea and the loading water, so both
/// move the same way.
///
/// [crest] is the line's mean height from the top of [size]. [amplitude] and
/// [wavelength] are in logical pixels; [phase] in radians moves the swell and
/// loops seamlessly every 2π.
abstract final class AppWavePath {
  static double crestAt(
    double x, {
    required double crest,
    required double amplitude,
    required double wavelength,
    required double phase,
  }) =>
      crest +
      amplitude * math.sin(x / wavelength * 2 * math.pi + phase) +
      amplitude *
          0.35 *
          math.sin(x / (wavelength * 0.47) * 2 * math.pi - phase * 2);

  /// The swell line across [size], from x = 0 to its width.
  static Path line(
    Size size, {
    required double crest,
    required double amplitude,
    required double wavelength,
    required double phase,
  }) {
    final step = math.max(2.0, size.width / 120);
    final path = Path();
    for (double x = 0; x <= size.width + step; x += step) {
      final y = crestAt(
        x,
        crest: crest,
        amplitude: amplitude,
        wavelength: wavelength,
        phase: phase,
      );
      x == 0 ? path.moveTo(x, y) : path.lineTo(x, y);
    }
    return path;
  }

  /// The water below the swell line, down to the bottom of [size].
  static Path body(
    Size size, {
    required double crest,
    required double amplitude,
    required double wavelength,
    required double phase,
  }) =>
      line(
          size,
          crest: crest,
          amplitude: amplitude,
          wavelength: wavelength,
          phase: phase,
        )
        ..lineTo(size.width, size.height)
        ..lineTo(0, size.height)
        ..close();
}
