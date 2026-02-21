import 'package:flutter/material.dart';
import '../../foundation/spacing.dart';
import '../../foundation/typography.dart';

/// Represents a single item in an [AppTimeline].
class AppTimelineItem {
  /// The title of the timeline event.
  final String title;

  /// Optional subtitle or description.
  final String? subtitle;

  /// Optional time or date string to display alongside the event.
  final String? time;

  /// Optional custom widget to use as the indicator dot.
  final Widget? indicator;

  /// Whether this event is marked as active or completed.
  final bool isActive;

  /// Whether this is an error state event.
  final bool isError;

  const AppTimelineItem({
    required this.title,
    this.subtitle,
    this.time,
    this.indicator,
    this.isActive = false,
    this.isError = false,
  });
}

/// A visual component that presents events in chronological order.
class AppTimeline extends StatelessWidget {
  /// Creates an AppTimeline.
  const AppTimeline({
    super.key,
    required this.items,
    this.activeColor,
    this.inactiveColor,
    this.errorColor,
    this.lineWidth = 2.0,
    this.indicatorSize = 16.0,
    this.padding,
    this.itemSpacing = AppSpacing.l,
    this.timeWidth = 60.0,
  });

  /// The list of items to display.
  final List<AppTimelineItem> items;

  /// Color for active lines and indicators.
  final Color? activeColor;

  /// Color for inactive lines and indicators.
  final Color? inactiveColor;

  /// Color for error indicators.
  final Color? errorColor;

  /// Width of the connector lines.
  final double lineWidth;

  /// Size of the default indicator dot.
  final double indicatorSize;

  /// Padding around the timeline.
  final EdgeInsetsGeometry? padding;

  /// Vertical spacing between items.
  final double itemSpacing;

  /// The width allocated for the time string column. Set to 0 to hide.
  final double timeWidth;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: List.generate(items.length, (index) {
          return _buildTimelineItem(context, index);
        }),
      ),
    );
  }

  Widget _buildTimelineItem(BuildContext context, int index) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final item = items[index];
    final isFirst = index == 0;
    final isLast = index == items.length - 1;

    final baseActiveColor = activeColor ?? colorScheme.primary;
    final baseInactiveColor =
        inactiveColor ?? colorScheme.surfaceContainerHighest;
    final baseErrorColor = errorColor ?? colorScheme.error;

    Color indicatorColor;
    if (item.isError) {
      indicatorColor = baseErrorColor;
    } else if (item.isActive) {
      indicatorColor = baseActiveColor;
    } else {
      indicatorColor = baseInactiveColor;
    }

    // Determine line colors
    final topColor = (isFirst)
        ? Colors.transparent
        : (item.isActive ? baseActiveColor : baseInactiveColor);
    final bottomColor = (isLast)
        ? Colors.transparent
        : (items[index + 1].isActive ? baseActiveColor : baseInactiveColor);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Time column
          if (timeWidth > 0) ...[
            SizedBox(
              width: timeWidth,
              child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 2.0, right: AppSpacing.m),
                  child: Text(
                    item.time ?? '',
                    style: AppTypography.labelMedium(
                      context,
                    ).copyWith(color: colorScheme.onSurfaceVariant),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
            ),
          ],

          // Indicator and Line column
          SizedBox(
            width: indicatorSize,
            child: Column(
              children: [
                // Top line
                Expanded(
                  flex: 1,
                  child: Container(width: lineWidth, color: topColor),
                ),
                // Indicator
                SizedBox(
                  height: indicatorSize,
                  child: Center(
                    child:
                        item.indicator ??
                        Container(
                          width: indicatorSize,
                          height: indicatorSize,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: indicatorColor,
                            border: Border.all(
                              color: item.isActive || item.isError
                                  ? Colors.transparent
                                  : theme.colorScheme.outlineVariant,
                              width: 1.5,
                            ),
                          ),
                        ),
                  ),
                ),
                // Bottom line
                Expanded(
                  flex: 4, // Make bottom line longer to stretch until next item
                  child: Container(width: lineWidth, color: bottomColor),
                ),
              ],
            ),
          ),

          // Content column
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: AppSpacing.m,
                bottom: AppSpacing.xl,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item.title,
                    style: AppTypography.titleMedium(context).copyWith(
                      color: item.isError
                          ? baseErrorColor
                          : colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (item.subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      item.subtitle!,
                      style: AppTypography.bodySmall(
                        context,
                      ).copyWith(color: colorScheme.onSurfaceVariant),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
