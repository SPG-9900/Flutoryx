import 'package:flutter/material.dart';

/// Defines spacing constants for padding, margins, and gaps.
abstract class AppSpacing {
  static const double xxs = 2.0;
  static const double xs = 4.0;
  static const double s = 8.0;
  static const double m = 12.0;
  static const double l = 16.0;
  static const double xl = 24.0;
  static const double xxl = 32.0;

  static const double section = 48.0;

  // EdgeInsets helpers
  static const EdgeInsets edgeInsetsAllXxs = EdgeInsets.all(xxs);
  static const EdgeInsets edgeInsetsAllXs = EdgeInsets.all(xs);
  static const EdgeInsets edgeInsetsAllS = EdgeInsets.all(s);
  static const EdgeInsets edgeInsetsAllM = EdgeInsets.all(m);
  static const EdgeInsets edgeInsetsAllL = EdgeInsets.all(l);
  static const EdgeInsets edgeInsetsAllXl = EdgeInsets.all(xl);
}
