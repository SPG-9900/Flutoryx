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
              Text(labelText!, style: AppTypography.bodyMedium(context)),
              Text(
                value.toStringAsFixed(divisions != null ? 0 : 1),
                style: AppTypography.bodyMedium(context).copyWith(
                  color: theme.colorScheme.primary,
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
              Text(labelText!, style: AppTypography.bodyMedium(context)),
              Text(
                '${values.start.toStringAsFixed(divisions != null ? 0 : 1)} - ${values.end.toStringAsFixed(divisions != null ? 0 : 1)}',
                style: AppTypography.bodyMedium(context).copyWith(
                  color: theme.colorScheme.primary,
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
        ),
      ],
    );
  }
}
