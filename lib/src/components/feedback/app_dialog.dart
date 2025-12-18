import 'package:flutter/material.dart';
import '../../foundation/spacing.dart';
import '../../foundation/radius.dart';
import '../../foundation/typography.dart';

/// A Material Design dialog component.
///
/// Provides a customizable dialog with title, content, and actions.
class AppDialog extends StatelessWidget {
  /// Creates a dialog.
  const AppDialog({
    super.key,
    this.title,
    this.content,
    this.actions,
    this.icon,
    this.contentPadding,
  });

  /// Optional title of the dialog.
  final String? title;

  /// The content widget of the dialog.
  final Widget? content;

  /// Action buttons displayed at the bottom.
  final List<Widget>? actions;

  /// Optional icon displayed above the title.
  final Widget? icon;

  /// Padding for the content area.
  final EdgeInsets? contentPadding;

  /// Shows a dialog with the given configuration.
  static Future<T?> show<T>({
    required BuildContext context,
    String? title,
    Widget? content,
    List<Widget>? actions,
    Widget? icon,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => AppDialog(
        title: title,
        content: content,
        actions: actions,
        icon: icon,
      ),
    );
  }

  /// Shows a confirmation dialog with OK/Cancel buttons.
  static Future<bool?> showConfirmation({
    required BuildContext context,
    required String title,
    required String message,
    String confirmText = 'OK',
    String cancelText = 'Cancel',
    bool isDangerous = false,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AppDialog(
        title: title,
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(cancelText),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: isDangerous
                ? TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.error,
                  )
                : null,
            child: Text(confirmText),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: icon,
      title: title != null
          ? Text(title!, style: AppTypography.titleLarge(context))
          : null,
      content: content,
      contentPadding:
          contentPadding ??
          const EdgeInsets.fromLTRB(
            AppSpacing.l,
            AppSpacing.m,
            AppSpacing.l,
            AppSpacing.l,
          ),
      actions: actions,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.l),
      ),
    );
  }
}
