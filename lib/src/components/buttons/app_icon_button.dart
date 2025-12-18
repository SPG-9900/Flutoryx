import 'package:flutter/material.dart';

/// Visual style variants for icon buttons.
enum AppIconButtonVariant {
  /// Standard icon button.
  standard,

  /// Filled icon button with background.
  filled,

  /// Tonal icon button with subtle background.
  tonal,

  /// Outlined icon button with border.
  outlined,
}

/// A Material Design icon button with multiple variants.
///
/// Provides a customizable icon button that integrates with the app theme
/// and supports different visual styles.
class AppIconButton extends StatelessWidget {
  /// Creates an icon button.
  const AppIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.variant = AppIconButtonVariant.standard,
    this.tooltip,
    this.size,
    this.color,
    this.enabled = true,
  });

  /// The icon to display.
  final IconData icon;

  /// Called when the button is pressed.
  final VoidCallback? onPressed;

  /// The visual style of the button.
  final AppIconButtonVariant variant;

  /// Optional tooltip text.
  final String? tooltip;

  /// The size of the icon.
  final double? size;

  /// The color of the icon.
  final Color? color;

  /// Whether the button is enabled.
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final effectiveOnPressed = enabled ? onPressed : null;

    Widget button;

    switch (variant) {
      case AppIconButtonVariant.standard:
        button = IconButton(
          icon: Icon(icon, size: size, color: color),
          onPressed: effectiveOnPressed,
          tooltip: tooltip,
        );
        break;

      case AppIconButtonVariant.filled:
        button = IconButton.filled(
          icon: Icon(icon, size: size),
          onPressed: effectiveOnPressed,
          tooltip: tooltip,
        );
        break;

      case AppIconButtonVariant.tonal:
        button = IconButton.filledTonal(
          icon: Icon(icon, size: size),
          onPressed: effectiveOnPressed,
          tooltip: tooltip,
        );
        break;

      case AppIconButtonVariant.outlined:
        button = IconButton.outlined(
          icon: Icon(icon, size: size),
          onPressed: effectiveOnPressed,
          tooltip: tooltip,
        );
        break;
    }

    return button;
  }
}
