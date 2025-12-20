import 'package:flutter/material.dart';

/// A premium Material 3 styled bottom navigation bar.
class AppNavigationBar extends StatelessWidget {
  /// The current selected index.
  final int currentIndex;

  /// Callback when a tab is selected.
  final ValueChanged<int> onTap;

  /// The list of items to display in the navigation bar.
  final List<AppNavigationItem> items;

  /// Whether to show labels always, or only for the selected item.
  final bool showLabels;

  /// Background color of the bar. Defaults to surface color.
  final Color? backgroundColor;

  /// Color of the active indicator.
  final Color? indicatorColor;

  /// Optional color for selected icons.
  final Color? selectedIconColor;

  /// Optional color for unselected icons.
  final Color? unselectedIconColor;

  /// Optional text style for selected labels.
  final TextStyle? selectedLabelStyle;

  /// Optional text style for unselected labels.
  final TextStyle? unselectedLabelStyle;

  /// Optional height.
  final double? height;

  /// Optional elevation.
  final double? elevation;

  /// Optional shadow color.
  final Color? shadowColor;

  /// Optional overlay color for hover/focus/press.
  final WidgetStateProperty<Color?>? overlayColor;

  /// Label behavior override.
  final NavigationDestinationLabelBehavior? labelBehavior;

  /// Optional indicator shape.
  final ShapeBorder? indicatorShape;

  /// Optional border.
  final Border? border;

  const AppNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
    this.showLabels = true,
    this.backgroundColor,
    this.indicatorColor,
    this.selectedIconColor,
    this.unselectedIconColor,
    this.selectedLabelStyle,
    this.unselectedLabelStyle,
    this.height,
    this.elevation,
    this.shadowColor,
    this.overlayColor,
    this.labelBehavior,
    this.indicatorShape,
    this.border,
  }) : assert(items.length >= 2, 'NavigationBar must have at least 2 items');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final effectiveLabelBehavior =
        labelBehavior ??
        (showLabels
            ? NavigationDestinationLabelBehavior.alwaysShow
            : NavigationDestinationLabelBehavior.onlyShowSelected);

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? colorScheme.surface,
        border: border,
        boxShadow: shadowColor != null && elevation != null && elevation! > 0
            ? [
                BoxShadow(
                  color: shadowColor!,
                  blurRadius: elevation!,
                  offset: Offset(0, -elevation! / 2),
                ),
              ]
            : null,
      ),
      child: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: onTap,
        backgroundColor: Colors.transparent, // Handled by container
        indicatorColor: indicatorColor ?? colorScheme.primaryContainer,
        labelBehavior: effectiveLabelBehavior,
        elevation: elevation ?? 0,
        height: height,
        overlayColor: overlayColor,
        indicatorShape: indicatorShape,
        destinations: items.map((item) {
          return NavigationDestination(
            icon: Icon(
              item.icon,
              color: unselectedIconColor ?? colorScheme.onSurfaceVariant,
            ),
            selectedIcon: Icon(
              item.selectedIcon ?? item.icon,
              color: selectedIconColor ?? colorScheme.onPrimaryContainer,
            ),
            label: item.label,
            tooltip: item.tooltip ?? item.label,
          );
        }).toList(),
      ),
    );
  }
}

/// A data model representing an item in the [AppNavigationBar].
class AppNavigationItem {
  final String label;
  final IconData icon;
  final IconData? selectedIcon;
  final String? tooltip;

  const AppNavigationItem({
    required this.label,
    required this.icon,
    this.selectedIcon,
    this.tooltip,
  });
}
