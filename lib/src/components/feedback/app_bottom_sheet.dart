import 'package:flutter/material.dart';
import '../../foundation/spacing.dart';
import '../../foundation/radius.dart';

/// A Material Design bottom sheet component.
///
/// Provides a customizable bottom sheet that slides up from the bottom.
class AppBottomSheet extends StatelessWidget {
  /// Creates a bottom sheet.
  const AppBottomSheet({
    super.key,
    this.title,
    required this.child,
    this.showDragHandle = true,
    this.padding,
    this.backgroundColor,
    this.borderRadius,
  });

  /// Optional title displayed at the top.
  final String? title;

  /// The content of the bottom sheet.
  final Widget child;

  /// Whether to show the drag handle.
  final bool showDragHandle;

  /// Padding for the content.
  final EdgeInsets? padding;

  /// Optional background color.
  final Color? backgroundColor;

  /// Optional top border radius.
  final double? borderRadius;

  /// Shows a modal bottom sheet.
  static Future<T?> show<T>({
    required BuildContext context,
    String? title,
    required Widget child,
    bool showDragHandle = true,
    bool isDismissible = true,
    bool enableDrag = true,
    Color? backgroundColor,
    double? borderRadius,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      isScrollControlled: true,
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(borderRadius ?? AppRadius.l),
        ),
      ),
      builder: (context) => AppBottomSheet(
        title: title,
        showDragHandle: showDragHandle,
        backgroundColor: backgroundColor,
        borderRadius: borderRadius,
        child: child,
      ),
    );
  }

  /// Shows a scrollable bottom sheet with a list of items.
  static Future<T?> showList<T>({
    required BuildContext context,
    String? title,
    required List<Widget> items,
    bool showDragHandle = true,
    Color? backgroundColor,
    double? borderRadius,
  }) {
    return show<T>(
      context: context,
      title: title,
      showDragHandle: showDragHandle,
      backgroundColor: backgroundColor,
      borderRadius: borderRadius,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: items.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) => items[index],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(borderRadius ?? 28), // Default M3 radius
        ),
      ),
      padding:
          padding ??
          EdgeInsets.only(
            left: AppSpacing.l,
            right: AppSpacing.l,
            top: showDragHandle ? AppSpacing.s : AppSpacing.l,
            bottom: AppSpacing.l + MediaQuery.of(context).viewInsets.bottom,
          ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showDragHandle)
            Center(
              child: Container(
                width: 32,
                height: 4,
                margin: const EdgeInsets.only(bottom: AppSpacing.m),
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          if (title != null) ...[
            Text(title!, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: AppSpacing.m),
          ],
          child,
        ],
      ),
    );
  }
}
