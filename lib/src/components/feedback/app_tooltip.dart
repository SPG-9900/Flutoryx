import 'package:flutter/material.dart';
import '../../foundation/typography.dart';
import '../../foundation/colors.dart';

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
    this.backgroundColor,
    this.textColor,
    this.borderRadius,
    this.padding,
    this.margin,
    this.textStyle,
    this.triggerMode,
    this.enableFeedback,
    this.borderColor,
    this.borderWidth,
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

  /// Optional background color.
  final Color? backgroundColor;

  /// Optional text color.
  final Color? textColor;

  /// Optional border radius.
  final double? borderRadius;

  /// Optional padding.
  final EdgeInsetsGeometry? padding;

  /// Optional margin.
  final EdgeInsetsGeometry? margin;

  /// Optional text style.
  final TextStyle? textStyle;

  /// The mode that triggers the tooltip.
  final TooltipTriggerMode? triggerMode;

  /// Whether feedback is enabled.
  final bool? enableFeedback;

  /// Optional border color.
  final Color? borderColor;

  /// Optional border width.
  final double? borderWidth;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      preferBelow: preferBelow,
      verticalOffset: verticalOffset,
      waitDuration: waitDuration ?? const Duration(milliseconds: 500),
      showDuration: showDuration ?? const Duration(seconds: 2),
      triggerMode: triggerMode,
      enableFeedback: enableFeedback,
      margin: margin,
      padding: padding,
      decoration: ShapeDecoration(
        color:
            backgroundColor ??
            Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 4),
          side: borderColor != null
              ? BorderSide(color: borderColor!, width: borderWidth ?? 1)
              : BorderSide.none,
        ),
      ),
      textStyle:
          textStyle ??
          AppTypography.bodySmall(
            context,
          ).copyWith(color: textColor ?? AppColors.white),
      child: child,
    );
  }
}
