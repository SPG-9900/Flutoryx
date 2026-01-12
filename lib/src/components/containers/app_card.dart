import 'package:flutter/material.dart';
import '../../foundation/radius.dart';
import '../../foundation/spacing.dart';
import '../../foundation/typography.dart';

/// Visual style variants for cards.
enum AppCardVariant {
  /// Elevated card with shadow.
  elevated,

  /// Filled card with background color.
  filled,

  /// Outlined card with border.
  outlined,
}

class AppCard extends StatelessWidget {
  /// Creates a card.
  const AppCard({
    super.key,
    this.variant = AppCardVariant.elevated,
    this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.child,
    this.actions,
    this.onTap,
    this.onLongPress,
    this.padding,
    this.margin,
    this.elevation,
    this.backgroundColor,
    this.borderRadius,
    this.borderColor,
    this.borderWidth,
    this.titleStyle,
    this.subtitleStyle,
    this.headerPadding,
    this.actionsPadding,
    this.shadowColor,
    this.actionsAlignment,
    this.headerSpacing,
  });

  /// The visual style of the card.
  final AppCardVariant variant;

  /// Optional title text displayed in the card header.
  final String? title;

  /// Optional subtitle text displayed below the title.
  final String? subtitle;

  /// Optional widget displayed before the title.
  final Widget? leading;

  /// Optional widget displayed after the title.
  final Widget? trailing;

  /// The main content of the card.
  final Widget? child;

  /// Optional action buttons displayed at the bottom of the card.
  final List<Widget>? actions;

  /// Called when the card is tapped.
  final VoidCallback? onTap;

  /// Called when the card is long-pressed.
  final VoidCallback? onLongPress;

  /// Internal padding of the card.
  final EdgeInsets? padding;

  /// External margin of the card.
  final EdgeInsets? margin;

  /// The elevation of the card (only applies to elevated variant).
  final double? elevation;

  /// Optional background color override.
  final Color? backgroundColor;

  /// Optional border radius override.
  final double? borderRadius;

  /// Optional border color override.
  final Color? borderColor;

  /// Optional border width override.
  final double? borderWidth;

  /// Optional text style for the title.
  final TextStyle? titleStyle;

  /// Optional text style for the subtitle.
  final TextStyle? subtitleStyle;

  /// Optional padding for the header.
  final EdgeInsetsGeometry? headerPadding;

  /// Optional padding for the actions.
  final EdgeInsetsGeometry? actionsPadding;

  /// Optional shadow color.
  final Color? shadowColor;

  /// How the actions should be aligned.
  final MainAxisAlignment? actionsAlignment;

  /// Spacing between header elements.
  final double? headerSpacing;

  /// Creates a copy of this card with the given fields replaced by the new values.
  AppCard copyWith({
    AppCardVariant? variant,
    String? title,
    String? subtitle,
    Widget? leading,
    Widget? trailing,
    Widget? child,
    List<Widget>? actions,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    EdgeInsets? padding,
    EdgeInsets? margin,
    double? elevation,
    Color? backgroundColor,
    double? borderRadius,
    Color? borderColor,
    double? borderWidth,
    TextStyle? titleStyle,
    TextStyle? subtitleStyle,
    EdgeInsetsGeometry? headerPadding,
    EdgeInsetsGeometry? actionsPadding,
    Color? shadowColor,
    MainAxisAlignment? actionsAlignment,
    double? headerSpacing,
  }) {
    return AppCard(
      key: key,
      variant: variant ?? this.variant,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      leading: leading ?? this.leading,
      trailing: trailing ?? this.trailing,
      child: child ?? this.child,
      actions: actions ?? this.actions,
      onTap: onTap ?? this.onTap,
      onLongPress: onLongPress ?? this.onLongPress,
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      elevation: elevation ?? this.elevation,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderRadius: borderRadius ?? this.borderRadius,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      titleStyle: titleStyle ?? this.titleStyle,
      subtitleStyle: subtitleStyle ?? this.subtitleStyle,
      headerPadding: headerPadding ?? this.headerPadding,
      actionsPadding: actionsPadding ?? this.actionsPadding,
      shadowColor: shadowColor ?? this.shadowColor,
      actionsAlignment: actionsAlignment ?? this.actionsAlignment,
      headerSpacing: headerSpacing ?? this.headerSpacing,
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasHeader =
        title != null ||
        subtitle != null ||
        leading != null ||
        trailing != null;

    Widget? headerWidget;
    if (hasHeader) {
      headerWidget = _buildHeader(context);
    }

    final contentPadding = padding ?? const EdgeInsets.all(AppSpacing.l);

    final cardContent = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (headerWidget != null) headerWidget,
        if (child != null)
          Padding(
            padding: hasHeader
                ? contentPadding.copyWith(top: 0)
                : contentPadding,
            child: child!,
          ),
        if (actions != null && actions!.isNotEmpty) _buildActions(),
      ],
    );

    final card = _buildCardByVariant(context, Theme.of(context), cardContent);

    if (onTap != null || onLongPress != null) {
      return Padding(
        padding: margin ?? EdgeInsets.zero,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            onLongPress: onLongPress,
            borderRadius: BorderRadius.circular(borderRadius ?? AppRadius.m),
            child: card is Card ? card.copyWith(margin: EdgeInsets.zero) : card,
          ),
        ),
      );
    }

    return card;
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: headerPadding ?? const EdgeInsets.all(AppSpacing.l),
      child: Row(
        children: [
          if (leading != null) ...[
            leading!,
            SizedBox(width: headerSpacing ?? AppSpacing.m),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (title != null)
                  Text(
                    title!,
                    style: titleStyle ?? AppTypography.titleLarge(context),
                  ),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle!,
                    style:
                        subtitleStyle ??
                        AppTypography.bodyMedium(context).copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ],
            ),
          ),
          if (trailing != null) ...[
            SizedBox(width: headerSpacing ?? AppSpacing.m),
            trailing!,
          ],
        ],
      ),
    );
  }

  Widget _buildActions() {
    return Padding(
      padding: actionsPadding ?? const EdgeInsets.all(AppSpacing.m),
      child: Row(
        mainAxisAlignment: actionsAlignment ?? MainAxisAlignment.end,
        children: actions!
            .map(
              (action) => Padding(
                padding: const EdgeInsets.only(left: AppSpacing.s),
                child: action,
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildCardByVariant(
    BuildContext context,
    ThemeData theme,
    Widget content,
  ) {
    final cardMargin = margin ?? EdgeInsets.zero;
    final radius = borderRadius ?? AppRadius.m;

    switch (variant) {
      case AppCardVariant.elevated:
        return Card(
          elevation: elevation ?? 1,
          margin: cardMargin,
          color: backgroundColor,
          shadowColor: shadowColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
            side: borderColor != null
                ? BorderSide(color: borderColor!, width: borderWidth ?? 1)
                : BorderSide.none,
          ),
          child: content,
        );

      case AppCardVariant.filled:
        return Card(
          elevation: elevation ?? 0,
          margin: cardMargin,
          color: backgroundColor ?? theme.colorScheme.surfaceContainerHighest,
          shadowColor: shadowColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
            side: borderColor != null
                ? BorderSide(color: borderColor!, width: borderWidth ?? 1)
                : BorderSide.none,
          ),
          child: content,
        );

      case AppCardVariant.outlined:
        return Card(
          elevation: elevation ?? 0,
          margin: cardMargin,
          color: backgroundColor,
          shadowColor: shadowColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
            side: BorderSide(
              color: borderColor ?? theme.colorScheme.outline,
              width: borderWidth ?? 1,
            ),
          ),
          child: content,
        );
    }
  }
}

extension on Card {
  Card copyWith({EdgeInsetsGeometry? margin}) {
    return Card(
      key: key,
      color: color,
      shadowColor: shadowColor,
      surfaceTintColor: surfaceTintColor,
      elevation: elevation,
      shape: shape,
      borderOnForeground: borderOnForeground,
      margin: margin ?? this.margin,
      clipBehavior: clipBehavior,
      child: child,
      semanticContainer: semanticContainer,
    );
  }
}
