import 'package:flutter/material.dart';
import '../../foundation/radius.dart';
import '../../foundation/colors.dart';

enum AppSkeletonVariant { circle, rectangle, text }

/// A modern shimmer-based loading placeholder.
class AppSkeleton extends StatefulWidget {
  final double? width;
  final double? height;
  final AppSkeletonVariant variant;
  final BorderRadius? borderRadius;
  final Color? baseColor;
  final Color? highlightColor;
  final Duration? duration;
  final Curve? curve;
  final AlignmentGeometry? begin;
  final AlignmentGeometry? end;
  final bool enabled;
  final Color? borderColor;
  final double? borderWidth;

  const AppSkeleton({
    super.key,
    this.width,
    this.height,
    this.variant = AppSkeletonVariant.rectangle,
    this.borderRadius,
    this.baseColor,
    this.highlightColor,
    this.duration,
    this.curve,
    this.begin,
    this.end,
    this.enabled = true,
    this.borderColor,
    this.borderWidth,
  });

  /// Shorthand for a circular skeleton.
  const AppSkeleton.circle({
    super.key,
    required double size,
    this.baseColor,
    this.highlightColor,
    this.duration,
    this.curve,
    this.begin,
    this.end,
    this.enabled = true,
    this.borderColor,
    this.borderWidth,
  }) : width = size,
       height = size,
       variant = AppSkeletonVariant.circle,
       borderRadius = null;

  /// Shorthand for a text line skeleton.
  const AppSkeleton.text({
    super.key,
    this.width,
    this.height = 12,
    this.baseColor,
    this.highlightColor,
    this.duration,
    this.curve,
    this.begin,
    this.end,
    this.enabled = true,
    this.borderColor,
    this.borderWidth,
  }) : variant = AppSkeletonVariant.text,
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
      duration: widget.duration ?? const Duration(milliseconds: 1500),
    );

    if (widget.enabled) {
      _controller.repeat();
    }

    _animation = Tween<double>(begin: -2.0, end: 2.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.curve ?? Curves.easeInOutSine,
      ),
    );
  }

  @override
  void didUpdateWidget(AppSkeleton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.enabled != oldWidget.enabled) {
      if (widget.enabled) {
        _controller.repeat();
      } else {
        _controller.stop();
      }
    }
    if (widget.duration != oldWidget.duration) {
      _controller.duration =
          widget.duration ?? const Duration(milliseconds: 1500);
    }
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

    final effectiveBaseColor =
        widget.baseColor ?? (isDark ? AppColors.grey800 : AppColors.grey300);
    final effectiveHighlightColor =
        widget.highlightColor ??
        (isDark ? AppColors.grey700 : AppColors.grey100);

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
            border: widget.borderColor != null
                ? Border.all(
                    color: widget.borderColor!,
                    width: widget.borderWidth ?? 1,
                  )
                : null,
            gradient: widget.enabled
                ? LinearGradient(
                    begin: widget.begin ?? Alignment.topLeft,
                    end: widget.end ?? Alignment.bottomRight,
                    colors: [
                      effectiveBaseColor,
                      effectiveHighlightColor,
                      effectiveBaseColor,
                    ],
                    stops: [0.0, (_animation.value + 1.0) / 2.0, 1.0],
                    transform: _SlidingGradientTransform(_animation.value),
                  )
                : null,
            color: widget.enabled ? null : effectiveBaseColor,
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
