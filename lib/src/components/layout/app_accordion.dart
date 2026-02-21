import 'package:flutter/material.dart';
import '../../foundation/spacing.dart';
import '../../foundation/radius.dart';
import '../../foundation/typography.dart';
import '../layout/app_divider.dart';

/// A single item within an [AppAccordion].
class AppAccordionItem {
  /// The title of the accordion item.
  final String title;

  /// Optional subtitle widget.
  final Widget? subtitle;

  /// Optional leading widget (e.g., an icon).
  final Widget? leading;

  /// The body content of the accordion item.
  final Widget content;

  /// Whether the item is initially expanded.
  final bool initiallyExpanded;

  /// An optional unique key for the item.
  final Key? key;

  const AppAccordionItem({
    required this.title,
    required this.content,
    this.subtitle,
    this.leading,
    this.initiallyExpanded = false,
    this.key,
  });
}

/// A Material 3 compliant accordion component for displaying collapsible lists.
class AppAccordion extends StatefulWidget {
  /// Creates an accordion.
  const AppAccordion({
    super.key,
    required this.items,
    this.allowMultipleExpanded = false,
    this.margin,
    this.dividerColor,
    this.backgroundColor,
    this.expandedBackgroundColor,
    this.borderRadius,
    this.borderColor,
    this.borderWidth,
    this.titleStyle,
    this.contentPadding,
    this.headerPadding,
    this.elevation = 0,
    this.shadowColor,
    this.separated = false,
  });

  /// The list of items to display in the accordion.
  final List<AppAccordionItem> items;

  /// Whether multiple sections can be expanded simultaneously.
  final bool allowMultipleExpanded;

  /// Optional margin around the accordion or between items if [separated] is true.
  final EdgeInsetsGeometry? margin;

  /// Color of the divider between items (when not separated).
  final Color? dividerColor;

  /// Background color of collapsed items.
  final Color? backgroundColor;

  /// Background color of expanded items.
  final Color? expandedBackgroundColor;

  /// Border radius of the accordion (or individual cards if separated).
  final double? borderRadius;

  /// Border color.
  final Color? borderColor;

  /// Border width.
  final double? borderWidth;

  /// Style for the titles.
  final TextStyle? titleStyle;

  /// Padding for the content block.
  final EdgeInsetsGeometry? contentPadding;

  /// Padding for the header block.
  final EdgeInsetsGeometry? headerPadding;

  /// Elevation of the accordion items.
  final double elevation;

  /// Shadow color.
  final Color? shadowColor;

  /// Whether each item should be a distinct card (separated) rather than grouped.
  final bool separated;

  @override
  State<AppAccordion> createState() => _AppAccordionState();
}

class _AppAccordionState extends State<AppAccordion> {
  late List<bool> _isExpandedList;

  @override
  void initState() {
    super.initState();
    _isExpandedList = widget.items
        .map((item) => item.initiallyExpanded)
        .toList();
  }

  @override
  void didUpdateWidget(covariant AppAccordion oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.items.length != _isExpandedList.length) {
      _isExpandedList = List.generate(widget.items.length, (index) {
        if (index < oldWidget.items.length) {
          return _isExpandedList[index];
        }
        return widget.items[index].initiallyExpanded;
      });
    }
  }

  void _onExpansionChanged(int index, bool isExpanded) {
    setState(() {
      if (!widget.allowMultipleExpanded && isExpanded) {
        // Collapse all others
        for (int i = 0; i < _isExpandedList.length; i++) {
          if (i != index) {
            _isExpandedList[i] = false;
          }
        }
      }
      _isExpandedList[index] = isExpanded;
    });
  }

  Widget _buildSeparated() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: widget.margin ?? EdgeInsets.zero,
      itemCount: widget.items.length,
      separatorBuilder: (context, index) =>
          const SizedBox(height: AppSpacing.m),
      itemBuilder: (context, index) {
        return _buildItemCard(index);
      },
    );
  }

  Widget _buildGrouped() {
    final theme = Theme.of(context);
    final radius = widget.borderRadius ?? AppRadius.m;

    return Container(
      margin: widget.margin,
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(radius),
        border: widget.borderColor != null
            ? Border.all(
                color: widget.borderColor!,
                width: widget.borderWidth ?? 1,
              )
            : Border.all(color: theme.colorScheme.outlineVariant),
        boxShadow: widget.elevation > 0
            ? [
                BoxShadow(
                  color:
                      widget.shadowColor ??
                      theme.shadowColor.withValues(alpha: 0.2),
                  blurRadius: widget.elevation,
                  offset: Offset(0, widget.elevation / 2),
                ),
              ]
            : null,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Column(
          children: List.generate(widget.items.length, (index) {
            final isLast = index == widget.items.length - 1;
            return Column(
              children: [
                _buildExpansionTile(index),
                if (!isLast)
                  AppDivider.horizontal(
                    color:
                        widget.dividerColor ?? theme.colorScheme.outlineVariant,
                    thickness: 1,
                  ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildItemCard(int index) {
    final theme = Theme.of(context);
    final isExpanded = _isExpandedList[index];
    final radius = widget.borderRadius ?? AppRadius.m;

    return Material(
      elevation: widget.elevation,
      shadowColor: widget.shadowColor,
      clipBehavior: Clip.antiAlias,
      color: isExpanded
          ? (widget.expandedBackgroundColor ??
                theme.colorScheme.surfaceContainerHighest.withValues(
                  alpha: 0.3,
                ))
          : (widget.backgroundColor ?? theme.colorScheme.surface),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
        side: widget.borderColor != null
            ? BorderSide(
                color: widget.borderColor!,
                width: widget.borderWidth ?? 1,
              )
            : BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      child: _buildExpansionTile(index),
    );
  }

  Widget _buildExpansionTile(int index) {
    final item = widget.items[index];
    final theme = Theme.of(context);
    final isExpanded = _isExpandedList[index];

    return Theme(
      data: theme.copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        key: item.key,
        expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
        initiallyExpanded: item.initiallyExpanded,
        onExpansionChanged: (expanded) => _onExpansionChanged(index, expanded),
        tilePadding:
            widget.headerPadding ??
            const EdgeInsets.symmetric(
              horizontal: AppSpacing.l,
              vertical: AppSpacing.xs,
            ),
        childrenPadding:
            widget.contentPadding ??
            const EdgeInsets.fromLTRB(
              AppSpacing.l,
              0,
              AppSpacing.l,
              AppSpacing.l,
            ),
        backgroundColor:
            widget.expandedBackgroundColor ??
            theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        collapsedBackgroundColor: Colors.transparent, // Handled by parent
        leading: item.leading,
        title: Text(
          item.title,
          style:
              widget.titleStyle ??
              AppTypography.titleMedium(context).copyWith(
                fontWeight: isExpanded ? FontWeight.w600 : FontWeight.w500,
                color: isExpanded
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurface,
              ),
        ),
        subtitle: item.subtitle,
        iconColor: theme.colorScheme.primary,
        collapsedIconColor: theme.colorScheme.onSurfaceVariant,
        children: [
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.fastOutSlowIn,
            child: item.content,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.separated) {
      return _buildSeparated();
    }
    return _buildGrouped();
  }
}
