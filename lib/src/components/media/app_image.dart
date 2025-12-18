import 'package:flutter/material.dart';

/// Source type for images.
enum AppImageSource {
  /// Network image URL.
  network,

  /// Asset image path.
  asset,

  /// File image path.
  file,
}

/// A universal image widget with loading and error states.
///
/// Handles different image sources (network, asset, file) with
/// consistent loading and error handling.
class AppImage extends StatelessWidget {
  /// Creates an image from a network URL.
  const AppImage.network(
    String url, {
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.loadingWidget,
    this.errorWidget,
    this.placeholder,
  }) : source = AppImageSource.network,
       path = url;

  /// Creates an image from an asset.
  const AppImage.asset(
    String assetPath, {
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.loadingWidget,
    this.errorWidget,
    this.placeholder,
  }) : source = AppImageSource.asset,
       path = assetPath;

  /// The source type of the image.
  final AppImageSource source;

  /// The path or URL of the image.
  final String path;

  /// The width of the image.
  final double? width;

  /// The height of the image.
  final double? height;

  /// How the image should be inscribed into the space.
  final BoxFit fit;

  /// Border radius for rounded corners.
  final double? borderRadius;

  /// Widget to show while loading (network images only).
  final Widget? loadingWidget;

  /// Widget to show on error.
  final Widget? errorWidget;

  /// Placeholder widget to show before image loads.
  final Widget? placeholder;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget imageWidget;

    switch (source) {
      case AppImageSource.network:
        imageWidget = Image.network(
          path,
          width: width,
          height: height,
          fit: fit,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return loadingWidget ??
                Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
          },
          errorBuilder: (context, error, stackTrace) {
            return errorWidget ??
                Container(
                  width: width,
                  height: height,
                  color: theme.colorScheme.surfaceContainerHighest,
                  child: Icon(
                    Icons.broken_image_outlined,
                    color: theme.colorScheme.onSurfaceVariant,
                    size: 48,
                  ),
                );
          },
        );
        break;

      case AppImageSource.asset:
        imageWidget = Image.asset(
          path,
          width: width,
          height: height,
          fit: fit,
          errorBuilder: (context, error, stackTrace) {
            return errorWidget ??
                Container(
                  width: width,
                  height: height,
                  color: theme.colorScheme.surfaceContainerHighest,
                  child: Icon(
                    Icons.broken_image_outlined,
                    color: theme.colorScheme.onSurfaceVariant,
                    size: 48,
                  ),
                );
          },
        );
        break;

      case AppImageSource.file:
        // File images would require dart:io which isn't available on web
        imageWidget = Container(
          width: width,
          height: height,
          color: theme.colorScheme.surfaceContainerHighest,
          child: const Center(child: Text('File images not supported on web')),
        );
        break;
    }

    if (borderRadius != null) {
      imageWidget = ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius!),
        child: imageWidget,
      );
    }

    return imageWidget;
  }
}
