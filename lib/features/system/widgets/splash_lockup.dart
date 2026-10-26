import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

/// Eased progress of the part of the splash timeline between [a] and [b]
/// seconds.
typedef SplashProgress = double Function(double a, double b, [Curve curve]);

/// The reversed ATLANTECH lockup, assembled from its parts at the proportions
/// of the original artwork (1047 × 675 px) so it is never distorted.
///
/// The symbol rises out of the waterline, the letters track in from the
/// centre, the "Intelligent Port Operations" line opens from the centre and a
/// gold glint crosses the artwork.
class SplashLockup extends StatelessWidget {
  const SplashLockup({super.key, required this.width, required this.p});

  static const String _dir = 'assets/images/brand';

  final double width;
  final SplashProgress p;

  static const double _w = 1047, _h = 675;
  static const Rect _symbol = Rect.fromLTRB(164, 0, 871, 484);
  static const Rect _tagline = Rect.fromLTRB(2, 647, 1044, 675);
  static const double _wordTop = 522, _wordBottom = 612;
  static const List<(double, double)> _letters = [
    (0, 125), (125, 222), (241, 328), (344, 467), (488, 593), //
    (612, 709), (727, 817), (833, 932), (949, 1047),
  ];

  @override
  Widget build(BuildContext context) {
    final k = width / _w;
    final symbolIn = p(0.2, 1.5, Curves.easeOutCubic);
    final track = p(1.0, 2.6, Curves.easeOutCubic);
    final tagIn = p(1.9, 2.8, Curves.easeInOutExpo);
    final glint = p(2.55, 3.35, Curves.easeInOut);
    final wordH = (_wordBottom - _wordTop) * k;

    Rect scaled(Rect a) =>
        Rect.fromLTRB(a.left * k, a.top * k, a.right * k, a.bottom * k);

    final letters = <Widget>[];
    for (var i = 0; i < _letters.length; i++) {
      final (start, end) = _letters[i];
      final centre = (start + end) / 2;
      // Letters rise from the centre outwards.
      final order = (i - (_letters.length - 1) / 2).abs();
      final rise = p(
        1.0 + order * 0.06,
        1.9 + order * 0.06,
        Curves.easeOutQuart,
      );
      final spread = (centre - _w / 2) * 0.35 * k * (1 - track);
      letters.add(
        Positioned(
          left: start * k,
          top: 0,
          width: (end - start) * k,
          height: wordH,
          child: Transform.translate(
            offset: Offset(spread, wordH * 1.15 * (1 - rise)),
            child: _part('letter_$i.png'),
          ),
        ),
      );
    }

    final lockup = SizedBox(
      width: width,
      height: _h * k,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fromRect(
            rect: scaled(_symbol),
            child: ClipRect(
              clipper: _RiseClipper(symbolIn),
              child: Transform.translate(
                offset: Offset(0, 24 * k * (1 - symbolIn)),
                child: _part('symbol.png'),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: _wordTop * k,
            height: wordH,
            child: ClipRect(
              clipper: const _BandClipper(),
              child: Stack(clipBehavior: Clip.none, children: letters),
            ),
          ),
          Positioned.fromRect(
            rect: scaled(_tagline),
            child: ClipRect(
              clipper: _CentreClipper(tagIn),
              child: _part('tagline.png'),
            ),
          ),
        ],
      ),
    );

    // The artwork reads left to right in both languages.
    final ltr = Directionality(
      textDirection: TextDirection.ltr,
      child: Semantics(label: 'ATLANTECH', image: true, child: lockup),
    );
    if (glint <= 0 || glint >= 1) return ltr;

    // A soft gold glint that only touches the artwork (srcATop keeps the
    // logo's own alpha).
    final s = -0.2 + 1.4 * glint;
    double c(double v) => v.clamp(0.0, 1.0);
    final shine = AppColors.coverAccent.withValues(alpha: 0.4);
    const clear = Color(0x00000000);
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [clear, clear, shine, clear, clear],
        stops: [0, c(s - 0.14), c(s), c(s + 0.14), 1],
      ).createShader(bounds),
      child: ltr,
    );
  }

  static Widget _part(String name) => Image.asset(
    '$_dir/$name',
    fit: BoxFit.fill,
    filterQuality: FilterQuality.medium,
    excludeFromSemantics: true,
  );
}

/// Reveals its child upwards from the bottom edge (the waterline).
class _RiseClipper extends CustomClipper<Rect> {
  const _RiseClipper(this.p);

  final double p;

  @override
  Rect getClip(Size size) => Rect.fromLTRB(
    -size.width,
    size.height * (1 - p),
    size.width * 2,
    size.height,
  );

  @override
  bool shouldReclip(_RiseClipper oldClipper) => oldClipper.p != p;
}

/// Clips only top and bottom, so letters can track in from beyond the sides.
class _BandClipper extends CustomClipper<Rect> {
  const _BandClipper();

  @override
  Rect getClip(Size size) =>
      Rect.fromLTRB(-size.width, 0, size.width * 2, size.height);

  @override
  bool shouldReclip(_BandClipper oldClipper) => false;
}

/// Opens its child from the centre outwards.
class _CentreClipper extends CustomClipper<Rect> {
  const _CentreClipper(this.p);

  final double p;

  @override
  Rect getClip(Size size) {
    final half = size.width / 2 * p;
    return Rect.fromLTRB(
      size.width / 2 - half,
      0,
      size.width / 2 + half,
      size.height,
    );
  }

  @override
  bool shouldReclip(_CentreClipper oldClipper) => oldClipper.p != p;
}
