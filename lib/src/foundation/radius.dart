import 'package:flutter/material.dart';

/// Defines corner radii for shapes.
abstract class AppRadius {
  static const double xs = 4.0;
  static const double s = 8.0;
  static const double m = 12.0;
  static const double l = 16.0;
  static const double xl = 28.0;
  static const double full = 999.0;

  static const Radius radiusXs = Radius.circular(xs);
  static const Radius radiusS = Radius.circular(s);
  static const Radius radiusM = Radius.circular(m);
  static const Radius radiusL = Radius.circular(l);
  static const Radius radiusXl = Radius.circular(xl);
  static const Radius radiusFull = Radius.circular(full);

  static const BorderRadius roundedXs = BorderRadius.all(radiusXs);
  static const BorderRadius roundedS = BorderRadius.all(radiusS);
  static const BorderRadius roundedM = BorderRadius.all(radiusM);
  static const BorderRadius roundedL = BorderRadius.all(radiusL);
  static const BorderRadius roundedXl = BorderRadius.all(radiusXl);
  static const BorderRadius roundedFull = BorderRadius.all(radiusFull);
}
