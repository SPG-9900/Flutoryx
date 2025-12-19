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

  const AppNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
    this.showLabels = true,
    this.backgroundColor,
    this.indicatorColor,
  }) : assert(items.length >= 2, 'NavigationBar must have at least 2 items');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      backgroundColor: backgroundColor ?? colorScheme.surface,
      indicatorColor: indicatorColor ?? colorScheme.primaryContainer,
      labelBehavior: showLabels
          ? NavigationDestinationLabelBehavior.alwaysShow
          : NavigationDestinationLabelBehavior.onlyShowSelected,
      elevation: 0,
      destinations: items.map((item) {
        return NavigationDestination(
          icon: Icon(item.icon, color: colorScheme.onSurfaceVariant),
          selectedIcon: Icon(
            item.selectedIcon ?? item.icon,
            color: colorScheme.onPrimaryContainer,
          ),
          label: item.label,
          tooltip: item.tooltip ?? item.label,
        );
      }).toList(),
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
