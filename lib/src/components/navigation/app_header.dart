import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../foundation/colors.dart';
import '../../foundation/typography.dart';
import '../../foundation/spacing.dart';

/// A premium top app bar component that integrates with the Flutoryx design system.
///
/// This component implements [PreferredSizeWidget] and can be used directly in
/// [Scaffold.appBar].
class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  /// The primary widget displayed in the app bar.
  ///
  /// Typically a [Text] widget containing a description of the current contents
  /// of the app.
  final String title;

  /// A widget to display before the [title].
  ///
  /// Typically an [Icon] or an [IconButton] widget which contains an icon.
  final Widget? leading;

  /// A list of Widgets to display in a row after the [title].
  ///
  /// Typically these widgets are [IconButton]s representing common operations.
  final List<Widget>? actions;

  /// Whether the title should be centered.
  ///
  /// Defaults to true on iOS and false on Android.
  final bool? centerTitle;

  /// The z-coordinate at which to place this app bar relative to its parent.
  ///
  /// This controls the size of the shadow below the app bar.
  final double? elevation;

  /// The background color to use for the app bar.
  ///
  /// If null, [ColorScheme.surface] is used.
  final Color? backgroundColor;

  /// The color to use for the app bar's content (title, icons, etc.).
  ///
  /// If null, [ColorScheme.onSurface] is used.
  final Color? foregroundColor;

  /// This widget appears across the bottom of the app bar.
  ///
  /// Typically a [TabBar]. Only widgets that implement [PreferredSizeWidget] can
  /// be used at the bottom of an app bar.
  final PreferredSizeWidget? bottom;

  /// The system overlay style to use for the system status bar.
  final SystemUiOverlayStyle? systemOverlayStyle;

  /// Creates a premium app header.
  const AppHeader({
    super.key,
    required this.title,
    this.leading,
    this.actions,
    this.centerTitle,
    this.elevation,
    this.backgroundColor,
    this.foregroundColor,
    this.bottom,
    this.systemOverlayStyle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final effectiveBackgroundColor = backgroundColor ?? colorScheme.surface;
    final effectiveForegroundColor = foregroundColor ?? colorScheme.onSurface;

    return AppBar(
      title: Text(
        title,
        style: AppTypography.titleLarge(context).copyWith(
          color: effectiveForegroundColor,
          fontWeight: FontWeight.w600,
        ),
      ),
      leading: leading,
      actions: actions != null
          ? [...actions!, const SizedBox(width: AppSpacing.s)]
          : null,
      centerTitle: centerTitle,
      elevation: elevation ?? 0,
      scrolledUnderElevation: elevation ?? 2,
      backgroundColor: effectiveBackgroundColor,
      foregroundColor: effectiveForegroundColor,
      surfaceTintColor: effectiveBackgroundColor,
      bottom: bottom,
      systemOverlayStyle: systemOverlayStyle,
      shadowColor: AppColors.slate900.withValues(alpha: 0.1),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0.0));
}
