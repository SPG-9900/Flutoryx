import 'package:flutter/material.dart';
import '../../foundation/typography.dart';
import '../../foundation/spacing.dart';

/// A Material Design slider with label.
class AppSlider extends StatelessWidget {
  /// Creates a slider.
  const AppSlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 0.0,
    this.max = 100.0,
    this.divisions,
    this.label,
    this.labelText,
    this.enabled = true,
    this.activeColor,
    this.inactiveColor,
    this.thumbColor,
    this.overlayColor,
    this.valueIndicatorColor,
    this.secondaryTrackValue,
    this.secondaryActiveColor,
    this.labelStyle,
    this.valueStyle,
  });

  /// The current value of the slider.
  final double value;

  /// Called when the user changes the slider value.
  final ValueChanged<double>? onChanged;

  /// The minimum value of the slider.
  final double min;

  /// The maximum value of the slider.
  final double max;

  /// The number of discrete divisions.
  final int? divisions;

  /// Optional label shown above the slider thumb.
  final String? label;

  /// Optional label text displayed above the slider.
  final String? labelText;

  /// Whether the slider is enabled.
  final bool enabled;

  /// Optional active track color.
  final Color? activeColor;

  /// Optional inactive track color.
  final Color? inactiveColor;

  /// Optional thumb color.
  final Color? thumbColor;

  /// Optional overlay color.
  final Color? overlayColor;

  /// Optional value indicator color.
  final Color? valueIndicatorColor;

  /// Optional secondary track value.
  final double? secondaryTrackValue;

  /// Optional secondary active color.
  final Color? secondaryActiveColor;

  /// Optional label text style.
  final TextStyle? labelStyle;

  /// Optional value text style.
  final TextStyle? valueStyle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveOnChanged = enabled ? onChanged : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (labelText != null) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                labelText!,
                style: labelStyle ?? AppTypography.bodyMedium(context),
              ),
              Text(
                value.toStringAsFixed(divisions != null ? 0 : 1),
                style:
                    valueStyle ??
                    AppTypography.bodyMedium(context).copyWith(
                      color: activeColor ?? theme.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.s),
        ],
        Slider(
          value: value,
          onChanged: effectiveOnChanged,
          min: min,
          max: max,
          divisions: divisions,
          label: label ?? value.toStringAsFixed(divisions != null ? 0 : 1),
          activeColor: activeColor,
          inactiveColor: inactiveColor,
          thumbColor: thumbColor,
          overlayColor: WidgetStateProperty.all(overlayColor),
          secondaryTrackValue: secondaryTrackValue,
          secondaryActiveColor: secondaryActiveColor,
        ),
      ],
    );
  }
}

/// A range slider for selecting a range of values.
class AppRangeSlider extends StatelessWidget {
  /// Creates a range slider.
  const AppRangeSlider({
    super.key,
    required this.values,
    required this.onChanged,
    this.min = 0.0,
    this.max = 100.0,
    this.divisions,
    this.labelText,
    this.enabled = true,
    this.activeColor,
    this.inactiveColor,
    this.thumbColor,
    this.overlayColor,
    this.labelStyle,
    this.valueStyle,
  });

  /// The current range values.
  final RangeValues values;

  /// Called when the user changes the range.
  final ValueChanged<RangeValues>? onChanged;

  /// The minimum value.
  final double min;

  /// The maximum value.
  final double max;

  /// The number of discrete divisions.
  final int? divisions;

  /// Optional label text displayed above the slider.
  final String? labelText;

  /// Whether the slider is enabled.
  final bool enabled;

  /// Optional active track color.
  final Color? activeColor;

  /// Optional inactive track color.
  final Color? inactiveColor;

  /// Optional thumb color.
  final Color? thumbColor;

  /// Optional overlay color.
  final Color? overlayColor;

  /// Optional text style for label.
  final TextStyle? labelStyle;

  /// Optional text style for value.
  final TextStyle? valueStyle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveOnChanged = enabled ? onChanged : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (labelText != null) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                labelText!,
                style: labelStyle ?? AppTypography.bodyMedium(context),
              ),
              Text(
                '${values.start.toStringAsFixed(divisions != null ? 0 : 1)} - ${values.end.toStringAsFixed(divisions != null ? 0 : 1)}',
                style:
                    valueStyle ??
                    AppTypography.bodyMedium(context).copyWith(
                      color: activeColor ?? theme.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.s),
        ],
        RangeSlider(
          values: values,
          onChanged: effectiveOnChanged,
          min: min,
          max: max,
          divisions: divisions,
          labels: RangeLabels(
            values.start.toStringAsFixed(divisions != null ? 0 : 1),
            values.end.toStringAsFixed(divisions != null ? 0 : 1),
          ),
          activeColor: activeColor,
          inactiveColor: inactiveColor,
          overlayColor: WidgetStateProperty.all(overlayColor),
        ),
      ],
    );
  }
}
