import 'package:flutter/material.dart';
import '../foundation/colors.dart';
import '../foundation/typography.dart';

/// Defines the light and dark themes for the application.
class AppTheme {
  // Prevent instantiation
  AppTheme._();

  static ThemeData light(BuildContext context) {
    final colorScheme = const ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      primaryContainer: AppColors.primaryContainer,
      onPrimaryContainer: AppColors.onPrimaryContainer,
      secondary: AppColors.secondary,
      onSecondary: AppColors.onSecondary,
      secondaryContainer: AppColors.secondaryContainer,
      onSecondaryContainer: AppColors.onSecondaryContainer,
      tertiary: AppColors.tertiary,
      onTertiary: AppColors.onTertiary,
      tertiaryContainer: AppColors.tertiaryContainer,
      onTertiaryContainer: AppColors.onTertiaryContainer,
      error: AppColors.error,
      onError: AppColors.onError,
      errorContainer: AppColors.errorContainer,
      onErrorContainer: AppColors.onErrorContainer,
      surface: AppColors.surfaceLight,
      onSurface: AppColors.onSurfaceLight,
      surfaceContainerHighest: AppColors.surfaceVariantLight,
      onSurfaceVariant: AppColors.onSurfaceVariantLight,
      outline: AppColors.outlineLight,
    );

    return _baseTheme(context, colorScheme);
  }

  static ThemeData dark(BuildContext context) {
    final colorScheme = const ColorScheme.dark(
      primary: AppColors.primary300,
      onPrimary: AppColors.primary900,
      primaryContainer: AppColors.primary800,
      onPrimaryContainer: AppColors.primary100,
      secondary: AppColors.secondary300,
      onSecondary: AppColors.secondary900,
      secondaryContainer: AppColors.secondary800,
      onSecondaryContainer: AppColors.secondary100,
      tertiary: AppColors.tertiary300,
      onTertiary: AppColors.tertiary900,
      tertiaryContainer: AppColors.tertiary800,
      onTertiaryContainer: AppColors.tertiary100,
      // Note: Real Material 3 dark theme usually swaps these colors.
      // For this sample, I'm mapping specific dark tokens if available or reusing.
      // Let's use the explicit dark colors defined in AppColors.

      // Override background/surface with dark variants
      surface: AppColors.surfaceDark,
      onSurface: AppColors.onSurfaceDark,
      surfaceContainerHighest: AppColors.surfaceVariantDark,
      onSurfaceVariant: AppColors.onSurfaceVariantDark,
      outline: AppColors.outlineDark,
    );
    // Correction: Material 3 dark mode usually has lighter primaries.
    // Since AppColors didn't define specific PrimaryDark, we will trust ColorScheme.fromSeed
    // or just use what we have. Let's stick to the manual mapping for full control
    // but acknowledge the tokens might need tweaking for a perfect M3 dark mode.
    // For now, mapping the keys provided in AppColors.

    return _baseTheme(context, colorScheme);
  }

  static ThemeData _baseTheme(BuildContext context, ColorScheme colorScheme) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      textTheme: TextTheme(
        displayLarge: AppTypography.displayLarge(
          context,
        ).copyWith(color: colorScheme.onSurface),
        displayMedium: AppTypography.displayMedium(
          context,
        ).copyWith(color: colorScheme.onSurface),
        displaySmall: AppTypography.displaySmall(
          context,
        ).copyWith(color: colorScheme.onSurface),
        headlineLarge: AppTypography.headlineLarge(
          context,
        ).copyWith(color: colorScheme.onSurface),
        headlineMedium: AppTypography.headlineMedium(
          context,
        ).copyWith(color: colorScheme.onSurface),
        headlineSmall: AppTypography.headlineSmall(
          context,
        ).copyWith(color: colorScheme.onSurface),
        titleLarge: AppTypography.titleLarge(
          context,
        ).copyWith(color: colorScheme.onSurface),
        titleMedium: AppTypography.titleMedium(
          context,
        ).copyWith(color: colorScheme.onSurface),
        titleSmall: AppTypography.titleSmall(
          context,
        ).copyWith(color: colorScheme.onSurface),
        bodyLarge: AppTypography.bodyLarge(
          context,
        ).copyWith(color: colorScheme.onSurface),
        bodyMedium: AppTypography.bodyMedium(
          context,
        ).copyWith(color: colorScheme.onSurface),
        bodySmall: AppTypography.bodySmall(
          context,
        ).copyWith(color: colorScheme.onSurface),
        labelLarge: AppTypography.labelLarge(
          context,
        ).copyWith(color: colorScheme.onSurface),
        labelMedium: AppTypography.labelMedium(
          context,
        ).copyWith(color: colorScheme.onSurface),
        labelSmall: AppTypography.labelSmall(
          context,
        ).copyWith(color: colorScheme.onSurface),
      ),
      // Add other global theme configurations here (ButtonTheme, AppBarTheme, etc.)
    );
  }
}
