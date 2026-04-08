import 'package:flutter/material.dart';

class SplashOrb extends StatelessWidget {
  final List<Color> colors;
  final double size;
  final double opacity;

  const SplashOrb({
    super.key,
    required this.colors,
    required this.size,
    required this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(colors: colors),
        ),
      ),
    );
  }
}
