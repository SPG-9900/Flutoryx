import 'package:flutter/material.dart';
import '../../foundation/typography.dart';

/// A wrapper around [Text] that adheres to the application's typography.
///
/// Uses [AppTypography] to ensure consistent scaling and styling across the app.
class AppText extends StatelessWidget {
  /// The text to display.
  final String data;

  /// The typography variant to use.
  final AppTextVariant variant;

  /// Optional override for the text color.
  final Color? color;

  /// How the text should be aligned horizontally.
  final TextAlign? textAlign;

  /// An optional maximum number of lines for the text to span.
  final int? maxLines;

  /// How visual overflow should be handled.
  final TextOverflow? overflow;

  /// Optional additional styles to merge with the variant style.
  final TextStyle? style;

  /// Creates an [AppText] widget.
  const AppText(
    this.data, {
    super.key,
    this.variant = AppTextVariant.bodyMedium,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    // Get the base style for the variant
    final baseStyle = AppTypography.getStyle(context, variant);

    // Get the theme's onSurface color as default if no color provided
    final themeColor = Theme.of(context).colorScheme.onSurface;

    return Text(
      data,
      style: baseStyle
          .copyWith(color: color ?? style?.color ?? themeColor)
          .merge(style),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
