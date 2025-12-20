import 'package:flutter/material.dart';
import '../../foundation/radius.dart';
import '../../foundation/spacing.dart';
import '../../foundation/typography.dart';
import '../../foundation/colors.dart';

/// Type of snackbar indicating its purpose.
enum AppSnackBarType {
  /// Informational message (blue).
  info,

  /// Success message (green).
  success,

  /// Warning message (orange).
  warning,

  /// Error message (red).
  error,
}

/// Position where the snackbar appears.
enum SnackBarPosition {
  /// Appears at the top of the screen.
  top,

  /// Appears at the bottom of the screen.
  bottom,
}

/// A Material Design snackbar with type-based styling.
///
/// Provides user feedback with automatic dismissal and optional actions.
class AppSnackBar {
  /// Shows a snackbar with the given configuration.
  static void show(
    BuildContext context, {
    required String message,
    AppSnackBarType type = AppSnackBarType.info,
    Duration duration = const Duration(seconds: 4),
    String? actionLabel,
    VoidCallback? onAction,
    SnackBarPosition position = SnackBarPosition.bottom,
    bool showCloseButton = false,
    Color? backgroundColor,
    Color? textColor,
    Color? iconColor,
    double? borderRadius,
  }) {
    final config = _getConfig(type);

    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(config.icon, color: iconColor ?? AppColors.white, size: 20),
          const SizedBox(width: AppSpacing.m),
          Expanded(
            child: Text(
              message,
              style: AppTypography.bodyMedium(
                context,
              ).copyWith(color: textColor ?? AppColors.white),
            ),
          ),
        ],
      ),
      backgroundColor: backgroundColor ?? config.backgroundColor,
      duration: duration,
      behavior: SnackBarBehavior.floating,
      margin: position == SnackBarPosition.top
          ? EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + AppSpacing.m,
              left: AppSpacing.m,
              right: AppSpacing.m,
            )
          : EdgeInsets.all(AppSpacing.m),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? AppRadius.m),
      ),
      action: actionLabel != null
          ? SnackBarAction(
              label: actionLabel,
              textColor: AppColors.white,
              onPressed: onAction ?? () {},
            )
          : null,
      showCloseIcon: showCloseButton,
      closeIconColor: AppColors.white,
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static _SnackBarConfig _getConfig(AppSnackBarType type) {
    switch (type) {
      case AppSnackBarType.info:
        return _SnackBarConfig(
          icon: Icons.info_outline,
          backgroundColor: AppColors.info,
        );
      case AppSnackBarType.success:
        return _SnackBarConfig(
          icon: Icons.check_circle_outline,
          backgroundColor: AppColors.success,
        );
      case AppSnackBarType.warning:
        return _SnackBarConfig(
          icon: Icons.warning_amber_outlined,
          backgroundColor: AppColors.warning,
        );
      case AppSnackBarType.error:
        return _SnackBarConfig(
          icon: Icons.error_outline,
          backgroundColor: AppColors.error,
        );
    }
  }
}

class _SnackBarConfig {
  const _SnackBarConfig({required this.icon, required this.backgroundColor});

  final IconData icon;
  final Color backgroundColor;
}
