import 'package:flutter/material.dart';
import '../../foundation/typography.dart';
import '../../foundation/spacing.dart';

/// A single radio button option.
class AppRadio<T> extends StatelessWidget {
  /// Creates a radio button.
  const AppRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.label,
    this.enabled = true,
  });

  /// The value represented by this radio button.
  final T value;

  /// The currently selected value for the group of radio buttons.
  final T? groupValue;

  /// Called when the user selects this radio button.
  final ValueChanged<T?>? onChanged;

  /// Optional label text to display next to the radio button.
  final String? label;

  /// Whether the radio button is enabled.
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveOnChanged = enabled ? onChanged : null;

    final radio = Radio<T>(
      value: value,
      groupValue: groupValue,
      onChanged: effectiveOnChanged,
    );

    if (label == null) {
      return radio;
    }

    return InkWell(
      onTap: effectiveOnChanged != null
          ? () => effectiveOnChanged(value)
          : null,
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            radio,
            const SizedBox(width: 8),
            Text(
              label!,
              style: AppTypography.bodyMedium(context).copyWith(
                color: enabled
                    ? theme.colorScheme.onSurface
                    : theme.colorScheme.onSurface.withValues(alpha: 0.38),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A group of radio buttons with labels.
class AppRadioGroup<T> extends StatelessWidget {
  /// Creates a radio button group.
  const AppRadioGroup({
    super.key,
    required this.value,
    required this.onChanged,
    required this.options,
    this.direction = Axis.vertical,
    this.spacing = AppSpacing.s,
    this.enabled = true,
  });

  /// The currently selected value.
  final T? value;

  /// Called when the user selects a radio button.
  final ValueChanged<T?>? onChanged;

  /// The list of options to display.
  /// Can be a list of values (will use toString() for labels)
  /// or a Map<T, String> for custom labels.
  final dynamic options;

  /// The direction to layout the radio buttons.
  final Axis direction;

  /// The spacing between radio buttons.
  final double spacing;

  /// Whether the radio group is enabled.
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final List<Widget> radioButtons = [];

    if (options is Map<T, String>) {
      final optionsMap = options as Map<T, String>;
      for (final entry in optionsMap.entries) {
        radioButtons.add(
          AppRadio<T>(
            value: entry.key,
            groupValue: value,
            onChanged: onChanged,
            label: entry.value,
            enabled: enabled,
          ),
        );
      }
    } else if (options is List<T>) {
      final optionsList = options as List<T>;
      for (final option in optionsList) {
        radioButtons.add(
          AppRadio<T>(
            value: option,
            groupValue: value,
            onChanged: onChanged,
            label: option.toString(),
            enabled: enabled,
          ),
        );
      }
    }

    if (direction == Axis.vertical) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: radioButtons
            .map(
              (radio) => Padding(
                padding: EdgeInsets.only(bottom: spacing),
                child: radio,
              ),
            )
            .toList(),
      );
    } else {
      return Wrap(
        spacing: spacing,
        runSpacing: spacing,
        children: radioButtons,
      );
    }
  }
}
