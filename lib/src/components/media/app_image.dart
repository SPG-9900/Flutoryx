import 'dart:io' as io;
import 'package:flutter/foundation.dart';
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
    this.border,
    this.boxShadow,
    this.margin,
    this.padding,
    this.opacity,
    this.color,
    this.colorBlendMode,
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
    this.border,
    this.boxShadow,
    this.margin,
    this.padding,
    this.opacity,
    this.color,
    this.colorBlendMode,
  }) : source = AppImageSource.asset,
       path = assetPath;

  /// Creates an image from a local file.
  const AppImage.file(
    String filePath, {
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.loadingWidget,
    this.errorWidget,
    this.placeholder,
    this.border,
    this.boxShadow,
    this.margin,
    this.padding,
    this.opacity,
    this.color,
    this.colorBlendMode,
  }) : source = AppImageSource.file,
       path = filePath;

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

  /// Optional border.
  final BoxBorder? border;

  /// Optional shadows.
  final List<BoxShadow>? boxShadow;

  /// Optional margin.
  final EdgeInsetsGeometry? margin;

  /// Optional padding.
  final EdgeInsetsGeometry? padding;

  /// Optional opacity.
  final double? opacity;

  /// Optional color filter.
  final Color? color;

  /// Optional color blend mode.
  final BlendMode? colorBlendMode;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (path.isEmpty) {
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
    }

    Widget imageWidget;

    switch (source) {
      case AppImageSource.network:
        imageWidget = Image.network(
          path,
          width: width,
          height: height,
          fit: fit,
          color: color,
          colorBlendMode: colorBlendMode,
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
          color: color,
          colorBlendMode: colorBlendMode,
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
        if (kIsWeb) {
          // On web, XFile.path is a blob URL, so we use Image.network
          imageWidget = Image.network(
            path,
            width: width,
            height: height,
            fit: fit,
            color: color,
            colorBlendMode: colorBlendMode,
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
        } else {
          imageWidget = Image.file(
            io.File(path),
            width: width,
            height: height,
            fit: fit,
            color: color,
            colorBlendMode: colorBlendMode,
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
        }
        break;
    }

    if (opacity != null) {
      imageWidget = Opacity(opacity: opacity!, child: imageWidget);
    }

    if (borderRadius != null || border != null || boxShadow != null) {
      imageWidget = Container(
        width: width,
        height: height,
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: borderRadius != null
              ? BorderRadius.circular(borderRadius!)
              : null,
          border: border,
          boxShadow: boxShadow,
        ),
        clipBehavior: borderRadius != null ? Clip.antiAlias : Clip.none,
        child: imageWidget,
      );
    } else if (margin != null || padding != null) {
      imageWidget = Container(
        margin: margin,
        padding: padding,
        child: imageWidget,
      );
    }

    return imageWidget;
  }
}
