import 'package:flutter/material.dart';

/// Type of loading indicator.
enum AppLoaderType {
  /// Circular progress indicator.
  circular,

  /// Linear progress indicator.
  linear,
}

/// Size of the loader.
enum AppLoaderSize {
  /// Small loader (16px).
  small,

  /// Medium loader (24px).
  medium,

  /// Large loader (48px).
  large,
}

/// A consistent loading indicator component.
///
/// Provides circular and linear loading indicators with customizable sizes.
class AppLoader extends StatelessWidget {
  /// Creates a circular loader.
  const AppLoader.circular({
    super.key,
    this.size = AppLoaderSize.medium,
    this.color,
    this.strokeWidth,
    this.backgroundColor,
    this.value,
    this.strokeCap,
    this.borderRadius,
    this.width,
  }) : type = AppLoaderType.circular;

  /// Creates a linear loader.
  const AppLoader.linear({
    super.key,
    this.color,
    this.strokeWidth,
    this.backgroundColor,
    this.value,
    this.strokeCap,
    this.borderRadius,
    this.width,
  }) : type = AppLoaderType.linear,
       size = AppLoaderSize.medium;

  /// The type of loader.
  final AppLoaderType type;

  /// The size of the loader (circular only).
  final AppLoaderSize size;

  /// The color of the loader.
  final Color? color;

  /// The stroke width of the loader.
  final double? strokeWidth;

  /// Optional background color.
  final Color? backgroundColor;

  /// Optional progress value (0.0 to 1.0).
  final double? value;

  /// Optional stroke cap.
  final StrokeCap? strokeCap;

  /// Optional border radius (linear only).
  final double? borderRadius;

  /// Optional width (linear only).
  final double? width;

  double get _sizeValue {
    switch (size) {
      case AppLoaderSize.small:
        return 16.0;
      case AppLoaderSize.medium:
        return 24.0;
      case AppLoaderSize.large:
        return 48.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (type == AppLoaderType.linear) {
      final loader = LinearProgressIndicator(
        color: color,
        backgroundColor: backgroundColor,
        value: value,
        minHeight: strokeWidth,
        borderRadius: borderRadius != null
            ? BorderRadius.circular(borderRadius!)
            : (strokeCap == StrokeCap.round
                  ? BorderRadius.circular(strokeWidth ?? 4)
                  : BorderRadius.zero),
      );

      if (width != null) {
        return SizedBox(width: width, child: loader);
      }
      return loader;
    }

    return SizedBox(
      width: _sizeValue,
      height: _sizeValue,
      child: CircularProgressIndicator(
        color: color,
        backgroundColor: backgroundColor,
        value: value,
        strokeWidth: strokeWidth ?? (_sizeValue / 8),
        strokeCap: strokeCap,
      ),
    );
  }
}
