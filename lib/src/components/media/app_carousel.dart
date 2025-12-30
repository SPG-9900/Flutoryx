import 'dart:async';
import 'package:flutter/material.dart';
import '../../foundation/radius.dart';
import '../../foundation/spacing.dart';

/// A premium, high-performance carousel for images, onboarding, and hero sections.
class AppCarousel extends StatefulWidget {
  const AppCarousel({
    super.key,
    required this.items,
    this.height = 200,
    this.autoPlay = false,
    this.autoPlayInterval = const Duration(seconds: 5),
    this.viewportFraction = 1.0,
    this.showIndicators = true,
    this.activeIndicatorColor,
    this.inactiveIndicatorColor,
    this.borderRadius,
    this.spacing = AppSpacing.m,
    this.onPageChanged,
    this.onItemTap,
    this.clipBehavior = Clip.antiAlias,
    this.enlargeCenterPage = true,
    this.enlargeFactor = 0.15,
    this.indicatorAlignment = Alignment.bottomCenter,
    this.indicatorPadding = const EdgeInsets.only(top: AppSpacing.m),
    this.infiniteLoop = true,
    this.scrollDirection = Axis.horizontal,
    this.physics,
    this.autoPlayCurve = Curves.easeInOutCubic,
    this.opacityEffect = 0.5,
    this.indicatorBuilder,
  });

  /// The widgets to display in the carousel.
  final List<Widget> items;

  /// Height of the carousel.
  final double height;

  /// Whether to automatically scroll through items.
  final bool autoPlay;

  /// The interval between auto-plays.
  final Duration autoPlayInterval;

  /// The fraction of the viewport that each item should occupy.
  /// Use values < 1.0 (e.g., 0.85) to create a "peek" effect for adjacent cards.
  final double viewportFraction;

  /// Whether to show the pagination dots.
  final bool showIndicators;

  /// Color of the active indicator dot.
  final Color? activeIndicatorColor;

  /// Color of the inactive indicator dots.
  final Color? inactiveIndicatorColor;

  /// Border radius of the carousel container.
  final double? borderRadius;

  /// Spacing between items (only effective when viewportFraction < 1).
  final double spacing;

  /// Callback when the page changes.
  final ValueChanged<int>? onPageChanged;

  /// Callback when an item is tapped.
  final ValueChanged<int>? onItemTap;

  /// Clip behavior for the items.
  final Clip clipBehavior;

  /// Whether to enlarge the center page.
  final bool enlargeCenterPage;

  /// The factor by which to enlarge the center page (0.0 to 1.0).
  final double enlargeFactor;

  /// Alignment of the indicators relative to the carousel.
  final Alignment indicatorAlignment;

  /// Padding between the carousel and the indicators.
  final EdgeInsetsGeometry indicatorPadding;

  /// Whether the carousel should loop infinitely.
  final bool infiniteLoop;

  /// The axis along which the carousel scrolls.
  final Axis scrollDirection;

  /// The scroll physics to use.
  final ScrollPhysics? physics;

  /// The curve to use for auto-play transitions.
  final Curve autoPlayCurve;

  /// The minimum opacity for non-centered items (0.0 to 1.0).
  /// Set to 1.0 to disable the effect.
  final double opacityEffect;

  /// A custom builder for the pagination indicators.
  final Widget Function(BuildContext context, int index, int total)?
  indicatorBuilder;

  @override
  State<AppCarousel> createState() => _AppCarouselState();
}

class _AppCarouselState extends State<AppCarousel> {
  late PageController _pageController;
  int _currentPage = 0;
  Timer? _autoPlayTimer;
  bool _isUserInteracting = false;

  @override
  void initState() {
    super.initState();
    final initialPage = widget.infiniteLoop ? widget.items.length * 100 : 0;
    _currentPage = widget.infiniteLoop ? 0 : 0;

    _pageController = PageController(
      viewportFraction: widget.viewportFraction,
      initialPage: initialPage,
    );
    if (widget.autoPlay) {
      _startAutoPlay();
    }
  }

  @override
  void dispose() {
    _stopAutoPlay();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoPlay() {
    _autoPlayTimer = Timer.periodic(widget.autoPlayInterval, (timer) {
      if (!_isUserInteracting && mounted && widget.items.isNotEmpty) {
        final nextPage = _pageController.page!.round() + 1;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 600),
          curve: widget.autoPlayCurve,
        );
      }
    });
  }

  void _stopAutoPlay() {
    _autoPlayTimer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final activeColor =
        widget.activeIndicatorColor ?? theme.colorScheme.primary;
    final inactiveColor =
        widget.inactiveIndicatorColor ??
        theme.colorScheme.onSurface.withValues(alpha: 0.3);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: widget.height,
          child: GestureDetector(
            onPanDown: (_) => setState(() => _isUserInteracting = true),
            onPanEnd: (_) => setState(() => _isUserInteracting = false),
            onPanCancel: () => setState(() => _isUserInteracting = false),
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.infiniteLoop ? null : widget.items.length,
              scrollDirection: widget.scrollDirection,
              physics: widget.physics ?? const BouncingScrollPhysics(),
              clipBehavior: Clip.none,
              onPageChanged: (index) {
                final realIndex = index % widget.items.length;
                setState(() => _currentPage = realIndex);
                widget.onPageChanged?.call(realIndex);
              },
              itemBuilder: (context, index) {
                final realIndex = index % widget.items.length;
                return AnimatedBuilder(
                  animation: _pageController,
                  builder: (context, child) {
                    double scale = 1.0;
                    double opacity = 1.0;

                    if (_pageController.position.hasContentDimensions) {
                      double page = _pageController.page ?? 0.0;
                      double diff = (page - index).abs();

                      // Scale Effect
                      if (widget.enlargeCenterPage) {
                        scale = (1 - (diff * widget.enlargeFactor)).clamp(
                          1 - widget.enlargeFactor,
                          1.0,
                        );
                      }

                      // Opacity Effect
                      if (widget.opacityEffect < 1.0) {
                        opacity = (1 - (diff * (1 - widget.opacityEffect)))
                            .clamp(widget.opacityEffect, 1.0);
                      }
                    } else {
                      // Initial state
                      bool isCurrent = widget.infiniteLoop
                          ? (index % widget.items.length == 0)
                          : index == _currentPage;
                      scale = isCurrent ? 1.0 : (1 - widget.enlargeFactor);
                      opacity = isCurrent ? 1.0 : widget.opacityEffect;
                    }

                    return Center(
                      child: GestureDetector(
                        onTap: () => widget.onItemTap?.call(realIndex),
                        child: Opacity(
                          opacity: opacity,
                          child: Transform.scale(
                            scale: scale,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal:
                                    widget.scrollDirection == Axis.horizontal
                                    ? widget.spacing / 2
                                    : 0,
                                vertical:
                                    widget.scrollDirection == Axis.vertical
                                    ? widget.spacing / 2
                                    : 0,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  widget.borderRadius ?? AppRadius.m,
                                ),
                                clipBehavior: widget.clipBehavior,
                                child: widget.items[realIndex],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
        if (widget.showIndicators && widget.items.length > 1)
          Padding(
            padding: widget.indicatorPadding,
            child: Align(
              alignment: widget.indicatorAlignment,
              child:
                  widget.indicatorBuilder?.call(
                    context,
                    _currentPage,
                    widget.items.length,
                  ) ??
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(widget.items.length, (index) {
                      final isActive = index == _currentPage;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height: 8,
                        width: isActive ? 24 : 8,
                        decoration: BoxDecoration(
                          color: isActive ? activeColor : inactiveColor,
                          borderRadius: BorderRadius.circular(AppRadius.full),
                        ),
                      );
                    }),
                  ),
            ),
          ),
      ],
    );
  }
}
