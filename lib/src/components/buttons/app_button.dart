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

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.icon,
    this.isLoading = false,
    this.fullWidth = false,
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
          icon: _buildIcon(colorScheme.onPrimary),
          label: Text(label),
          style: FilledButton.styleFrom(
            backgroundColor: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
        break;
      case AppButtonVariant.secondary:
        button = FilledButton.icon(
          onPressed: isLoading ? null : onPressed,
          icon: _buildIcon(colorScheme.onSecondaryContainer),
          label: Text(label),
          style: FilledButton.styleFrom(
            backgroundColor: colorScheme.secondaryContainer,
            foregroundColor: colorScheme.onSecondaryContainer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
        break;
      case AppButtonVariant.outline:
        button = OutlinedButton.icon(
          onPressed: isLoading ? null : onPressed,
          icon: _buildIcon(colorScheme.primary),
          label: Text(label),
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: colorScheme.outline),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
        break;
      case AppButtonVariant.ghost:
        button = TextButton.icon(
          onPressed: isLoading ? null : onPressed,
          icon: _buildIcon(colorScheme.primary),
          label: Text(label),
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
        break;
      case AppButtonVariant.danger:
        button = FilledButton.icon(
          onPressed: isLoading ? null : onPressed,
          icon: _buildIcon(colorScheme.onError),
          label: Text(label),
          style: FilledButton.styleFrom(
            backgroundColor: colorScheme.error,
            foregroundColor: colorScheme.onError,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
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
      return Icon(icon);
    }
    return const SizedBox.shrink();
  }
}
