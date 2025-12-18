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

/// A Material Design card with optional header and actions.
///
/// Provides a flexible container for content with support for titles,
/// subtitles, leading/trailing widgets, and action buttons.
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (headerWidget != null) headerWidget,
        if (child != null)
          Padding(
            padding: hasHeader
                ? contentPadding.copyWith(top: AppSpacing.m)
                : contentPadding,
            child: child,
          ),
        if (actions != null && actions!.isNotEmpty) _buildActions(),
      ],
    );

    final card = _buildCardByVariant(context, theme, cardContent);

    if (onTap != null || onLongPress != null) {
      return InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        borderRadius: BorderRadius.circular(AppRadius.m),
        child: card,
      );
    }

    return card;
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.l),
      child: Row(
        children: [
          if (leading != null) ...[
            leading!,
            const SizedBox(width: AppSpacing.m),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (title != null)
                  Text(title!, style: AppTypography.titleLarge(context)),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle!,
                    style: AppTypography.bodyMedium(context).copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (trailing != null) ...[
            const SizedBox(width: AppSpacing.m),
            trailing!,
          ],
        ],
      ),
    );
  }

  Widget _buildActions() {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.m),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
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

    switch (variant) {
      case AppCardVariant.elevated:
        return Card(
          elevation: elevation ?? 1,
          margin: cardMargin,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.m),
          ),
          child: content,
        );

      case AppCardVariant.filled:
        return Card(
          elevation: 0,
          margin: cardMargin,
          color: theme.colorScheme.surfaceContainerHighest,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.m),
          ),
          child: content,
        );

      case AppCardVariant.outlined:
        return Card(
          elevation: 0,
          margin: cardMargin,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.m),
            side: BorderSide(color: theme.colorScheme.outline, width: 1),
          ),
          child: content,
        );
    }
  }
}
