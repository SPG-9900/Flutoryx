import 'package:flutter/material.dart';
import '../../foundation/spacing.dart';
import '../../foundation/radius.dart';
import '../../foundation/typography.dart';

/// Style variants for the toast.
enum AppToastType {
  /// Neutral style.
  neutral,

  /// Success style (green).
  success,

  /// Error style (red).
  error,

  /// Warning style (orange/yellow).
  warning,

  /// Information style (blue).
  info,
}

/// The position of the toast on the screen.
enum AppToastPosition {
  /// Displayed at the top.
  top,

  /// Displayed at the bottom.
  bottom,
}

/// A highly customizable Toast component following Material 3 guidelines.
class AppToast extends StatelessWidget {
  const AppToast({
    super.key,
    required this.message,
    this.type = AppToastType.neutral,
    this.icon,
    this.action,
    this.onAction,
    this.backgroundColor,
    this.textColor,
  });

  /// The text to display.
  final String message;

  /// The visual type of the toast.
  final AppToastType type;

  /// Optional custom leading icon. If not provided, a default icon is used based on [type].
  final IconData? icon;

  /// Optional action button label.
  final String? action;

  /// Optional callback when the action is tapped.
  final VoidCallback? onAction;

  /// Optional background color.
  final Color? backgroundColor;

  /// Optional text color.
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    Color bg;
    Color textAndIcon;
    IconData? defaultIcon;

    switch (type) {
      case AppToastType.success:
        bg = Colors.green.shade50;
        textAndIcon = Colors.green.shade800;
        defaultIcon = Icons.check_circle_outline;
        break;
      case AppToastType.error:
        bg = colorScheme.errorContainer;
        textAndIcon = colorScheme.onErrorContainer;
        defaultIcon = Icons.error_outline;
        break;
      case AppToastType.warning:
        bg = Colors.orange.shade50;
        textAndIcon = Colors.orange.shade900;
        defaultIcon = Icons.warning_amber;
        break;
      case AppToastType.info:
        bg = Colors.blue.shade50;
        textAndIcon = Colors.blue.shade900;
        defaultIcon = Icons.info_outline;
        break;
      case AppToastType.neutral:
        bg = colorScheme.inverseSurface;
        textAndIcon = colorScheme.onInverseSurface;
        defaultIcon = null;
        break;
    }

    final effectiveBg = backgroundColor ?? bg;
    final effectiveColor = textColor ?? textAndIcon;
    final finalIcon = icon ?? defaultIcon;

    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.l,
          vertical: AppSpacing.m,
        ),
        decoration: BoxDecoration(
          color: effectiveBg,
          borderRadius: BorderRadius.circular(AppRadius.m),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (finalIcon != null) ...[
              Icon(finalIcon, color: effectiveColor, size: 20),
              const SizedBox(width: AppSpacing.s),
            ],
            Flexible(
              child: Text(
                message,
                style: AppTypography.bodyMedium(
                  context,
                ).copyWith(color: effectiveColor, fontWeight: FontWeight.w500),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (action != null && onAction != null) ...[
              const SizedBox(width: AppSpacing.l),
              TextButton(
                onPressed: onAction,
                style: TextButton.styleFrom(
                  foregroundColor: type == AppToastType.neutral
                      ? colorScheme.inversePrimary
                      : effectiveColor,
                  minimumSize: Size.zero,
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  action!,
                  style: AppTypography.labelLarge(
                    context,
                  ).copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// A manager for displaying AppToasts via [OverlayEntry].
class AppToastManager {
  static OverlayEntry? _overlayEntry;
  static bool _isVisible = false;

  /// Shows a floating toast message.
  ///
  /// Automatically dismisses after [duration].
  static void show(
    BuildContext context, {
    required String message,
    AppToastType type = AppToastType.neutral,
    AppToastPosition position = AppToastPosition.bottom,
    IconData? icon,
    String? action,
    VoidCallback? onAction,
    Duration duration = const Duration(seconds: 3),
  }) {
    if (_isVisible) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }

    final overlay = Overlay.of(context);

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          top: position == AppToastPosition.top
              ? MediaQuery.of(context).padding.top + AppSpacing.l
              : null,
          bottom: position == AppToastPosition.bottom
              ? MediaQuery.of(context).padding.bottom + AppSpacing.xl
              : null,
          left: AppSpacing.l,
          right: AppSpacing.l,
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 300),
            curve: Curves.fastOutSlowIn,
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(
                  0,
                  position == AppToastPosition.top
                      ? -20 * (1 - value)
                      : 20 * (1 - value),
                ),
                child: Opacity(
                  opacity: value,
                  child: Align(
                    alignment: Alignment.center,
                    child: AppToast(
                      message: message,
                      type: type,
                      icon: icon,
                      action: action,
                      onAction: () {
                        onAction?.call();
                        dismiss();
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );

    _isVisible = true;
    overlay.insert(_overlayEntry!);

    Future.delayed(duration, () {
      dismiss();
    });
  }

  /// Dismisses the currently visible toast.
  static void dismiss() {
    if (_isVisible && _overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
      _isVisible = false;
    }
  }
}
