import 'package:flutter/material.dart';

enum AppButtonVariant { primary, secondary, outline, ghost, danger }

/// A wrapper button component that supports multiple variants.
class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final IconData? icon;
  final bool isLoading;
  final bool fullWidth;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? borderRadius;
  final EdgeInsets? padding;
  final TextStyle? textStyle;
  final double? elevation;
  final Color? shadowColor;
  final Color? borderColor;
  final double? borderWidth;
  final double? iconSize;
  final Size? minimumSize;
  final Size? maximumSize;

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.icon,
    this.isLoading = false,
    this.fullWidth = false,
    this.backgroundColor,
    this.foregroundColor,
    this.borderRadius,
    this.padding,
    this.textStyle,
    this.elevation,
    this.shadowColor,
    this.borderColor,
    this.borderWidth,
    this.iconSize,
    this.minimumSize,
    this.maximumSize,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    Widget button;

    switch (variant) {
      case AppButtonVariant.primary:
        button = FilledButton.icon(
          onPressed: isLoading ? null : onPressed,
          icon: _buildIcon(foregroundColor ?? colorScheme.onPrimary),
          label: Text(label, style: textStyle),
          style: FilledButton.styleFrom(
            backgroundColor: backgroundColor ?? colorScheme.primary,
            foregroundColor: foregroundColor ?? colorScheme.onPrimary,
            padding: padding,
            elevation: elevation,
            shadowColor: shadowColor,
            minimumSize: minimumSize,
            maximumSize: maximumSize,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 8),
              side: borderColor != null
                  ? BorderSide(color: borderColor!, width: borderWidth ?? 1)
                  : BorderSide.none,
            ),
          ),
        );
        break;
      case AppButtonVariant.secondary:
        button = FilledButton.icon(
          onPressed: isLoading ? null : onPressed,
          icon: _buildIcon(foregroundColor ?? colorScheme.onSecondaryContainer),
          label: Text(label, style: textStyle),
          style: FilledButton.styleFrom(
            backgroundColor: backgroundColor ?? colorScheme.secondaryContainer,
            foregroundColor:
                foregroundColor ?? colorScheme.onSecondaryContainer,
            padding: padding,
            elevation: elevation,
            shadowColor: shadowColor,
            minimumSize: minimumSize,
            maximumSize: maximumSize,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 8),
              side: borderColor != null
                  ? BorderSide(color: borderColor!, width: borderWidth ?? 1)
                  : BorderSide.none,
            ),
          ),
        );
        break;
      case AppButtonVariant.outline:
        button = OutlinedButton.icon(
          onPressed: isLoading ? null : onPressed,
          icon: _buildIcon(foregroundColor ?? colorScheme.primary),
          label: Text(label, style: textStyle),
          style: OutlinedButton.styleFrom(
            foregroundColor: foregroundColor,
            padding: padding,
            elevation: elevation,
            shadowColor: shadowColor,
            minimumSize: minimumSize,
            maximumSize: maximumSize,
            side: BorderSide(
              color: borderColor ?? backgroundColor ?? colorScheme.outline,
              width: borderWidth ?? 1,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 8),
            ),
          ),
        );
        break;
      case AppButtonVariant.ghost:
        button = TextButton.icon(
          onPressed: isLoading ? null : onPressed,
          icon: _buildIcon(foregroundColor ?? colorScheme.primary),
          label: Text(label, style: textStyle),
          style: TextButton.styleFrom(
            foregroundColor: foregroundColor,
            padding: padding,
            elevation: elevation,
            shadowColor: shadowColor,
            minimumSize: minimumSize,
            maximumSize: maximumSize,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 8),
              side: borderColor != null
                  ? BorderSide(color: borderColor!, width: borderWidth ?? 1)
                  : BorderSide.none,
            ),
          ),
        );
        break;
      case AppButtonVariant.danger:
        button = FilledButton.icon(
          onPressed: isLoading ? null : onPressed,
          icon: _buildIcon(foregroundColor ?? colorScheme.onError),
          label: Text(label, style: textStyle),
          style: FilledButton.styleFrom(
            backgroundColor: backgroundColor ?? colorScheme.error,
            foregroundColor: foregroundColor ?? colorScheme.onError,
            padding: padding,
            elevation: elevation,
            shadowColor: shadowColor,
            minimumSize: minimumSize,
            maximumSize: maximumSize,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 8),
              side: borderColor != null
                  ? BorderSide(color: borderColor!, width: borderWidth ?? 1)
                  : BorderSide.none,
            ),
          ),
        );
        break;
    }

    if (fullWidth) {
      return SizedBox(width: double.infinity, child: button);
    }
    return button;
  }

  Widget _buildIcon(Color color) {
    if (isLoading) {
      return SizedBox(
        width: 16,
        height: 16,
        child: CircularProgressIndicator(strokeWidth: 2, color: color),
      );
    }
    if (icon != null) {
      return Icon(icon, size: iconSize);
    }
    return const SizedBox.shrink();
  }
}
