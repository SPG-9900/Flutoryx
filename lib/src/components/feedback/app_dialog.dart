import 'package:flutter/material.dart';
import '../../foundation/spacing.dart';
import '../../foundation/radius.dart';
import '../../foundation/typography.dart';
import '../buttons/app_button.dart';
import '../text/app_text.dart';

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
    this.showCloseButton = false,
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

  /// Whether to show a close icon in the top-right corner.
  final bool showCloseButton;

  /// Shows a dialog with the given configuration.
  static Future<T?> show<T>({
    required BuildContext context,
    String? title,
    Widget? content,
    List<Widget>? actions,
    Widget? icon,
    bool barrierDismissible = true,
    bool showCloseButton = false,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => AppDialog(
        title: title,
        content: content,
        actions: actions,
        icon: icon,
        showCloseButton: showCloseButton,
      ),
    );
  }

  /// Shows a confirmation dialog with customizable OK/Cancel buttons.
  static Future<bool?> showConfirmation({
    required BuildContext context,
    required String title,
    required String message,
    String confirmLabel = 'Confirm',
    String cancelLabel = 'Cancel',
    AppButtonVariant confirmVariant = AppButtonVariant.primary,
    AppButtonVariant cancelVariant = AppButtonVariant.ghost,
    bool showCloseButton = false,
    bool showCancelButton = true,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AppDialog(
        title: title,
        showCloseButton: showCloseButton,
        content: AppText(message, variant: AppTextVariant.bodyMedium),
        actions: [
          if (showCancelButton)
            AppButton(
              label: cancelLabel,
              variant: cancelVariant,
              onPressed: () => Navigator.of(context).pop(false),
            ),
          AppButton(
            label: confirmLabel,
            variant: confirmVariant,
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: icon,
      title: (title != null || showCloseButton)
          ? Stack(
              clipBehavior: Clip.none,
              children: [
                if (title != null)
                  Padding(
                    padding: EdgeInsets.only(
                      right: showCloseButton ? AppSpacing.xl : 0,
                    ),
                    child: Text(
                      title!,
                      style: AppTypography.titleLarge(context),
                    ),
                  ),
                if (showCloseButton)
                  Positioned(
                    right: -AppSpacing.m,
                    top: -AppSpacing.m,
                    child: IconButton(
                      icon: const Icon(Icons.close, size: 20),
                      onPressed: () => Navigator.of(context).pop(),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      splashRadius: 20,
                    ),
                  ),
              ],
            )
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
      actionsPadding: const EdgeInsets.fromLTRB(
        AppSpacing.l,
        0,
        AppSpacing.l,
        AppSpacing.l,
      ),
      shape: const RoundedRectangleBorder(borderRadius: AppRadius.roundedL),
    );
  }
}
