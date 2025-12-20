import 'package:flutter/material.dart';
import '../../foundation/typography.dart';

/// Position of the label relative to the checkbox.
enum CheckboxLabelPosition {
  /// Label appears to the left of the checkbox.
  left,

  /// Label appears to the right of the checkbox.
  right,
}

/// A Material Design checkbox with optional label.
///
/// Provides a customizable checkbox that integrates with the app theme
/// and supports labels, error states, and indeterminate state.
class AppCheckbox extends StatelessWidget {
  /// Creates a checkbox.
  const AppCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.labelPosition = CheckboxLabelPosition.right,
    this.tristate = false,
    this.error,
    this.enabled = true,
    this.activeColor,
    this.checkColor,
    this.borderRadius,
    this.labelStyle,
    this.borderColor,
    this.borderWidth,
    this.fillColor,
  });

  /// Whether this checkbox is checked.
  ///
  /// When [tristate] is true, a value of null corresponds to the mixed state.
  final bool? value;

  /// Called when the value of the checkbox should change.
  ///
  /// The checkbox passes the new value to the callback but does not actually
  /// change state until the parent widget rebuilds the checkbox with the new value.
  final ValueChanged<bool?>? onChanged;

  /// Optional label text to display next to the checkbox.
  final String? label;

  /// The position of the label relative to the checkbox.
  final CheckboxLabelPosition labelPosition;

  /// If true, the checkbox's value can be true, false, or null.
  final bool tristate;

  /// Optional error message to display below the checkbox.
  final String? error;

  /// Whether the checkbox is enabled.
  final bool enabled;

  /// The color to use when this checkbox is checked.
  final Color? activeColor;

  /// The color to use for the check icon.
  final Color? checkColor;

  /// Optional border radius for the checkbox.
  final double? borderRadius;

  /// Optional text style for the label.
  final TextStyle? labelStyle;

  /// Optional border color.
  final Color? borderColor;

  /// Optional border width.
  final double? borderWidth;

  /// Optional fill color (overrides active/inactive backgrounds).
  final WidgetStateProperty<Color?>? fillColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveOnChanged = enabled ? onChanged : null;

    final checkbox = Checkbox(
      value: value,
      onChanged: effectiveOnChanged,
      tristate: tristate,
      activeColor: activeColor,
      checkColor: checkColor,
      fillColor: fillColor,
      side: borderColor != null
          ? BorderSide(color: borderColor!, width: borderWidth ?? 2)
          : null,
      shape: borderRadius != null
          ? RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius!),
            )
          : null,
    );

    Widget result;

    if (label != null) {
      final labelWidget = Text(
        label!,
        style: (labelStyle ?? AppTypography.bodyMedium(context)).copyWith(
          color: enabled
              ? theme.colorScheme.onSurface
              : theme.colorScheme.onSurface.withValues(alpha: 0.38),
        ),
      );

      result = InkWell(
        onTap: effectiveOnChanged != null
            ? () {
                if (tristate) {
                  // Cycle through: false -> true -> null -> false
                  if (value == false) {
                    effectiveOnChanged(true);
                  } else if (value == true) {
                    effectiveOnChanged(null);
                  } else {
                    effectiveOnChanged(false);
                  }
                } else {
                  effectiveOnChanged(!(value ?? false));
                }
              }
            : null,
        borderRadius: BorderRadius.circular(4),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: labelPosition == CheckboxLabelPosition.left
                ? [labelWidget, checkbox]
                : [checkbox, labelWidget],
          ),
        ),
      );
    } else {
      result = checkbox;
    }

    if (error != null) {
      result = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          result,
          Padding(
            padding: const EdgeInsets.only(left: 12.0, top: 4.0),
            child: Text(
              error!,
              style: AppTypography.bodySmall(
                context,
              ).copyWith(color: theme.colorScheme.error),
            ),
          ),
        ],
      );
    }

    return result;
  }
}
