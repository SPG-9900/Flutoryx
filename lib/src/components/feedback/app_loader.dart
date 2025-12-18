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
  }) : type = AppLoaderType.circular;

  /// Creates a linear loader.
  const AppLoader.linear({super.key, this.color, this.strokeWidth})
    : type = AppLoaderType.linear,
      size = AppLoaderSize.medium;

  /// The type of loader.
  final AppLoaderType type;

  /// The size of the loader (circular only).
  final AppLoaderSize size;

  /// The color of the loader.
  final Color? color;

  /// The stroke width of the loader.
  final double? strokeWidth;

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
      return LinearProgressIndicator(color: color);
    }

    return SizedBox(
      width: _sizeValue,
      height: _sizeValue,
      child: CircularProgressIndicator(
        color: color,
        strokeWidth: strokeWidth ?? (_sizeValue / 8),
      ),
    );
  }
}
