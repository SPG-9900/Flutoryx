import 'package:flutter/material.dart';

/// Defines the typography scale for the application (Material 3) with adaptive sizing.
abstract class AppTypography {
  static const String fontFamily = 'Mulish';
  static const String packageName = 'flutoryx';

  /// Adaptive method to scale font sizes based on screen width
  static double adaptiveSize(
    BuildContext context,
    double mobile,
    double tablet,
    double desktop,
  ) {
    final mediaQuery = MediaQuery.maybeOf(context);
    if (mediaQuery == null) return mobile;

    final width = mediaQuery.size.width;
    if (width >= 1024) return desktop;
    if (width >= 600) return tablet;
    return mobile;
  }

  // =======================
  // DISPLAY
  // =======================
  static TextStyle displayLarge(BuildContext context) => TextStyle(
    fontFamily: fontFamily,
    package: packageName,
    fontSize: adaptiveSize(context, 36, 45, 57),
    height: adaptiveSize(context, 44 / 36, 52 / 45, 64 / 57),
    letterSpacing: -0.25,
    fontWeight: FontWeight.w400,
  );

  static TextStyle displayMedium(BuildContext context) => TextStyle(
    fontFamily: fontFamily,
    package: packageName,
    fontSize: adaptiveSize(context, 28, 36, 45),
    height: adaptiveSize(context, 36 / 28, 44 / 36, 52 / 45),
    fontWeight: FontWeight.w400,
  );

  static TextStyle displaySmall(BuildContext context) => TextStyle(
    fontFamily: fontFamily,
    package: packageName,
    fontSize: adaptiveSize(context, 24, 32, 36),
    height: adaptiveSize(context, 32 / 24, 40 / 32, 44 / 36),
    fontWeight: FontWeight.w400,
  );

  // =======================
  // HEADLINES
  // =======================
  static TextStyle headlineLarge(BuildContext context) => TextStyle(
    fontFamily: fontFamily,
    package: packageName,
    fontSize: adaptiveSize(context, 24, 28, 32),
    height: adaptiveSize(context, 32 / 24, 36 / 28, 40 / 32),
    fontWeight: FontWeight.w400,
  );

  static TextStyle headlineMedium(BuildContext context) => TextStyle(
    fontFamily: fontFamily,
    package: packageName,
    fontSize: adaptiveSize(context, 20, 24, 28),
    height: adaptiveSize(context, 28 / 20, 32 / 24, 36 / 28),
    fontWeight: FontWeight.w400,
  );

  static TextStyle headlineSmall(BuildContext context) => TextStyle(
    fontFamily: fontFamily,
    package: packageName,
    fontSize: adaptiveSize(context, 18, 20, 24),
    height: adaptiveSize(context, 24 / 18, 28 / 20, 32 / 24),
    fontWeight: FontWeight.w400,
  );

  // =======================
  // TITLES
  // =======================
  static TextStyle titleLarge(BuildContext context) => TextStyle(
    fontFamily: fontFamily,
    package: packageName,
    fontSize: adaptiveSize(context, 16, 18, 22),
    height: adaptiveSize(context, 24 / 16, 28 / 18, 28 / 22),
    fontWeight: FontWeight.w400,
  );

  static TextStyle titleMedium(BuildContext context) => TextStyle(
    fontFamily: fontFamily,
    package: packageName,
    fontSize: adaptiveSize(context, 14, 16, 16),
    height: adaptiveSize(context, 20 / 14, 24 / 16, 24 / 16),
    letterSpacing: 0.15,
    fontWeight: FontWeight.w500,
  );

  static TextStyle titleSmall(BuildContext context) => TextStyle(
    fontFamily: fontFamily,
    package: packageName,
    fontSize: adaptiveSize(context, 12, 14, 14),
    height: adaptiveSize(context, 16 / 12, 20 / 14, 20 / 14),
    letterSpacing: 0.1,
    fontWeight: FontWeight.w500,
  );

  // =======================
  // BODY
  // =======================
  static TextStyle bodyLarge(BuildContext context) => TextStyle(
    fontFamily: fontFamily,
    package: packageName,
    fontSize: adaptiveSize(context, 14, 16, 16),
    height: adaptiveSize(context, 20 / 14, 24 / 16, 24 / 16),
    letterSpacing: 0.5,
    fontWeight: FontWeight.w400,
  );

  static TextStyle bodyMedium(BuildContext context) => TextStyle(
    fontFamily: fontFamily,
    package: packageName,
    fontSize: adaptiveSize(context, 12, 14, 14),
    height: adaptiveSize(context, 16 / 12, 20 / 14, 20 / 14),
    letterSpacing: 0.25,
    fontWeight: FontWeight.w400,
  );

  static TextStyle bodySmall(BuildContext context) => TextStyle(
    fontFamily: fontFamily,
    package: packageName,
    fontSize: adaptiveSize(context, 10, 12, 12),
    height: adaptiveSize(context, 16 / 10, 16 / 12, 16 / 12),
    letterSpacing: 0.4,
    fontWeight: FontWeight.w400,
  );

  // =======================
  // LABELS
  // =======================
  static TextStyle labelLarge(BuildContext context) => TextStyle(
    fontFamily: fontFamily,
    package: packageName,
    fontSize: adaptiveSize(context, 12, 14, 14),
    height: adaptiveSize(context, 16 / 12, 20 / 14, 20 / 14),
    letterSpacing: 0.1,
    fontWeight: FontWeight.w500,
  );

  static TextStyle labelMedium(BuildContext context) => TextStyle(
    fontFamily: fontFamily,
    package: packageName,
    fontSize: adaptiveSize(context, 10, 12, 12),
    height: adaptiveSize(context, 16 / 10, 16 / 12, 16 / 12),
    letterSpacing: 0.5,
    fontWeight: FontWeight.w500,
  );

  static TextStyle labelSmall(BuildContext context) => TextStyle(
    fontFamily: fontFamily,
    package: packageName,
    fontSize: adaptiveSize(context, 10, 10, 11),
    height: adaptiveSize(context, 16 / 10, 16 / 10, 16 / 11),
    letterSpacing: 0.5,
    fontWeight: FontWeight.w500,
  );

  /// Returns the [TextStyle] for a given [AppTextVariant].
  static TextStyle getStyle(BuildContext context, AppTextVariant variant) {
    switch (variant) {
      case AppTextVariant.displayLarge:
        return displayLarge(context);
      case AppTextVariant.displayMedium:
        return displayMedium(context);
      case AppTextVariant.displaySmall:
        return displaySmall(context);
      case AppTextVariant.headlineLarge:
        return headlineLarge(context);
      case AppTextVariant.headlineMedium:
        return headlineMedium(context);
      case AppTextVariant.headlineSmall:
        return headlineSmall(context);
      case AppTextVariant.titleLarge:
        return titleLarge(context);
      case AppTextVariant.titleMedium:
        return titleMedium(context);
      case AppTextVariant.titleSmall:
        return titleSmall(context);
      case AppTextVariant.bodyLarge:
        return bodyLarge(context);
      case AppTextVariant.bodyMedium:
        return bodyMedium(context);
      case AppTextVariant.bodySmall:
        return bodySmall(context);
      case AppTextVariant.labelLarge:
        return labelLarge(context);
      case AppTextVariant.labelMedium:
        return labelMedium(context);
      case AppTextVariant.labelSmall:
        return labelSmall(context);
    }
  }
}

/// Defines the typography scale variants.
enum AppTextVariant {
  /// Display Large: 36/45/57
  displayLarge,

  /// Display Medium: 28/36/45
  displayMedium,

  /// Display Small: 24/32/36
  displaySmall,

  /// Headline Large: 24/28/32
  headlineLarge,

  /// Headline Medium: 20/24/28
  headlineMedium,

  /// Headline Small: 18/20/24
  headlineSmall,

  /// Title Large: 16/18/22
  titleLarge,

  /// Title Medium: 14/16/16
  titleMedium,

  /// Title Small: 12/14/14
  titleSmall,

  /// Body Large: 14/16/16
  bodyLarge,

  /// Body Medium: 12/14/14
  bodyMedium,

  /// Body Small: 10/12/12
  bodySmall,

  /// Label Large: 12/14/14
  labelLarge,

  /// Label Medium: 10/12/12
  labelMedium,

  /// Label Small: 10/10/11
  labelSmall,
}
