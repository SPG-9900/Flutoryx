import 'package:flutter/material.dart';
import '../../foundation/radius.dart';

enum AppSkeletonVariant { circle, rectangle, text }

/// A modern shimmer-based loading placeholder.
class AppSkeleton extends StatefulWidget {
  final double? width;
  final double? height;
  final AppSkeletonVariant variant;
  final BorderRadius? borderRadius;

  const AppSkeleton({
    super.key,
    this.width,
    this.height,
    this.variant = AppSkeletonVariant.rectangle,
    this.borderRadius,
  });

  /// Shorthand for a circular skeleton.
  const AppSkeleton.circle({super.key, required double size})
    : width = size,
      height = size,
      variant = AppSkeletonVariant.circle,
      borderRadius = null;

  /// Shorthand for a text line skeleton.
  const AppSkeleton.text({super.key, this.width, this.height = 12})
    : variant = AppSkeletonVariant.text,
      borderRadius = null;

  @override
  State<AppSkeleton> createState() => _AppSkeletonState();
}

class _AppSkeletonState extends State<AppSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    _animation = Tween<double>(begin: -2.0, end: 2.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final baseColor = isDark ? Colors.grey[800]! : Colors.grey[300]!;
    final highlightColor = isDark ? Colors.grey[700]! : Colors.grey[100]!;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            shape: widget.variant == AppSkeletonVariant.circle
                ? BoxShape.circle
                : BoxShape.rectangle,
            borderRadius: widget.variant == AppSkeletonVariant.circle
                ? null
                : widget.borderRadius ??
                      (widget.variant == AppSkeletonVariant.text
                          ? AppRadius.roundedS
                          : AppRadius.roundedM),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [baseColor, highlightColor, baseColor],
              stops: [0.0, (_animation.value + 1.0) / 2.0, 1.0],
              transform: _SlidingGradientTransform(_animation.value),
            ),
          ),
        );
      },
    );
  }
}

class _SlidingGradientTransform extends GradientTransform {
  final double percentile;

  const _SlidingGradientTransform(this.percentile);

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * percentile, 0.0, 0.0);
  }
}
