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

  const AppEmptyState({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.actionLabel,
    this.onActionPressed,
    this.iconSize = 80,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: iconSize,
              color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
            ),
            const SizedBox(height: AppSpacing.l),
            AppText(
              title,
              variant: AppTextVariant.headlineSmall,
              textAlign: TextAlign.center,
            ),
            if (subtitle != null) ...[
              const SizedBox(height: AppSpacing.s),
              AppText(
                subtitle!,
                variant: AppTextVariant.bodyMedium,
                textAlign: TextAlign.center,
                color: colorScheme.onSurfaceVariant,
              ),
            ],
            if (actionLabel != null && onActionPressed != null) ...[
              const SizedBox(height: AppSpacing.xl),
              AppButton(
                label: actionLabel!,
                onPressed: onActionPressed,
                variant: AppButtonVariant.primary,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
