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
    this.backgroundColor,
    this.borderRadius,
    this.borderColor,
    this.borderWidth,
    this.padding,
    this.elevation,
    this.shadowColor,
    this.hoverColor,
    this.focusColor,
    this.highlightColor,
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

  /// Optional background color.
  final Color? backgroundColor;

  /// Optional border radius.
  final double? borderRadius;

  /// Optional border color.
  final Color? borderColor;

  /// Optional border width.
  final double? borderWidth;

  /// Optional padding.
  final EdgeInsetsGeometry? padding;

  /// Optional elevation.
  final double? elevation;

  /// Optional shadow color.
  final Color? shadowColor;

  /// Optional hover color.
  final Color? hoverColor;

  /// Optional focus color.
  final Color? focusColor;

  /// Optional highlight color.
  final Color? highlightColor;

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
          hoverColor: hoverColor,
          focusColor: focusColor,
          highlightColor: highlightColor,
          style: IconButton.styleFrom(
            backgroundColor: backgroundColor,
            padding: padding,
            elevation: elevation,
            shadowColor: shadowColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 8),
              side: borderColor != null
                  ? BorderSide(color: borderColor!, width: borderWidth ?? 1)
                  : BorderSide.none,
            ),
          ),
        );
        break;

      case AppIconButtonVariant.filled:
        button = IconButton.filled(
          icon: Icon(icon, size: size),
          onPressed: effectiveOnPressed,
          tooltip: tooltip,
          hoverColor: hoverColor,
          focusColor: focusColor,
          highlightColor: highlightColor,
          style: IconButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: color,
            padding: padding,
            elevation: elevation,
            shadowColor: shadowColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 8),
              side: borderColor != null
                  ? BorderSide(color: borderColor!, width: borderWidth ?? 1)
                  : BorderSide.none,
            ),
          ),
        );
        break;

      case AppIconButtonVariant.tonal:
        button = IconButton.filledTonal(
          icon: Icon(icon, size: size),
          onPressed: effectiveOnPressed,
          tooltip: tooltip,
          hoverColor: hoverColor,
          focusColor: focusColor,
          highlightColor: highlightColor,
          style: IconButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: color,
            padding: padding,
            elevation: elevation,
            shadowColor: shadowColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 8),
              side: borderColor != null
                  ? BorderSide(color: borderColor!, width: borderWidth ?? 1)
                  : BorderSide.none,
            ),
          ),
        );
        break;

      case AppIconButtonVariant.outlined:
        button = IconButton.outlined(
          icon: Icon(icon, size: size),
          onPressed: effectiveOnPressed,
          tooltip: tooltip,
          hoverColor: hoverColor,
          focusColor: focusColor,
          highlightColor: highlightColor,
          style: IconButton.styleFrom(
            side: BorderSide(
              color: borderColor ?? backgroundColor ?? Colors.transparent,
              width: borderWidth ?? 1,
            ),
            foregroundColor: color,
            padding: padding,
            elevation: elevation,
            shadowColor: shadowColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 8),
            ),
          ),
        );
        break;
    }

    return button;
  }
}
