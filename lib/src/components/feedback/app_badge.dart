import 'package:flutter/material.dart';
import '../../foundation/typography.dart';

/// A Material Design badge for displaying status or count.
///
/// Displays a small badge on top of another widget, typically used for
/// notification counts or status indicators.
class AppBadge extends StatelessWidget {
  /// Creates a badge.
  const AppBadge({
    super.key,
    required this.child,
    this.label,
    this.count,
    this.isVisible = true,
    this.backgroundColor,
    this.textColor,
    this.offset,
    this.padding,
    this.borderRadius,
    this.largeSize,
    this.textStyle,
    this.alignment,
    this.borderColor,
    this.borderWidth,
  }) : assert(
         label == null || count == null,
         'Cannot provide both label and count',
       );

  /// The widget to display the badge on.
  final Widget child;

  /// Optional text label for the badge.
  final String? label;

  /// Optional count to display (will show "99+" if > 99).
  final int? count;

  /// Whether the badge is visible.
  final bool isVisible;

  /// Background color of the badge.
  final Color? backgroundColor;

  /// Text color of the badge.
  final Color? textColor;

  /// Offset for badge positioning.
  final Offset? offset;

  /// Optional padding override.
  final EdgeInsetsGeometry? padding;

  /// Optional border radius override.
  final double? borderRadius;

  /// The size of the badge when it has a label.
  final double? largeSize;

  /// Optional text style for the badge label.
  final TextStyle? textStyle;

  /// The alignment of the badge relative to the child.
  final AlignmentGeometry? alignment;

  /// Optional border color.
  final Color? borderColor;

  /// Optional border width.
  final double? borderWidth;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (!isVisible) {
      return child;
    }

    String? badgeLabel;
    if (count != null) {
      badgeLabel = count! > 99 ? '99+' : count.toString();
    } else if (label != null) {
      badgeLabel = label;
    }

    return Badge(
      label: badgeLabel != null
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: backgroundColor ?? theme.colorScheme.error,
                borderRadius: BorderRadius.circular(borderRadius ?? 10),
                border: borderColor != null
                    ? Border.all(color: borderColor!, width: borderWidth ?? 1)
                    : null,
              ),
              child: Text(
                badgeLabel,
                style:
                    textStyle ??
                    AppTypography.labelSmall(
                      context,
                    ).copyWith(color: textColor ?? theme.colorScheme.onError),
              ),
            )
          : null,
      isLabelVisible: isVisible,
      backgroundColor: backgroundColor ?? theme.colorScheme.error,
      offset: offset,
      padding: padding,
      largeSize: largeSize,
      alignment: alignment,
      child: child,
    );
  }
}

/// A simple dot badge without text.
class AppDotBadge extends StatelessWidget {
  /// Creates a dot badge.
  const AppDotBadge({
    super.key,
    required this.child,
    this.isVisible = true,
    this.color,
    this.size = 8.0,
    this.offset,
    this.borderRadius,
    this.alignment,
    this.borderColor,
    this.borderWidth,
  });

  /// The widget to display the badge on.
  final Widget child;

  /// Whether the badge is visible.
  final bool isVisible;

  /// Color of the dot.
  final Color? color;

  /// The size of the dot.
  final double size;

  /// Offset for badge positioning.
  final Offset? offset;

  /// Optional border radius override.
  final double? borderRadius;

  /// The alignment of the badge relative to the child.
  final AlignmentGeometry? alignment;

  /// Optional border color.
  final Color? borderColor;

  /// Optional border width.
  final double? borderWidth;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (!isVisible) {
      return child;
    }

    return Badge(
      smallSize: size,
      isLabelVisible: isVisible,
      backgroundColor: Colors.transparent, // Handled by decoration below
      offset: offset,
      alignment: alignment,
      label: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color ?? theme.colorScheme.error,
          shape: BoxShape.circle,
          borderRadius: borderRadius != null
              ? BorderRadius.circular(borderRadius!)
              : null,
          border: borderColor != null
              ? Border.all(color: borderColor!, width: borderWidth ?? 1)
              : null,
        ),
      ),
      child: child,
    );
  }
}
