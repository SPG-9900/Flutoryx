import 'package:flutter/material.dart';
import '../../foundation/typography.dart';

/// A Material Design tooltip component.
///
/// Displays helpful text when the user long-presses or hovers over a widget.
class AppTooltip extends StatelessWidget {
  /// Creates a tooltip.
  const AppTooltip({
    super.key,
    required this.message,
    required this.child,
    this.preferBelow = true,
    this.verticalOffset,
    this.waitDuration,
    this.showDuration,
  });

  /// The text to display in the tooltip.
  final String message;

  /// The widget to display the tooltip on.
  final Widget child;

  /// Whether the tooltip should appear below the widget.
  final bool preferBelow;

  /// The vertical offset of the tooltip.
  final double? verticalOffset;

  /// How long to wait before showing the tooltip.
  final Duration? waitDuration;

  /// How long to show the tooltip.
  final Duration? showDuration;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      preferBelow: preferBelow,
      verticalOffset: verticalOffset,
      waitDuration: waitDuration ?? const Duration(milliseconds: 500),
      showDuration: showDuration ?? const Duration(seconds: 2),
      textStyle: AppTypography.bodySmall(context).copyWith(color: Colors.white),
      child: child,
    );
  }
}
