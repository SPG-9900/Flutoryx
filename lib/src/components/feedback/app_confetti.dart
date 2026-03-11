import 'dart:math';
import 'package:flutter/material.dart';
import '../../foundation/colors.dart';

/// A single confetti particle with its own physics and properties.
class _Particle {
  Offset position;
  Offset velocity;
  final Color color;
  final double size;
  double rotation;
  final double rotationSpeed;
  final int shapeType; // 0: Rectangle, 1: Circle, 2: Oval

  _Particle({
    required this.position,
    required this.velocity,
    required this.color,
    required this.size,
    required this.rotation,
    required this.rotationSpeed,
    required this.shapeType,
  });
}

/// A highly customizable, dependency-free Confetti overlay component.
/// It wraps a [child] widget and draws a physics-based explosion of confetti
/// over the child when [isShooting] becomes true.
class AppConfetti extends StatefulWidget {
  /// The widget that the confetti will be drawn over.
  final Widget child;

  /// Trigger to start the confetti explosion.
  /// When toggled from false to true, the confetti will explode from the center.
  final bool isShooting;

  /// The number of confetti particles to generate per explosion.
  final int particleCount;

  /// The duration of the entire explosion animation before particles disappear.
  final Duration duration;

  /// The colors to randomly apply to the confetti particles.
  final List<Color> colors;

  /// The downward gravity force applied to particles.
  final double gravity;

  /// The initial explosion burst force. Higher numbers mean particles shoot further.
  final double blastVelocity;

  /// Whether the explosion should break out of its container and explode globally across the entire screen.
  final bool fullScreen;

  const AppConfetti({
    super.key,
    required this.child,
    required this.isShooting,
    this.particleCount = 100,
    this.duration = const Duration(seconds: 4),
    this.colors = const [
      AppColors.red500,
      AppColors.emerald500,
      AppColors.blue500,
      AppColors.yellow500,
      AppColors.pink500,
      AppColors.purple500,
      AppColors.orange500,
    ],
    this.gravity = 9.8,
    this.blastVelocity = 20.0,
    this.fullScreen = false,
  });

  @override
  State<AppConfetti> createState() => _AppConfettiState();
}

class _AppConfettiState extends State<AppConfetti>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<_Particle> _particles = [];
  final Random _random = Random();
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _controller.addListener(() {
      _updatePhysics();
      if (!widget.fullScreen) {
        setState(() {});
      }
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _removeOverlay();
      }
    });

    if (widget.isShooting) {
      _shoot();
    }
  }

  @override
  void didUpdateWidget(AppConfetti oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isShooting && !oldWidget.isShooting) {
      _shoot();
    }
  }

  @override
  void dispose() {
    _removeOverlay();
    _controller.dispose();
    super.dispose();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _shoot() {
    _particles = List.generate(widget.particleCount, (index) {
      // Create a burst effect where particles shoot in all directions
      // mostly upwards and outwards.
      final angle = _random.nextDouble() * pi * 2; // Full circle
      // Favoring upward shots slightly
      final velocityMod =
          _random.nextDouble() * widget.blastVelocity +
          (widget.blastVelocity * 0.5);

      return _Particle(
        position: Offset
            .zero, // Wait for layout size, or center it immediately in painter
        velocity: Offset(
          cos(angle) * velocityMod,
          sin(angle) * velocityMod - widget.blastVelocity,
        ),
        color: widget.colors[_random.nextInt(widget.colors.length)],
        size: _random.nextDouble() * 8 + 6, // Between 6 and 14
        rotation: _random.nextDouble() * pi * 2,
        rotationSpeed: (_random.nextDouble() - 0.5) * 0.5,
        shapeType: _random.nextInt(3),
      );
    });

    if (widget.fullScreen) {
      _showOverlay();
    }
    _controller.forward(from: 0.0);
  }

  void _showOverlay() {
    if (_overlayEntry != null) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final renderBox = context.findRenderObject() as RenderBox?;
      Offset origin = Offset.zero;

      if (renderBox != null) {
        origin = renderBox.localToGlobal(renderBox.size.center(Offset.zero));
      }

      _overlayEntry = OverlayEntry(
        builder: (context) {
          return IgnorePointer(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                if (!_controller.isAnimating && _controller.isCompleted) {
                  return const SizedBox.shrink();
                }
                return CustomPaint(
                  size: Size.infinite,
                  painter: _ConfettiPainter(
                    particles: _particles,
                    opacity: 1.0 - _controller.value,
                    origin: origin,
                  ),
                );
              },
            ),
          );
        },
      );

      Overlay.of(context).insert(_overlayEntry!);
    });
  }

  void _updatePhysics() {
    for (var particle in _particles) {
      particle.position += particle.velocity;
      particle.velocity += Offset(0, widget.gravity * 0.1); // Gravity
      particle.velocity = Offset(
        particle.velocity.dx * 0.98,
        particle.velocity.dy * 0.98,
      ); // Air resistance
      particle.rotation += particle.rotationSpeed;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      children: [
        widget.child,
        if (_controller.isAnimating && !widget.fullScreen)
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(
                painter: _ConfettiPainter(
                  particles: _particles,
                  opacity: 1.0 - _controller.value, // Fade out towards the end
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _ConfettiPainter extends CustomPainter {
  final List<_Particle> particles;
  final double opacity;
  final Offset? origin;

  _ConfettiPainter({
    required this.particles,
    required this.opacity,
    this.origin,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = origin ?? Offset(size.width / 2, size.height / 2);

    for (var particle in particles) {
      final paint = Paint()..color = particle.color.withValues(alpha: opacity);
      final finalPos = center + particle.position;

      canvas.save();
      canvas.translate(finalPos.dx, finalPos.dy);
      canvas.rotate(particle.rotation);

      if (particle.shapeType == 0) {
        // Rectangle
        canvas.drawRect(
          Rect.fromCenter(
            center: Offset.zero,
            width: particle.size,
            height: particle.size * 0.6,
          ),
          paint,
        );
      } else if (particle.shapeType == 1) {
        // Circle
        canvas.drawCircle(Offset.zero, particle.size / 2, paint);
      } else {
        // Oval
        canvas.drawOval(
          Rect.fromCenter(
            center: Offset.zero,
            width: particle.size,
            height: particle.size * 1.5,
          ),
          paint,
        );
      }

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _ConfettiPainter oldDelegate) {
    return true; // Continuously animate
  }
}
