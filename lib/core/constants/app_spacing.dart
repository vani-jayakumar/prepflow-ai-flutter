import 'package:flutter/material.dart';

class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;

  // Vertical Spacers
  static const SizedBox vXS = SizedBox(height: xs);
  static const SizedBox vSM = SizedBox(height: sm);
  static const SizedBox vMD = SizedBox(height: md);
  static const SizedBox vLG = SizedBox(height: lg);
  static const SizedBox vXL = SizedBox(height: xl);

  // Horizontal Spacers
  static const SizedBox hXS = SizedBox(width: xs);
  static const SizedBox hSM = SizedBox(width: sm);
  static const SizedBox hMD = SizedBox(width: md);
  static const SizedBox hLG = SizedBox(width: lg);
  static const SizedBox hXL = SizedBox(width: xl);
}
