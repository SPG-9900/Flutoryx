import 'package:flutter/material.dart';
import '../../foundation/spacing.dart';

/// Type of chip.
enum AppChipType {
  /// Input chip for user input.
  input,

  /// Filter chip for filtering content.
  filter,

  /// Choice chip for single selection.
  choice,

  /// Action chip for triggering actions.
  action,
}

/// A Material Design chip component.
class AppChip extends StatelessWidget {
  /// Creates a chip.
  const AppChip({
    super.key,
    required this.label,
    this.type = AppChipType.action,
    this.selected = false,
    this.onSelected,
    this.onDeleted,
    this.avatar,
    this.deleteIcon,
    this.enabled = true,
    this.backgroundColor,
    this.selectedColor,
    this.labelStyle,
    this.selectedLabelStyle,
    this.borderRadius,
    this.borderColor,
    this.selectedBorderColor,
    this.deleteIconColor,
    this.padding,
    this.labelPadding,
    this.elevation,
    this.shadowColor,
    this.iconTheme,
  });

  /// The label text of the chip.
  final String label;

  /// The type of chip.
  final AppChipType type;

  /// Whether the chip is selected (for filter/choice chips).
  final bool selected;

  /// Called when the chip is selected/deselected.
  final ValueChanged<bool>? onSelected;

  /// Called when the delete icon is tapped.
  final VoidCallback? onDeleted;

  /// Optional avatar widget displayed before the label.
  final Widget? avatar;

  /// Optional custom delete icon.
  final Widget? deleteIcon;

  /// Whether the chip is enabled.
  final bool enabled;

  /// Optional background color override.
  final Color? backgroundColor;

  /// Optional background color when selected.
  final Color? selectedColor;

  /// Optional text style for the label.
  final TextStyle? labelStyle;

  /// Optional text style for the label when selected.
  final TextStyle? selectedLabelStyle;

  /// Optional border radius override.
  final double? borderRadius;

  /// Optional border color.
  final Color? borderColor;

  /// Optional border color when selected.
  final Color? selectedBorderColor;

  /// Optional color for the delete icon.
  final Color? deleteIconColor;

  /// Optional padding for the chip.
  final EdgeInsetsGeometry? padding;

  /// Optional padding for the label.
  final EdgeInsetsGeometry? labelPadding;

  /// Optional elevation.
  final double? elevation;

  /// Optional shadow color.
  final Color? shadowColor;

  /// Optional icon theme for the avatar.
  final IconThemeData? iconTheme;

  @override
  Widget build(BuildContext context) {
    final shape = borderRadius != null || borderColor != null
        ? RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8),
            side: borderColor != null
                ? BorderSide(color: borderColor!)
                : BorderSide.none,
          )
        : null;

    final selectedShape = selectedBorderColor != null
        ? RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8),
            side: BorderSide(color: selectedBorderColor!),
          )
        : shape;

    switch (type) {
      case AppChipType.input:
        return InputChip(
          label: Text(label, style: selected ? selectedLabelStyle : labelStyle),
          selected: selected,
          onSelected: enabled ? onSelected : null,
          onDeleted: enabled ? onDeleted : null,
          avatar: avatar,
          deleteIcon: deleteIcon,
          backgroundColor: backgroundColor,
          selectedColor: selectedColor,
          deleteIconColor: deleteIconColor,
          padding: padding,
          labelPadding: labelPadding,
          elevation: elevation,
          shadowColor: shadowColor,
          iconTheme: iconTheme,
          shape: selected ? selectedShape : shape,
        );

      case AppChipType.filter:
        return FilterChip(
          label: Text(label, style: selected ? selectedLabelStyle : labelStyle),
          selected: selected,
          onSelected: enabled ? onSelected : null,
          avatar: avatar,
          backgroundColor: backgroundColor,
          selectedColor: selectedColor,
          padding: padding,
          labelPadding: labelPadding,
          elevation: elevation,
          shadowColor: shadowColor,
          iconTheme: iconTheme,
          shape: selected ? selectedShape : shape,
        );

      case AppChipType.choice:
        return ChoiceChip(
          label: Text(label, style: selected ? selectedLabelStyle : labelStyle),
          selected: selected,
          onSelected: enabled ? onSelected : null,
          avatar: avatar,
          backgroundColor: backgroundColor,
          selectedColor: selectedColor,
          padding: padding,
          labelPadding: labelPadding,
          elevation: elevation,
          shadowColor: shadowColor,
          iconTheme: iconTheme,
          shape: selected ? selectedShape : shape,
        );

      case AppChipType.action:
        return ActionChip(
          label: Text(label, style: labelStyle),
          onPressed: enabled && onSelected != null
              ? () => onSelected!(true)
              : null,
          avatar: avatar,
          backgroundColor: backgroundColor,
          padding: padding,
          labelPadding: labelPadding,
          elevation: elevation,
          shadowColor: shadowColor,
          iconTheme: iconTheme,
          shape: shape,
        );
    }
  }
}

/// A group of chips with automatic wrapping.
class AppChipGroup extends StatelessWidget {
  /// Creates a chip group.
  const AppChipGroup({
    super.key,
    required this.chips,
    this.spacing = AppSpacing.s,
    this.runSpacing = AppSpacing.s,
  });

  /// The list of chips to display.
  final List<AppChip> chips;

  /// The horizontal spacing between chips.
  final double spacing;

  /// The vertical spacing between chip rows.
  final double runSpacing;

  @override
  Widget build(BuildContext context) {
    return Wrap(spacing: spacing, runSpacing: runSpacing, children: chips);
  }
}
