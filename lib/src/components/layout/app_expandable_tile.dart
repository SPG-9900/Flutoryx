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
    this.backgroundColor,
    this.collapsedBackgroundColor,
    this.borderRadius,
    this.borderColor,
    this.borderWidth,
    this.titleStyle,
    this.subtitleStyle,
    this.iconColor,
    this.collapsedIconColor,
    this.textColor,
    this.collapsedTextColor,
    this.expansionAnimationStyle,
    this.clipBehavior,
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

  /// Optional background color.
  final Color? backgroundColor;

  /// Optional background color when collapsed.
  final Color? collapsedBackgroundColor;

  /// Optional border radius.
  final double? borderRadius;

  /// Optional border color.
  final Color? borderColor;

  /// Optional border width.
  final double? borderWidth;

  /// Optional text style for the title.
  final TextStyle? titleStyle;

  /// Optional text style for the subtitle.
  final TextStyle? subtitleStyle;

  /// Optional color for the expansion arrow.
  final Color? iconColor;

  /// Optional color for the expansion arrow when collapsed.
  final Color? collapsedIconColor;

  /// Optional text color.
  final Color? textColor;

  /// Optional text color when collapsed.
  final Color? collapsedTextColor;

  /// Optional expansion animation style.
  final AnimationStyle? expansionAnimationStyle;

  /// Optional clip behavior.
  final Clip? clipBehavior;

  @override
  State<AppExpandableTile> createState() => _AppExpandableTileState();
}

class _AppExpandableTileState extends State<AppExpandableTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.collapsedBackgroundColor ?? widget.backgroundColor,
        borderRadius: widget.borderRadius != null
            ? BorderRadius.circular(widget.borderRadius!)
            : null,
        border: widget.borderColor != null
            ? Border.all(
                color: widget.borderColor!,
                width: widget.borderWidth ?? 1,
              )
            : null,
      ),
      clipBehavior: widget.clipBehavior ?? Clip.none,
      child: ExpansionTile(
        title: Text(
          widget.title,
          style: widget.titleStyle ?? AppTypography.titleMedium(context),
        ),
        subtitle: widget.subtitle != null
            ? Text(
                widget.subtitle!,
                style: widget.subtitleStyle ?? AppTypography.bodySmall(context),
              )
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
        backgroundColor: widget.backgroundColor,
        collapsedBackgroundColor: widget.collapsedBackgroundColor,
        iconColor: widget.iconColor,
        collapsedIconColor: widget.collapsedIconColor,
        textColor: widget.textColor,
        collapsedTextColor: widget.collapsedTextColor,
        expansionAnimationStyle: widget.expansionAnimationStyle,
        shape: widget.borderRadius != null
            ? RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius!),
              )
            : null,
        collapsedShape: widget.borderRadius != null
            ? RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius!),
              )
            : null,
        children: widget.children,
      ),
    );
  }
}
