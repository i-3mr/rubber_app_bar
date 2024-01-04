import 'package:flutter/material.dart';

/// A widget that applies a scale-up animation to its child.
///
/// The animation starts from a scale of 0.0 and ends at a scale of 1.0.
/// The duration of the animation can be customized using the [duration] parameter.
/// The animation curve can be customized using the [curve] parameter.
/// An optional [delay] can be provided to delay the start of the animation.
///
/// Example usage:
/// ```dart
/// ScaleUp(
///   child: Container(
///     width: 100,
///     height: 100,
///     color: Colors.blue,
///   ),
///   duration: Duration(milliseconds: 500),
///   curve: Curves.easeInOut,
///   delay: Duration(milliseconds: 200),
/// )
/// ```
class ScaleUpTransition extends StatefulWidget {
  /// The child widget to apply the scale-up animation to.
  final Widget child;

  /// The duration of the animation.
  ///
  /// Defaults to 200 milliseconds.
  final Duration? delay;

  /// The delay before starting the animation.
  ///
  /// Defaults to no delay.
  final Duration duration;

  /// The curve of the animation.
  ///
  /// Defaults to [Curves.easeOutBack].
  final Curve curve;

  final double initialScale;
  final double endScale;

  const ScaleUpTransition({
    super.key,
    required this.child,
    this.delay,
    this.duration = const Duration(milliseconds: 200),
    this.curve = Curves.easeOutBack,
    this.initialScale = 0.0,
    this.endScale = 1.0,
  });

  @override
  State<ScaleUpTransition> createState() => _ScaleUpTransitionState();
}

class _ScaleUpTransitionState extends State<ScaleUpTransition>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation =
        Tween<double>(begin: widget.initialScale, end: widget.endScale).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.curve,
      ),
    );

    Future.delayed(widget.delay ?? Duration.zero, () {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      child: widget.child,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation.value,
          child: child,
        );
      },
    );
  }
}
