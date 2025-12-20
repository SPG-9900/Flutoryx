import 'package:flutter/material.dart';
import '../../foundation/typography.dart';

/// Position of the label relative to the switch.
enum SwitchLabelPosition {
  /// Label appears to the left of the switch.
  left,

  /// Label appears to the right of the switch.
  right,
}

/// A Material Design switch with optional label.
///
/// Provides a customizable switch that integrates with the app theme
/// and supports labels and disabled states.
class AppSwitch extends StatelessWidget {
  /// Creates a switch.
  const AppSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.labelPosition = SwitchLabelPosition.right,
    this.enabled = true,
    this.activeColor,
    this.activeThumbColor,
    this.inactiveTrackColor,
    this.inactiveThumbColor,
    this.labelStyle,
    this.thumbIcon,
  });

  /// Whether this switch is on or off.
  final bool value;

  /// Called when the user toggles the switch on or off.
  ///
  /// The switch passes the new value to the callback but does not actually
  /// change state until the parent widget rebuilds the switch with the new value.
  final ValueChanged<bool>? onChanged;

  /// Optional label text to display next to the switch.
  final String? label;

  /// The position of the label relative to the switch.
  final SwitchLabelPosition labelPosition;

  /// Whether the switch is enabled.
  final bool enabled;

  /// The color to use when this switch is on.
  final Color? activeColor;

  /// The color to use for the thumb when this switch is on.
  final Color? activeThumbColor;

  /// The color to use for the track when this switch is off.
  final Color? inactiveTrackColor;

  /// The color to use for the thumb when this switch is off.
  final Color? inactiveThumbColor;

  /// Optional text style for the label.
  final TextStyle? labelStyle;

  /// Optional thumb icon (dynamic based on state).
  final WidgetStateProperty<Icon?>? thumbIcon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveOnChanged = enabled ? onChanged : null;

    final switchWidget = Switch(
      value: value,
      onChanged: effectiveOnChanged,
      thumbIcon: thumbIcon,
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return activeThumbColor ?? theme.colorScheme.onPrimary;
        }
        return inactiveThumbColor ?? theme.colorScheme.outline;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return activeColor ?? theme.colorScheme.primary;
        }
        return inactiveTrackColor ?? theme.colorScheme.surfaceContainerHighest;
      }),
    );

    if (label == null) {
      return switchWidget;
    }

    final labelWidget = Text(
      label!,
      style: (labelStyle ?? AppTypography.bodyMedium(context)).copyWith(
        color: enabled
            ? theme.colorScheme.onSurface
            : theme.colorScheme.onSurface.withValues(alpha: 0.38),
      ),
    );

    return InkWell(
      onTap: effectiveOnChanged != null
          ? () => effectiveOnChanged(!value)
          : null,
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: labelPosition == SwitchLabelPosition.left
              ? [labelWidget, const SizedBox(width: 8), switchWidget]
              : [switchWidget, const SizedBox(width: 8), labelWidget],
        ),
      ),
    );
  }
}
