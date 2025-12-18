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
          ? Text(
              badgeLabel,
              style: AppTypography.labelSmall(
                context,
              ).copyWith(color: textColor ?? theme.colorScheme.onError),
            )
          : null,
      isLabelVisible: isVisible,
      backgroundColor: backgroundColor ?? theme.colorScheme.error,
      offset: offset,
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
  });

  /// The widget to display the badge on.
  final Widget child;

  /// Whether the badge is visible.
  final bool isVisible;

  /// Color of the dot.
  final Color? color;

  /// Size of the dot.
  final double size;

  /// Offset for badge positioning.
  final Offset? offset;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (!isVisible) {
      return child;
    }

    return Badge(
      smallSize: size,
      isLabelVisible: isVisible,
      backgroundColor: color ?? theme.colorScheme.error,
      offset: offset,
      child: child,
    );
  }
}
