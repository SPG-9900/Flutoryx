import 'package:flutter/material.dart';
import '../../foundation/typography.dart';

/// Shape of the avatar.
enum AppAvatarShape {
  /// Circular avatar.
  circle,

  /// Square avatar with rounded corners.
  square,
}

/// Size of the avatar.
enum AppAvatarSize {
  /// Small avatar (32px).
  small,

  /// Medium avatar (48px).
  medium,

  /// Large avatar (64px).
  large,

  /// Extra large avatar (96px).
  extraLarge,
}

/// A Material Design avatar component.
///
/// Displays a user avatar with support for images, initials, and icons.
class AppAvatar extends StatelessWidget {
  /// Creates an avatar with an image.
  const AppAvatar.image({
    super.key,
    required this.imageUrl,
    this.size = AppAvatarSize.medium,
    this.shape = AppAvatarShape.circle,
    this.onTap,
    this.borderRadius,
    this.borderColor,
    this.borderWidth,
    this.shadowColor,
    this.elevation,
    this.margin,
    this.padding,
    this.fit = BoxFit.cover,
  }) : initials = null,
       icon = null,
       backgroundColor = null,
       textColor = null,
       textStyle = null,
       iconSize = null;

  /// Creates an avatar with initials.
  const AppAvatar.initials({
    super.key,
    required this.initials,
    this.size = AppAvatarSize.medium,
    this.shape = AppAvatarShape.circle,
    this.backgroundColor,
    this.onTap,
    this.textColor,
    this.borderRadius,
    this.borderColor,
    this.borderWidth,
    this.shadowColor,
    this.elevation,
    this.margin,
    this.padding,
    this.textStyle,
  }) : imageUrl = null,
       icon = null,
       fit = BoxFit.cover,
       iconSize = null;

  /// Creates an avatar with an icon.
  const AppAvatar.icon({
    super.key,
    required this.icon,
    this.size = AppAvatarSize.medium,
    this.shape = AppAvatarShape.circle,
    this.backgroundColor,
    this.onTap,
    this.textColor,
    this.borderRadius,
    this.borderColor,
    this.borderWidth,
    this.shadowColor,
    this.elevation,
    this.margin,
    this.padding,
    this.iconSize,
  }) : imageUrl = null,
       initials = null,
       fit = BoxFit.cover,
       textStyle = null;

  /// The image URL for the avatar.
  final String? imageUrl;

  /// The initials to display (e.g., "JD" for John Doe).
  final String? initials;

  /// The icon to display.
  final IconData? icon;

  /// The size of the avatar.
  final AppAvatarSize size;

  /// The shape of the avatar.
  final AppAvatarShape shape;

  /// Background color for initials/icon avatars.
  final Color? backgroundColor;

  /// Called when the avatar is tapped.
  final VoidCallback? onTap;

  /// Optional text color override.
  final Color? textColor;

  /// Optional border radius override.
  final double? borderRadius;

  /// Optional border color override.
  final Color? borderColor;

  /// Optional border width override.
  final double? borderWidth;

  /// Optional shadow color.
  final Color? shadowColor;

  /// Optional elevation.
  final double? elevation;

  /// Optional margin.
  final EdgeInsetsGeometry? margin;

  /// Optional padding.
  final EdgeInsetsGeometry? padding;

  /// Optional text style for initials.
  final TextStyle? textStyle;

  /// Optional icon size override.
  final double? iconSize;

  /// Optional box fit for image avatars.
  final BoxFit fit;

  double get _size {
    switch (size) {
      case AppAvatarSize.small:
        return 32.0;
      case AppAvatarSize.medium:
        return 48.0;
      case AppAvatarSize.large:
        return 64.0;
      case AppAvatarSize.extraLarge:
        return 96.0;
    }
  }

  double get _radius {
    if (borderRadius != null) return borderRadius!;
    return shape == AppAvatarShape.circle ? _size / 2 : 8.0;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveBackgroundColor =
        backgroundColor ?? theme.colorScheme.primary.withValues(alpha: 0.1);

    Widget avatar;

    if (imageUrl != null) {
      avatar = Image.network(
        imageUrl!,
        width: _size,
        height: _size,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          return _buildFallback(context, effectiveBackgroundColor);
        },
      );
    } else {
      avatar = _buildFallback(context, effectiveBackgroundColor);
    }

    final boxDecoration = BoxDecoration(
      color: effectiveBackgroundColor,
      borderRadius: BorderRadius.circular(_radius),
      border: borderColor != null
          ? Border.all(color: borderColor!, width: borderWidth ?? 1)
          : null,
      boxShadow: elevation != null && elevation! > 0
          ? [
              BoxShadow(
                color: shadowColor ?? Colors.black.withValues(alpha: 0.2),
                blurRadius: elevation!,
                offset: Offset(0, elevation! / 2),
              ),
            ]
          : null,
    );

    Widget result = Container(
      margin: margin,
      padding: padding,
      decoration: boxDecoration,
      clipBehavior: Clip.antiAlias,
      child: avatar,
    );

    if (onTap != null) {
      result = InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(_radius),
        child: result,
      );
    }

    return result;
  }

  Widget _buildFallback(BuildContext context, Color bgColor) {
    final theme = Theme.of(context);

    return Center(
      child: initials != null
          ? Text(
              initials!.toUpperCase(),
              style:
                  textStyle ??
                  AppTypography.labelLarge(context).copyWith(
                    color: textColor ?? theme.colorScheme.onPrimaryContainer,
                    fontSize: _size * 0.4,
                  ),
            )
          : Icon(
              icon ?? Icons.person,
              size: iconSize ?? _size * 0.6,
              color: textColor ?? theme.colorScheme.onPrimaryContainer,
            ),
    );
  }
}
