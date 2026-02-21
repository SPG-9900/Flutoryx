import 'package:flutter/material.dart';
import '../../foundation/spacing.dart';
import '../../foundation/radius.dart';
import '../../foundation/typography.dart';

/// Visual style variants for tags.
enum AppTagVariant {
  /// Filled background.
  filled,

  /// Light filled background (tonal).
  light,

  /// Outlined background.
  outlined,
}

/// A compact, non-interactive categorisation badge.
/// Use for categories, statuses, or labels. For actionable items, use AppChip.
class AppTag extends StatelessWidget {
  /// Creates a tag.
  const AppTag({
    super.key,
    required this.label,
    this.variant = AppTagVariant.light,
    this.icon,
    this.color,
    this.textColor,
    this.borderRadius,
    this.padding,
    this.textStyle,
    this.iconSize = 14.0,
  });

  /// The text label.
  final String label;

  /// The visual style variant.
  final AppTagVariant variant;

  /// Optional icon to display before the text.
  final IconData? icon;

  /// The primary color of the tag. Defaults to the theme's primary color.
  final Color? color;

  /// The color of the text. Defaults based on the variant and color.
  final Color? textColor;

  /// Border radius override.
  final double? borderRadius;

  /// Internal padding.
  final EdgeInsetsGeometry? padding;

  /// Text style override.
  final TextStyle? textStyle;

  /// Size of the optional icon.
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final primaryColor = color ?? colorScheme.primary;

    Color bgColor;
    Color fgColor;
    Color borderColor = Colors.transparent;

    switch (variant) {
      case AppTagVariant.filled:
        bgColor = primaryColor;
        fgColor = textColor ?? colorScheme.onPrimary;
        break;
      case AppTagVariant.light:
        // Attempt to create a light shade if using a custom color, else use theme surface variants
        bgColor = color != null
            ? primaryColor.withValues(alpha: 0.15)
            : colorScheme.primaryContainer;
        fgColor =
            textColor ??
            (color != null ? primaryColor : colorScheme.onPrimaryContainer);
        break;
      case AppTagVariant.outlined:
        bgColor = Colors.transparent;
        fgColor = textColor ?? primaryColor;
        borderColor = primaryColor;
        break;
    }

    return Container(
      padding:
          padding ??
          const EdgeInsets.symmetric(horizontal: AppSpacing.s, vertical: 2),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: borderRadius != null
            ? BorderRadius.circular(borderRadius!)
            : AppRadius.roundedS,
        border: variant == AppTagVariant.outlined
            ? Border.all(color: borderColor, width: 1.0)
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(icon, size: iconSize, color: fgColor),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style:
                textStyle ??
                AppTypography.labelSmall(
                  context,
                ).copyWith(color: fgColor, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
