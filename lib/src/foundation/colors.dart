import 'package:flutter/material.dart';

/// App color definitions following Material 3 principles.
/// Neutral, scalable, and reusable across multiple apps.
abstract class AppColors {
  // =======================
  // PRIMARY (Brand)
  // =======================
  static const Color primary = Color(0xFF2563EB); // Blue 600
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFFDBEAFE); // Blue 100
  static const Color onPrimaryContainer = Color(0xFF1E40AF); // Blue 800

  // =======================
  // SECONDARY (Accent)
  // =======================
  static const Color secondary = Color(0xFF64748B); // Slate 500
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFFF1F5F9); // Slate 100
  static const Color onSecondaryContainer = Color(0xFF1E293B); // Slate 800

  // =======================
  // TERTIARY (Optional Accent)
  // =======================
  static const Color tertiary = Color(0xFF0891B2); // Cyan 600
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color tertiaryContainer = Color(0xFFCFFAFE); // Cyan 100
  static const Color onTertiaryContainer = Color(0xFF155E75); // Cyan 800

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
  static const Color success = emerald600;
  static const Color onSuccess = white;
  static const Color successContainer = emerald100;
  static const Color onSuccessContainer = emerald900;

  // Warning
  static const Color warning = amber600;
  static const Color onWarning = white;
  static const Color warningContainer = amber100;
  static const Color onWarningContainer = amber900;

  // Info
  static const Color info = sky600;
  static const Color onInfo = white;
  static const Color infoContainer = sky100;
  static const Color onInfoContainer = sky900;

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
  // PRIMARY PALETTE (Modern Blue)
  // =======================
  static const Color primary50 = Color(0xFFEFF6FF);
  static const Color primary100 = Color(0xFFDBEAFE);
  static const Color primary200 = Color(0xFFBFDBFE);
  static const Color primary300 = Color(0xFF93C5FD);
  static const Color primary400 = Color(0xFF60A5FA);
  static const Color primary500 = Color(0xFF3B82F6);
  static const Color primary600 = primary;
  static const Color primary700 = Color(0xFF1D4ED8);
  static const Color primary800 = Color(0xFF1E40AF);
  static const Color primary900 = Color(0xFF1E3A8A);

  // =======================
  // SECONDARY PALETTE (Slate)
  // =======================
  static const Color secondary50 = Color(0xFFF8FAFC);
  static const Color secondary100 = Color(0xFFF1F5F9);
  static const Color secondary200 = Color(0xFFE2E8F0);
  static const Color secondary300 = Color(0xFFCBD5E1);
  static const Color secondary400 = Color(0xFF94A3B8);
  static const Color secondary500 = secondary;
  static const Color secondary600 = Color(0xFF475569);
  static const Color secondary700 = Color(0xFF334155);
  static const Color secondary800 = Color(0xFF1E293B);
  static const Color secondary900 = Color(0xFF0F172A);

  // Slate Palette
  static const Color slate50 = Color(0xFFF8FAFC);
  static const Color slate100 = Color(0xFFF1F5F9);
  static const Color slate200 = Color(0xFFE2E8F0);
  static const Color slate300 = Color(0xFFCBD5E1);
  static const Color slate400 = Color(0xFF94A3B8);
  static const Color slate500 = Color(0xFF64748B);
  static const Color slate600 = Color(0xFF475569);
  static const Color slate700 = Color(0xFF334155);
  static const Color slate800 = Color(0xFF1E293B);
  static const Color slate900 = Color(0xFF0F172A);

  // =======================
  // TERTIARY PALETTE (Cyan)
  // =======================
  static const Color tertiary50 = Color(0xFFECFEFF);
  static const Color tertiary100 = Color(0xFFCFFAFE);
  static const Color tertiary200 = Color(0xFFA5F3FC);
  static const Color tertiary300 = Color(0xFF67E8F9);
  static const Color tertiary400 = Color(0xFF22D3EE);
  static const Color tertiary500 = Color(0xFF06B6D4);
  static const Color tertiary600 = tertiary;
  static const Color tertiary700 = Color(0xFF0E7490);
  static const Color tertiary800 = Color(0xFF155E75);
  static const Color tertiary900 = Color(0xFF164E63);

  // =======================
  // STANDARD COLORS (Modern 50-900)
  // =======================

  // Red
  static const Color red = Color(0xFFEF4444);
  static const Color red50 = Color(0xFFFEF2F2);
  static const Color red100 = Color(0xFFFEE2E2);
  static const Color red200 = Color(0xFFFECACA);
  static const Color red300 = Color(0xFFFCA5A5);
  static const Color red400 = Color(0xFFF87171);
  static const Color red500 = red;
  static const Color red600 = Color(0xFFDC2626);
  static const Color red700 = Color(0xFFB91C1C);
  static const Color red800 = Color(0xFF991B1B);
  static const Color red900 = Color(0xFF7F1D1D);

  // Green
  static const Color green = Color(0xFF22C55E);
  static const Color green50 = Color(0xFFF0FDF4);
  static const Color green100 = Color(0xFFDCFCE7);
  static const Color green200 = Color(0xFFBBF7D0);
  static const Color green300 = Color(0xFF86EFAC);
  static const Color green400 = Color(0xFF4ADE80);
  static const Color green500 = green;
  static const Color green600 = Color(0xFF16A34A);
  static const Color green700 = Color(0xFF15803D);
  static const Color green800 = Color(0xFF166534);
  static const Color green900 = Color(0xFF14532D);

  // Blue
  static const Color blue = Color(0xFF3B82F6);
  static const Color blue50 = Color(0xFFEFF6FF);
  static const Color blue100 = Color(0xFFDBEAFE);
  static const Color blue200 = Color(0xFFBFDBFE);
  static const Color blue300 = Color(0xFF93C5FD);
  static const Color blue400 = Color(0xFF60A5FA);
  static const Color blue500 = blue;
  static const Color blue600 = Color(0xFF2563EB);
  static const Color blue700 = Color(0xFF1D4ED8);
  static const Color blue800 = Color(0xFF1E40AF);
  static const Color blue900 = Color(0xFF1E3A8A);

  // Yellow
  static const Color yellow = Color(0xFFEAB308);
  static const Color yellow50 = Color(0xFFFEFCE8);
  static const Color yellow100 = Color(0xFFFEF9C3);
  static const Color yellow200 = Color(0xFFFEF08A);
  static const Color yellow300 = Color(0xFFFDE047);
  static const Color yellow400 = Color(0xFFFACC15);
  static const Color yellow500 = yellow;
  static const Color yellow600 = Color(0xFFCA8A04);
  static const Color yellow700 = Color(0xFFA16207);
  static const Color yellow800 = Color(0xFF854D0E);
  static const Color yellow900 = Color(0xFF713F12);

  // Orange
  static const Color orange = Color(0xFFF97316);
  static const Color orange50 = Color(0xFFFFF7ED);
  static const Color orange100 = Color(0xFFFFEDD5);
  static const Color orange200 = Color(0xFFFED7AA);
  static const Color orange300 = Color(0xFFFDBA8C);
  static const Color orange400 = Color(0xFFFB923C);
  static const Color orange500 = orange;
  static const Color orange600 = Color(0xFFEA580C);
  static const Color orange700 = Color(0xFFC2410C);
  static const Color orange800 = Color(0xFF9A3412);
  static const Color orange900 = Color(0xFF7C2D12);

  // Purple
  static const Color purple = Color(0xFFA855F7);
  static const Color purple50 = Color(0xFFFAF5FF);
  static const Color purple100 = Color(0xFFF3E8FF);
  static const Color purple200 = Color(0xFFE9D5FF);
  static const Color purple300 = Color(0xFFD8B4FE);
  static const Color purple400 = Color(0xFFC084FC);
  static const Color purple500 = purple;
  static const Color purple600 = Color(0xFF9333EA);
  static const Color purple700 = Color(0xFF7E22CE);
  static const Color purple800 = Color(0xFF6B21A8);
  static const Color purple900 = Color(0xFF581C87);

  // Pink
  static const Color pink = Color(0xFFEC4899);
  static const Color pink50 = Color(0xFFFDF2F8);
  static const Color pink100 = Color(0xFFFCE7F3);
  static const Color pink200 = Color(0xFFFBCFE8);
  static const Color pink300 = Color(0xFFF9A8D4);
  static const Color pink400 = Color(0xFFF472B6);
  static const Color pink500 = pink;
  static const Color pink600 = Color(0xFFDB2777);
  static const Color pink700 = Color(0xFFBE185D);
  static const Color pink800 = Color(0xFF9D174D);
  static const Color pink900 = Color(0xFF831843);

  // Indigo
  static const Color indigo = Color(0xFF6366F1);
  static const Color indigo50 = Color(0xFFEEF2FF);
  static const Color indigo100 = Color(0xFFE0E7FF);
  static const Color indigo200 = Color(0xFFC7D2FE);
  static const Color indigo300 = Color(0xFFA5B4FC);
  static const Color indigo400 = Color(0xFF818CF8);
  static const Color indigo500 = indigo;
  static const Color indigo600 = Color(0xFF4F46E5);
  static const Color indigo700 = Color(0xFF4338CA);
  static const Color indigo800 = Color(0xFF3730A3);
  static const Color indigo900 = Color(0xFF1E1B4B);

  // Amber
  static const Color amber = Color(0xFFF59E0B);
  static const Color amber50 = Color(0xFFFFFBEB);
  static const Color amber100 = Color(0xFFFEF3C7);
  static const Color amber200 = Color(0xFFFDE68A);
  static const Color amber300 = Color(0xFFFCD34D);
  static const Color amber400 = Color(0xFFFBBF24);
  static const Color amber500 = amber;
  static const Color amber600 = Color(0xFFD97706);
  static const Color amber700 = Color(0xFFB45309);
  static const Color amber800 = Color(0xFF92400E);
  static const Color amber900 = Color(0xFF78350F);

  // Emerald
  static const Color emerald = Color(0xFF10B981);
  static const Color emerald50 = Color(0xFFECFDF5);
  static const Color emerald100 = Color(0xFFD1FAE5);
  static const Color emerald200 = Color(0xFFA7F3D0);
  static const Color emerald300 = Color(0xFF6EE7B7);
  static const Color emerald400 = Color(0xFF34D399);
  static const Color emerald500 = emerald;
  static const Color emerald600 = Color(0xFF059669);
  static const Color emerald700 = Color(0xFF047857);
  static const Color emerald800 = Color(0xFF065F46);
  static const Color emerald900 = Color(0xFF064E3B);

  // Teal
  static const Color teal = Color(0xFF14B8A6);
  static const Color teal50 = Color(0xFFF0FDFA);
  static const Color teal100 = Color(0xFFCCFBF1);
  static const Color teal200 = Color(0xFF99F6E4);
  static const Color teal300 = Color(0xFF5EEAD4);
  static const Color teal400 = Color(0xFF2DD4BF);
  static const Color teal500 = teal;
  static const Color teal600 = Color(0xFF0D9488);
  static const Color teal700 = Color(0xFF0F766E);
  static const Color teal800 = Color(0xFF115E59);
  static const Color teal900 = Color(0xFF134E4A);

  // Lime
  static const Color lime = Color(0xFF84CC16);
  static const Color lime50 = Color(0xFFF7FEE7);
  static const Color lime100 = Color(0xFFECFCCB);
  static const Color lime200 = Color(0xFFD9F99D);
  static const Color lime300 = Color(0xFFBEF264);
  static const Color lime400 = Color(0xFFA3E635);
  static const Color lime500 = lime;
  static const Color lime600 = Color(0xFF65A30D);
  static const Color lime700 = Color(0xFF4D7C0F);
  static const Color lime800 = Color(0xFF3F6212);
  static const Color lime900 = Color(0xFF365314);

  // Fuchsia
  static const Color fuchsia = Color(0xFFD946EF);
  static const Color fuchsia50 = Color(0xFFFDF4FF);
  static const Color fuchsia100 = Color(0xFFFAE8FF);
  static const Color fuchsia200 = Color(0xFFF5D0FE);
  static const Color fuchsia300 = Color(0xFFF0ABFC);
  static const Color fuchsia400 = Color(0xFFE879F9);
  static const Color fuchsia500 = fuchsia;
  static const Color fuchsia600 = Color(0xFFC026D3);
  static const Color fuchsia700 = Color(0xFFA21CAF);
  static const Color fuchsia800 = Color(0xFF86198F);
  static const Color fuchsia900 = Color(0xFF701A75);

  // Violet
  static const Color violet = Color(0xFF8B5CF6);
  static const Color violet50 = Color(0xFFF5F3FF);
  static const Color violet100 = Color(0xFFEDE9FE);
  static const Color violet200 = Color(0xFFDDD6FE);
  static const Color violet300 = Color(0xFFC4B5FD);
  static const Color violet400 = Color(0xFFA78BFA);
  static const Color violet500 = violet;
  static const Color violet600 = Color(0xFF7C3AED);
  static const Color violet700 = Color(0xFF6D28D9);
  static const Color violet800 = Color(0xFF5B21B6);
  static const Color violet900 = Color(0xFF4C1D95);

  // Rose
  static const Color rose = Color(0xFFF43F5E);
  static const Color rose50 = Color(0xFFFFF1F2);
  static const Color rose100 = Color(0xFFFFE4E6);
  static const Color rose200 = Color(0xFFFECDD3);
  static const Color rose300 = Color(0xFFFDA4AF);
  static const Color rose400 = Color(0xFFFB7185);
  static const Color rose500 = rose;
  static const Color rose600 = Color(0xFFE11D48);
  static const Color rose700 = Color(0xFFBE123C);
  static const Color rose800 = Color(0xFF9F1239);
  static const Color rose900 = Color(0xFF881337);

  // Sky
  static const Color sky = Color(0xFF0EA5E9);
  static const Color sky50 = Color(0xFFF0F9FF);
  static const Color sky100 = Color(0xFFE0F2FE);
  static const Color sky200 = Color(0xFFBAE6FD);
  static const Color sky300 = Color(0xFF7DD3FC);
  static const Color sky400 = Color(0xFF38BDF8);
  static const Color sky500 = sky;
  static const Color sky600 = Color(0xFF0284C7);
  static const Color sky700 = Color(0xFF0369A1);
  static const Color sky800 = Color(0xFF075985);
  static const Color sky900 = Color(0xFF0C4A6E);

  // Grey
  static const Color grey = Color(0xFF71717A);
  static const Color grey50 = Color(0xFFFAFAFA);
  static const Color grey100 = Color(0xFFF4F4F5);
  static const Color grey200 = Color(0xFFE4E4E7);
  static const Color grey300 = Color(0xFFD4D4D8);
  static const Color grey400 = Color(0xFFA1A1AA);
  static const Color grey500 = grey;
  static const Color grey600 = Color(0xFF52525B);
  static const Color grey700 = Color(0xFF3F3F46);
  static const Color grey800 = Color(0xFF27272A);
  static const Color grey900 = Color(0xFF18181B);
}
