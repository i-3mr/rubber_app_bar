/// A customizable app bar that can be expanded and collapsed with rubber-like behavior.
///
/// The [RubberAppBar] is a widget that provides a flexible app bar that can be expanded and collapsed
/// with a rubber-like behavior. It allows you to specify the initial height, maximum extent, and
/// transition duration of the app bar. You can also define callbacks for when the app bar is going up,
/// going down, reaching the top, or reaching the bottom.
///
/// The [RubberAppBar] can be used as a regular [AppBar] by setting the [mode] property to
/// [RubberAppBarMode.movementDirection]. In this mode, the app bar will expand and collapse based on
/// the direction of the user's gesture. Alternatively, you can set the [mode] property to
/// [RubberAppBarMode.halfWay] to make the app bar always expand halfway or collapse halfway.
///
/// To use the [RubberAppBar], simply wrap it around your content and provide a builder function that
/// returns the content based on the current extent of the app bar. The extent value can be used to
/// animate the content based on the app bar's height.
///
/// Example usage:
///
/// ```dart
/// RubberAppBar(
///   height: 100,
///   maxExtent: 200,
///   transitionDuration: Duration(milliseconds: 500),
///   mode: RubberAppBarMode.movementDirection,
///   builder: (double extent) {
///     return Container(
///       height: extent,
///       color: Colors.blue,
///       child: Text('Content'),
///     );
///   },
/// )
/// ```
import 'dart:math' show pow;
import 'package:flutter/material.dart';

/// Enum representing the mode of the RubberAppBar.
///
/// The [RubberAppBarMode] is the continuation mode after the user takes their finger off the screen.
/// - [halfWay]: if the app bar height is more than half of the maximum extent, the app bar will expand. Otherwise, it will collapse.
/// - [movementDirection]: if the user's gesture is moving up, the app bar will go up.
enum RubberAppBarMode {
  halfWay,
  movementDirection,
}

class RubberAppBar extends StatefulWidget implements PreferredSizeWidget {
  const RubberAppBar({
    Key? key,
    required this.height,
    required this.maxExtent,
    required this.builder,
    this.transitionDuration = const Duration(milliseconds: 500),
    this.transitionCurve = Curves.ease,
    this.onGoingUp,
    this.onGoingDown,
    this.onReachedTop,
    this.onReachedDown,
    this.mode = RubberAppBarMode.movementDirection,
  }) : super(key: key);

  final double height;
  final double maxExtent;
  final Duration transitionDuration;
  final Curve transitionCurve;
  final RubberAppBarMode mode;
  final void Function(double)? onGoingUp;
  final void Function(double)? onGoingDown;
  final VoidCallback? onReachedTop;
  final VoidCallback? onReachedDown;
  final Widget Function(double) builder;

  @override
  State<RubberAppBar> createState() => _RubberAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(height + maxExtent);
}

class _RubberAppBarState extends State<RubberAppBar> {
  bool _isExpanded = false;
  double _currentExtent = 0;
  double dy = 0;

  void _updateExtent(double delta) {
    if (_currentExtent + dy > widget.maxExtent + 20) {
      _currentExtent = widget.maxExtent;
      return;
    } else if (_currentExtent + dy < -15) {
      _currentExtent = 0;
      return;
    }
    if (_currentExtent + dy > widget.maxExtent) {
      _currentExtent += dy / pow(_currentExtent, 0.5);
    } else if (_currentExtent + dy < 0) {
      _currentExtent += dy / pow(widget.maxExtent - _currentExtent, 0.5);
    } else {
      _currentExtent += dy;

      if (dy > 0) {
        widget.onGoingDown?.call((_currentExtent / widget.maxExtent) * 100);
      } else {
        widget.onGoingUp?.call((_currentExtent / widget.maxExtent) * 100);
      }
    }
  }

  void _updateExtentByDirection(double delta) {
    if (dy > 0) {
      _currentExtent = widget.maxExtent;

      Future.delayed(widget.transitionDuration, widget.onReachedDown);
    } else {
      _currentExtent = 0;
      Future.delayed(widget.transitionDuration, widget.onReachedTop);
    }
  }

  void _updateExtentHalfWay(double delta) {
    if (_currentExtent + dy > widget.maxExtent / 2) {
      _currentExtent = widget.maxExtent;
      Future.delayed(widget.transitionDuration, widget.onReachedDown);
    } else {
      _currentExtent = 0;
      Future.delayed(widget.transitionDuration, widget.onReachedTop);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          _isExpanded = true;
          dy = details.delta.dy;
          _updateExtent(dy);
        });
      },
      onPanEnd: (details) {
        setState(() {
          switch (widget.mode) {
            case RubberAppBarMode.halfWay:
              _updateExtentHalfWay(dy);
              break;
            case RubberAppBarMode.movementDirection:
              _updateExtentByDirection(dy);
              break;
          }
          _isExpanded = false;
        });
      },
      child: TweenAnimationBuilder<double>(
        duration: _isExpanded ? Duration.zero : widget.transitionDuration,
        curve: widget.transitionCurve,
        tween: Tween<double>(
          begin: _currentExtent,
          end: _currentExtent + widget.height,
        ),
        builder: (BuildContext context, double value, Widget? child) {
          return SizedBox(
            height: value,
            child: widget.builder(value - widget.height),
          );
        },
      ),
    );
  }
}
