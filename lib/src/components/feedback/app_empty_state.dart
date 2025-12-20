import 'package:flutter/material.dart';
import '../../foundation/spacing.dart';
import '../buttons/app_button.dart';
import '../text/app_text.dart';
import '../../foundation/typography.dart';

/// A consistent screen/widget to show when there is no data.
class AppEmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final String? actionLabel;
  final VoidCallback? onActionPressed;
  final double? iconSize;

  /// Optional background color.
  final Color? backgroundColor;

  /// Optional border radius.
  final double? borderRadius;

  /// Optional title text style.
  final TextStyle? titleStyle;

  /// Optional content/subtitle text style.
  final TextStyle? contentStyle;

  /// Optional icon color.
  final Color? iconColor;

  /// Optional action button variant.
  final AppButtonVariant actionVariant;

  /// Optional padding.
  final EdgeInsetsGeometry? padding;

  /// Spacing between elements.
  final double? spacing;

  /// Optional image to show instead of icon.
  final Widget? image;

  /// Optional image height.
  final double? imageHeight;

  /// Optional image width.
  final double? imageWidth;

  /// Optional cross axis alignment.
  final CrossAxisAlignment crossAxisAlignment;

  const AppEmptyState({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.actionLabel,
    this.onActionPressed,
    this.iconSize = 80,
    this.backgroundColor,
    this.borderRadius,
    this.titleStyle,
    this.contentStyle,
    this.iconColor,
    this.actionVariant = AppButtonVariant.primary,
    this.padding,
    this.spacing,
    this.image,
    this.imageHeight,
    this.imageWidth,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final effectivePadding = padding ?? const EdgeInsets.all(AppSpacing.xl);
    final effectiveSpacing = spacing ?? AppSpacing.l;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius != null
            ? BorderRadius.circular(borderRadius!)
            : null,
      ),
      child: Center(
        child: Padding(
          padding: effectivePadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: crossAxisAlignment,
            children: [
              if (image != null)
                SizedBox(height: imageHeight, width: imageWidth, child: image!)
              else
                Icon(
                  icon,
                  size: iconSize,
                  color:
                      iconColor ??
                      colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                ),
              SizedBox(height: effectiveSpacing),
              AppText(
                title,
                variant: AppTextVariant.headlineSmall,
                textAlign: crossAxisAlignment == CrossAxisAlignment.center
                    ? TextAlign.center
                    : TextAlign.start,
                style: titleStyle,
              ),
              if (subtitle != null) ...[
                SizedBox(height: effectiveSpacing / 2),
                AppText(
                  subtitle!,
                  variant: AppTextVariant.bodyMedium,
                  textAlign: crossAxisAlignment == CrossAxisAlignment.center
                      ? TextAlign.center
                      : TextAlign.start,
                  color: colorScheme.onSurfaceVariant,
                  style: contentStyle,
                ),
              ],
              if (actionLabel != null && onActionPressed != null) ...[
                SizedBox(height: effectiveSpacing * 1.5),
                AppButton(
                  label: actionLabel!,
                  onPressed: onActionPressed,
                  variant: actionVariant,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
