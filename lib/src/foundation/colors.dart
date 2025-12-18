import 'package:flutter/material.dart';

/// App color definitions following Material 3 principles.
/// Neutral, scalable, and reusable across multiple apps.
abstract class AppColors {
  // =======================
  // PRIMARY (Brand)
  // =======================
  static const Color primary = Color(0xFF1A73E8); // Blue 600
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFFD2E3FC); // Blue 100
  static const Color onPrimaryContainer = Color(0xFF041E49); // Blue 900

  // =======================
  // SECONDARY (Accent)
  // =======================
  static const Color secondary = Color(0xFF018786); // Teal 700
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFFB2DFDB); // Teal 100
  static const Color onSecondaryContainer = Color(0xFF00201F);

  // =======================
  // TERTIARY (Optional Accent)
  // =======================
  static const Color tertiary = Color(0xFF6750A4); // Indigo / Purple
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color tertiaryContainer = Color(0xFFEADDFF);
  static const Color onTertiaryContainer = Color(0xFF21005D);

  // =======================
  // ERROR
  // =======================
  static const Color error = Color(0xFFB3261E);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFF9DEDC);
  static const Color onErrorContainer = Color(0xFF410E0B);

  // =======================
  // NEUTRAL — LIGHT THEME
  // =======================
  static const Color backgroundLight = Color(0xFFFAFAFA);
  static const Color onBackgroundLight = Color(0xFF1F1F1F);

  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color onSurfaceLight = Color(0xFF1F1F1F);

  static const Color surfaceVariantLight = Color(0xFFE5E7EB); // Gray 200
  static const Color onSurfaceVariantLight = Color(0xFF4B5563); // Gray 600

  static const Color outlineLight = Color(0xFF9CA3AF); // Gray 400

  // =======================
  // NEUTRAL — DARK THEME
  // =======================
  static const Color backgroundDark = Color(0xFF121212);
  static const Color onBackgroundDark = Color(0xFFE5E7EB);

  static const Color surfaceDark = Color(0xFF1E1E1E);
  static const Color onSurfaceDark = Color(0xFFE6E1E5);

  static const Color surfaceVariantDark = Color(0xFF2C2C2C);
  static const Color onSurfaceVariantDark = Color(0xFFCAC4D0);

  static const Color outlineDark = Color(0xFF938F99);

  // =======================
  // SEMANTIC COLORS (Extensions)
  // =======================
  // Success
  static const Color success = Color(0xFF2E7D32); // Green 800
  static const Color onSuccess = Color(0xFFFFFFFF);
  static const Color successContainer = Color(0xFFA5D6A7); // Green 200
  static const Color onSuccessContainer = Color(0xFF1B5E20); // Green 900

  // Warning
  static const Color warning = Color(0xFFF57C00); // Orange 700
  static const Color onWarning = Color(0xFFFFFFFF);
  static const Color warningContainer = Color(0xFFFFCC80); // Orange 200
  static const Color onWarningContainer = Color(0xFFE65100); // Orange 900

  // Info
  static const Color info = Color(0xFF0288D1); // Light Blue 700
  static const Color onInfo = Color(0xFFFFFFFF);
  static const Color infoContainer = Color(0xFF81D4FA); // Light Blue 200
  static const Color onInfoContainer = Color(0xFF01579B); // Light Blue 900

  // =======================
  // EXTENDED MATERIAL 3 ROLES
  // =======================
  static const Color shadow = Color(0xFF000000);
  static const Color scrim = Color(0xFF000000);
  static const Color inverseSurface = Color(0xFF313033);
  static const Color onInverseSurface = Color(0xFFF4EFF4);
  static const Color inversePrimary = Color(
    0xFF8AB4F8,
  ); // Lighter Blue for Dark Mode / Inverse

  // Surface Containers (Light)
  static const Color surfaceContainerLowestLight = Color(0xFFFFFFFF);
  static const Color surfaceContainerLowLight = Color(0xFFF7F2FA);
  static const Color surfaceContainerHighLight = Color(0xFFECE6F0);
  static const Color surfaceContainerHighestLight = Color(0xFFE6E0E9);

  // Surface Containers (Dark)
  static const Color surfaceContainerLowestDark = Color(0xFF0F0D13);
  static const Color surfaceContainerLowDark = Color(0xFF1D1B20);
  static const Color surfaceContainerHighDark = Color(0xFF2B2930);
  static const Color surfaceContainerHighestDark = Color(0xFF36343B);

  // =======================
  // GENERAL UTILITIES
  // =======================
  static const Color transparent = Color(0x00000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  // =======================
  // INTERACTION STATES (Overlays)
  // Typically applied with alpha on top of a surface or primary color
  // =======================
  static const Color hoverOverlay = Color(0x14000000); // 8% Black
  static const Color focusOverlay = Color(0x1F000000); // 12% Black
  static const Color pressedOverlay = Color(0x1F000000); // 12% Black

  // Dark mode counterparts usually use white overlays
  static const Color hoverOverlayDark = Color(0x14FFFFFF); // 8% White
  static const Color focusOverlayDark = Color(0x1FFFFFFF); // 12% White
  static const Color pressedOverlayDark = Color(0x1FFFFFFF); // 12% White

  // =======================
  // PRIMARY PALETTE (Optional manual shades)
  // =======================
  static const Color primary50 = Color(0xFFEFF4FF);
  static const Color primary100 = Color(0xFFD6E4FF);
  static const Color primary200 = Color(0xFFADC8FF);
}
