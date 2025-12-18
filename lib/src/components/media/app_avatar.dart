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
  }) : initials = null,
       icon = null,
       backgroundColor = null;

  /// Creates an avatar with initials.
  const AppAvatar.initials({
    super.key,
    required this.initials,
    this.size = AppAvatarSize.medium,
    this.shape = AppAvatarShape.circle,
    this.backgroundColor,
    this.onTap,
  }) : imageUrl = null,
       icon = null;

  /// Creates an avatar with an icon.
  const AppAvatar.icon({
    super.key,
    required this.icon,
    this.size = AppAvatarSize.medium,
    this.shape = AppAvatarShape.circle,
    this.backgroundColor,
    this.onTap,
  }) : imageUrl = null,
       initials = null;

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
    return shape == AppAvatarShape.circle ? _size / 2 : 8.0;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveBackgroundColor =
        backgroundColor ?? theme.colorScheme.primaryContainer;

    Widget avatar;

    if (imageUrl != null) {
      avatar = ClipRRect(
        borderRadius: BorderRadius.circular(_radius),
        child: Image.network(
          imageUrl!,
          width: _size,
          height: _size,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _buildFallback(context, effectiveBackgroundColor);
          },
        ),
      );
    } else {
      avatar = _buildFallback(context, effectiveBackgroundColor);
    }

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(_radius),
        child: avatar,
      );
    }

    return avatar;
  }

  Widget _buildFallback(BuildContext context, Color bgColor) {
    final theme = Theme.of(context);

    return Container(
      width: _size,
      height: _size,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(_radius),
      ),
      child: Center(
        child: initials != null
            ? Text(
                initials!.toUpperCase(),
                style: AppTypography.labelLarge(context).copyWith(
                  color: theme.colorScheme.onPrimaryContainer,
                  fontSize: _size * 0.4,
                ),
              )
            : Icon(
                icon ?? Icons.person,
                size: _size * 0.6,
                color: theme.colorScheme.onPrimaryContainer,
              ),
      ),
    );
  }
}
