import 'package:flutter/material.dart';

/// A horizontal or vertical divider with optional text.
///
/// Provides a visual separator between content sections with theme-aware styling.
class AppDivider extends StatelessWidget {
  /// Creates a horizontal divider.
  const AppDivider.horizontal({
    super.key,
    this.thickness,
    this.color,
    this.indent,
    this.endIndent,
  }) : orientation = Axis.horizontal,
       text = null,
       textStyle = null,
       height = null;

  /// Creates a vertical divider.
  const AppDivider.vertical({
    super.key,
    this.thickness,
    this.color,
    this.height,
  }) : orientation = Axis.vertical,
       text = null,
       textStyle = null,
       indent = null,
       endIndent = null;

  /// Creates a horizontal divider with text in the center.
  const AppDivider.withText(
    this.text, {
    super.key,
    this.textStyle,
    this.thickness,
    this.color,
  }) : orientation = Axis.horizontal,
       indent = null,
       endIndent = null,
       height = null;

  /// The orientation of the divider.
  final Axis orientation;

  /// The thickness of the divider line.
  final double? thickness;

  /// The color of the divider.
  final Color? color;

  /// The amount of empty space to the leading edge of the divider.
  final double? indent;

  /// The amount of empty space to the trailing edge of the divider.
  final double? endIndent;

  /// The height of the vertical divider.
  final double? height;

  /// Optional text to display in the center of a horizontal divider.
  final String? text;

  /// The style to use for the text.
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dividerColor = color ?? theme.dividerColor;
    final dividerThickness = thickness ?? 1.0;

    if (text != null) {
      return _buildDividerWithText(context, dividerColor, dividerThickness);
    }

    if (orientation == Axis.vertical) {
      return VerticalDivider(
        thickness: dividerThickness,
        color: dividerColor,
        width: height,
      );
    }

    return Divider(
      thickness: dividerThickness,
      color: dividerColor,
      indent: indent,
      endIndent: endIndent,
    );
  }

  Widget _buildDividerWithText(
    BuildContext context,
    Color dividerColor,
    double dividerThickness,
  ) {
    final theme = Theme.of(context);
    final effectiveTextStyle =
        textStyle ??
        theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        );

    return Row(
      children: [
        Expanded(
          child: Divider(thickness: dividerThickness, color: dividerColor),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(text!, style: effectiveTextStyle),
        ),
        Expanded(
          child: Divider(thickness: dividerThickness, color: dividerColor),
        ),
      ],
    );
  }
}
