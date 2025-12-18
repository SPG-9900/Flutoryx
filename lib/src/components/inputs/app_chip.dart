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

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case AppChipType.input:
        return InputChip(
          label: Text(label),
          selected: selected,
          onSelected: enabled ? onSelected : null,
          onDeleted: enabled ? onDeleted : null,
          avatar: avatar,
          deleteIcon: deleteIcon,
        );

      case AppChipType.filter:
        return FilterChip(
          label: Text(label),
          selected: selected,
          onSelected: enabled ? onSelected : null,
          avatar: avatar,
        );

      case AppChipType.choice:
        return ChoiceChip(
          label: Text(label),
          selected: selected,
          onSelected: enabled ? onSelected : null,
          avatar: avatar,
        );

      case AppChipType.action:
        return ActionChip(
          label: Text(label),
          onPressed: enabled && onSelected != null
              ? () => onSelected!(true)
              : null,
          avatar: avatar,
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
