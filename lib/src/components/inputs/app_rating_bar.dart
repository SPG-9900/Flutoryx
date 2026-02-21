import 'package:flutter/material.dart';

/// A Material 3 compliant Rating Bar for Flutter.
/// Supports fractional ratings, custom icon sizes, colors, and read-only modes.
class AppRatingBar extends StatefulWidget {
  /// Creates an AppRatingBar.
  const AppRatingBar({
    super.key,
    this.rating = 0.0,
    this.maxRating = 5,
    this.onRatingChanged,
    this.isReadOnly = false,
    this.allowHalfRating = true,
    this.size = 28.0,
    this.spacing = 4.0,
    this.filledIcon = Icons.star,
    this.halfFilledIcon = Icons.star_half,
    this.emptyIcon = Icons.star_border,
    this.filledColor,
    this.emptyColor,
  });

  /// The current rating value.
  final double rating;

  /// The maximum rating value (number of items).
  final int maxRating;

  /// Callback when the rating is changed.
  final ValueChanged<double>? onRatingChanged;

  /// Whether the rating is read-only (not interactive).
  final bool isReadOnly;

  /// Whether to allow half-star ratings.
  final bool allowHalfRating;

  /// The size of the rating icons.
  final double size;

  /// Spacing between each rating icon.
  final double spacing;

  /// The icon for a fully filled rating item.
  final IconData filledIcon;

  /// The icon for a half-filled rating item.
  final IconData halfFilledIcon;

  /// The icon for an empty rating item.
  final IconData emptyIcon;

  /// The color for filled components. Defaults to primary.
  final Color? filledColor;

  /// The color for empty components. Defaults to outline variant.
  final Color? emptyColor;

  @override
  State<AppRatingBar> createState() => _AppRatingBarState();
}

class _AppRatingBarState extends State<AppRatingBar> {
  late double _currentRating;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.rating;
  }

  @override
  void didUpdateWidget(AppRatingBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.rating != oldWidget.rating) {
      _currentRating = widget.rating;
    }
  }

  void _handleTap(double value) {
    if (widget.isReadOnly) return;
    setState(() {
      _currentRating = value;
    });
    widget.onRatingChanged?.call(_currentRating);
  }

  Widget _buildIcon(int index) {
    final theme = Theme.of(context);
    final activeColor = widget.filledColor ?? Colors.amber.shade600;
    final inactiveColor =
        widget.emptyColor ?? theme.colorScheme.surfaceContainerHighest;

    double ratingRemaining = _currentRating - index;

    IconData currentIco;
    Color currentColor;

    if (ratingRemaining >= 1.0) {
      currentIco = widget.filledIcon;
      currentColor = activeColor;
    } else if (ratingRemaining >= 0.5 && widget.allowHalfRating) {
      currentIco = widget.halfFilledIcon;
      currentColor = activeColor;
    } else {
      currentIco = widget.emptyIcon;
      currentColor = inactiveColor;
    }

    Widget iconWidget = Icon(
      currentIco,
      color: currentColor,
      size: widget.size,
    );

    if (widget.isReadOnly) {
      // If we need true fractional support (e.g. 4.2 stars) instead of discrete half stars,
      // we could use ClipRect. For now, since allowHalfRating handles the discrete 0.5 step,
      // we'll stick to full and half icons or full/empty icons.
      // If the user passes rating=4.2 and allowHalfRating=false, it shows 4.
      // If allowHalfRating=true, it shows 4.

      if (!widget.allowHalfRating &&
          ratingRemaining > 0.0 &&
          ratingRemaining < 1.0) {
        // Custom fractional logic with ClipRect could go here, but halfFilledIcon is simpler.
        // Let's implement actual fractional filling for readOnly continuous values.
        if (ratingRemaining > 0 && ratingRemaining < 1) {
          return Stack(
            children: [
              Icon(widget.emptyIcon, color: inactiveColor, size: widget.size),
              ClipRect(
                clipper: _FractionalClipper(ratingRemaining),
                child: Icon(
                  widget.filledIcon,
                  color: activeColor,
                  size: widget.size,
                ),
              ),
            ],
          );
        }
      }
      return iconWidget;
    }

    return GestureDetector(
      onTapDown: (details) {
        if (!widget.allowHalfRating) {
          _handleTap(index + 1.0);
          return;
        }

        // Tap position relative to the icon box
        final double tapPosition = details.localPosition.dx;
        if (tapPosition <= widget.size / 2) {
          _handleTap(index + 0.5);
        } else {
          _handleTap(index + 1.0);
        }
      },
      onPanUpdate: (details) {
        if (!widget.allowHalfRating) {
          // Calculate which star we are over
          final double delta = details.localPosition.dx;
          if (delta > 0 && delta <= widget.size) {
            _handleTap(index + 1.0);
          }
          return;
        }

        final double delta = details.localPosition.dx;
        if (delta <= 0) {
          // dragging out left
        } else if (delta <= widget.size / 2) {
          _handleTap(index + 0.5);
        } else if (delta <= widget.size) {
          _handleTap(index + 1.0);
        }
      },
      child: iconWidget,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: widget.spacing,
      children: List.generate(widget.maxRating, (index) {
        return _buildIcon(index);
      }),
    );
  }
}

class _FractionalClipper extends CustomClipper<Rect> {
  final double fraction;
  _FractionalClipper(this.fraction);

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0, 0, size.width * fraction, size.height);
  }

  @override
  bool shouldReclip(_FractionalClipper oldClipper) {
    return oldClipper.fraction != fraction;
  }
}
