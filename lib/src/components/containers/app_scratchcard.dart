import 'dart:math';
import 'package:flutter/material.dart';

/// A point representing a scratch motion for the [AppScratchcard].
class ScratchPoint {
  final Offset? position;
  final double size;

  ScratchPoint(this.position, this.size);
}

/// How accurate the progress tracking should be.
enum ScratchAccuracy { low, medium, high }

double _getAccuracyValue(ScratchAccuracy accuracy) {
  switch (accuracy) {
    case ScratchAccuracy.low:
      return 10.0;
    case ScratchAccuracy.medium:
      return 30.0;
    case ScratchAccuracy.high:
      return 100.0;
  }
}

/// A scratchcard widget that reveals its [child] when scratched.
/// Ported and optimized for Flutoryx without external dependencies.
class AppScratchcard extends StatefulWidget {
  /// The hidden widget that is revealed when scratching the cover.
  final Widget child;

  /// The color to display over the [child] before it's scratched.
  final Color coverColor;

  /// An optional gradient to execute globally upon the rect.
  /// If provided, this will be painted over the [child], and [coverColor] will be ignored.
  final Gradient? coverGradient;

  /// The width of the scratch stroke.
  final double strokeWidth;

  /// The percentage of the area that needs to be scratched to trigger [onScratchCompleted].
  /// Value should be between 0.0 and 1.0. Defaults to 0.5 (50%).
  final double minScratchPercentage;

  /// Callback when the scratch percentage reaches or exceeds [minScratchPercentage].
  final VoidCallback? onScratchCompleted;

  /// The duration of the fade-out animation when revealed.
  final Duration revealDuration;

  /// Accuracy of scratch detection.
  final ScratchAccuracy accuracy;

  const AppScratchcard({
    super.key,
    required this.child,
    this.coverColor = Colors.grey,
    this.coverGradient,
    this.strokeWidth = 40.0,
    this.minScratchPercentage = 0.5,
    this.onScratchCompleted,
    this.revealDuration = const Duration(milliseconds: 500),
    this.accuracy = ScratchAccuracy.medium,
  }) : assert(minScratchPercentage > 0.0 && minScratchPercentage <= 1.0);

  @override
  State<AppScratchcard> createState() => _AppScratchcardState();
}

class _AppScratchcardState extends State<AppScratchcard>
    with SingleTickerProviderStateMixin {
  final List<ScratchPoint?> _points = [];
  late Set<Offset> _checkpoints;
  final Set<Offset> _checked = {};
  int _totalCheckpoints = 0;
  double _progress = 0;
  bool _thresholdReported = false;
  bool _isFinished = false;
  bool _canScratch = true;
  Size? _lastKnownSize;
  Offset? _lastPosition;

  late AnimationController _revealController;
  late Animation<double> _revealAnimation;

  @override
  void initState() {
    super.initState();
    _revealController = AnimationController(
      vsync: this,
      duration: widget.revealDuration,
    );
    _revealAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _revealController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _revealController.dispose();
    super.dispose();
  }

  void _setCheckpoints(Size size) {
    final calculated = _calculateCheckpoints(size).toSet();
    _checkpoints = calculated;
    _totalCheckpoints = calculated.length;
  }

  List<Offset> _calculateCheckpoints(Size size) {
    final accuracy = _getAccuracyValue(widget.accuracy);
    final xOffset = size.width / accuracy;
    final yOffset = size.height / accuracy;

    final points = <Offset>[];
    for (var x = 0; x < accuracy; x++) {
      for (var y = 0; y < accuracy; y++) {
        final point = Offset(x * xOffset, y * yOffset);
        points.add(point);
      }
    }
    return points;
  }

  bool _inCircle(Offset center, Offset point, double radius) {
    final dX = center.dx - point.dx;
    final dY = center.dy - point.dy;
    final multi = dX * dX + dY * dY;
    final distance = sqrt(multi).roundToDouble();
    return distance <= radius;
  }

  void _addPoint(Offset position) {
    if (_lastPosition == position) return;
    _lastPosition = position;

    Offset? point = position;
    final scratchPoint = ScratchPoint(point, widget.strokeWidth);

    if (_points.isNotEmpty && _points.last?.position == scratchPoint.position) {
      point = null;
    }

    setState(() {
      _points.add(scratchPoint);
    });

    if (point != null && !_checked.contains(point)) {
      _checked.add(point);

      final radius = widget.strokeWidth / 2;
      _checkpoints.removeWhere(
        (checkpoint) => _inCircle(checkpoint, point!, radius),
      );

      _progress =
          ((_totalCheckpoints - _checkpoints.length) / _totalCheckpoints);

      if (!_thresholdReported && _progress >= widget.minScratchPercentage) {
        _thresholdReported = true;
        _reveal();
      }

      if (_progress >= 1.0) {
        setState(() {
          _isFinished = true;
        });
      }
    }
  }

  void _reveal() {
    if (!_isFinished) {
      _revealController.forward().then((_) {
        setState(() {
          _isFinished = true;
          _canScratch = false;
        });
        widget.onScratchCompleted?.call();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: _isFinished && _revealAnimation.isCompleted
          ? widget.child
          : GestureDetector(
              behavior: HitTestBehavior.opaque,
              onPanStart: _canScratch
                  ? (details) => _addPoint(details.localPosition)
                  : null,
              onPanUpdate: _canScratch
                  ? (details) => _addPoint(details.localPosition)
                  : null,
              onPanEnd: _canScratch
                  ? (details) {
                      if (_canScratch) {
                        setState(() => _points.add(null));
                      }
                    }
                  : null,
              child: AnimatedBuilder(
                animation: _revealAnimation,
                builder: (context, child) {
                  return Stack(
                    fit: StackFit.passthrough,
                    children: [
                      widget.child,
                      Positioned.fill(
                        child: Opacity(
                          opacity: _revealAnimation.value,
                          child: CustomPaint(
                            painter: _ScratchPainter(
                              points: _points,
                              color: widget.coverColor,
                              gradient: widget.coverGradient,
                              onDraw: (size) {
                                if (_lastKnownSize == null ||
                                    _lastKnownSize != size) {
                                  WidgetsBinding.instance.addPostFrameCallback((
                                    _,
                                  ) {
                                    if (mounted) {
                                      _setCheckpoints(size);
                                    }
                                  });
                                  _lastKnownSize = size;
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
    );
  }
}

class _ScratchPainter extends CustomPainter {
  final List<ScratchPoint?> points;
  final Color color;
  final Gradient? gradient;
  final void Function(Size) onDraw;

  _ScratchPainter({
    required this.points,
    required this.color,
    this.gradient,
    required this.onDraw,
  });

  Paint _getMainPaint(double strokeWidth) {
    return Paint()
      ..strokeCap = StrokeCap.round
      ..color = Colors.transparent
      ..strokeWidth = strokeWidth
      ..blendMode = BlendMode.clear
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;
  }

  @override
  void paint(Canvas canvas, Size size) {
    onDraw(size);

    canvas.saveLayer(null, Paint());

    final areaRect = Rect.fromLTRB(0, 0, size.width, size.height);
    if (gradient != null) {
      canvas.drawRect(
        areaRect,
        Paint()..shader = gradient!.createShader(areaRect),
      );
    } else if (color != Colors.transparent) {
      canvas.drawRect(areaRect, Paint()..color = color);
    }

    var path = Path();
    var isStarted = false;
    ScratchPoint? previousPoint;

    for (final point in points) {
      if (point == null) {
        if (previousPoint != null) {
          canvas.drawPath(path, _getMainPaint(previousPoint.size));
        }
        path = Path();
        isStarted = false;
      } else {
        final position = point.position;
        if (!isStarted) {
          isStarted = true;
          path.moveTo(position!.dx, position.dy);
        } else {
          path.lineTo(position!.dx, position.dy);
        }
      }
      previousPoint = point;
    }

    if (previousPoint != null) {
      canvas.drawPath(path, _getMainPaint(previousPoint.size));
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(_ScratchPainter oldDelegate) => true;
}
