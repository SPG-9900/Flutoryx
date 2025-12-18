import 'package:flutter/material.dart';
import '../../foundation/spacing.dart';
import '../../foundation/typography.dart';

/// An expandable tile that reveals content when tapped.
///
/// Similar to ExpansionTile but with consistent styling and customization.
class AppExpandableTile extends StatefulWidget {
  /// Creates an expandable tile.
  const AppExpandableTile({
    super.key,
    required this.title,
    required this.children,
    this.subtitle,
    this.leading,
    this.trailing,
    this.initiallyExpanded = false,
    this.onExpansionChanged,
    this.tilePadding,
    this.childrenPadding,
  });

  /// The primary title of the tile.
  final String title;

  /// The widgets to display when the tile is expanded.
  final List<Widget> children;

  /// Optional subtitle text.
  final String? subtitle;

  /// Optional leading widget.
  final Widget? leading;

  /// Optional trailing widget (replaces default expand icon).
  final Widget? trailing;

  /// Whether the tile is initially expanded.
  final bool initiallyExpanded;

  /// Called when the tile expands or collapses.
  final ValueChanged<bool>? onExpansionChanged;

  /// Padding for the tile.
  final EdgeInsets? tilePadding;

  /// Padding for the children.
  final EdgeInsets? childrenPadding;

  @override
  State<AppExpandableTile> createState() => _AppExpandableTileState();
}

class _AppExpandableTileState extends State<AppExpandableTile> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(widget.title, style: AppTypography.titleMedium(context)),
      subtitle: widget.subtitle != null
          ? Text(widget.subtitle!, style: AppTypography.bodySmall(context))
          : null,
      leading: widget.leading,
      trailing: widget.trailing,
      initiallyExpanded: widget.initiallyExpanded,
      onExpansionChanged: widget.onExpansionChanged,
      tilePadding:
          widget.tilePadding ??
          const EdgeInsets.symmetric(
            horizontal: AppSpacing.m,
            vertical: AppSpacing.s,
          ),
      childrenPadding:
          widget.childrenPadding ??
          const EdgeInsets.symmetric(
            horizontal: AppSpacing.l,
            vertical: AppSpacing.m,
          ),
      children: widget.children,
    );
  }
}
