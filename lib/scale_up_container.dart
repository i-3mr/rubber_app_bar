import 'package:flutter/material.dart';

/// A widget that scales up its child based on the available height.
///
/// The [ScaleUpWidget] scales up its child widget based on the available height
/// and a maximum height value. It calculates the scale factor based on the
/// available height and applies it to the child widget using a [Transform.scale]
/// widget. The scaled child widget is then wrapped in a [SizedBox] to limit its
/// height and width based on the scale factor.
///
/// The [availableHeight] parameter specifies the available height for scaling.
/// The [child] parameter is the widget to be scaled up. The [maxHeight] parameter
/// defines the maximum height for the scaled child widget.
///
/// Example usage:
///
/// ```dart
/// ScaleUpWidget(
///   availableHeight: 300,
///   child: Container(
///     color: Colors.blue,
///   ),
///   maxHeight: 200,
/// )
/// ```
class ScaleUpWidget extends StatelessWidget {
  final double availableHeight;
  final Widget child;
  final double maxHeight;

  /// Creates a [ScaleUpWidget].
  ///
  /// The [availableHeight] parameter specifies the available height for scaling.
  /// The [child] parameter is the widget to be scaled up. The [maxHeight] parameter
  /// defines the maximum height for the scaled child widget.
  const ScaleUpWidget({
    super.key,
    required this.availableHeight,
    required this.child,
    required this.maxHeight,
  });

  @override
  Widget build(BuildContext context) {
    final double ratio = availableHeight / 100 - 1;
    final double scale = ratio >= 1 ? 1 : (ratio < 0 ? 0 : ratio);
    return LayoutBuilder(
      builder: (context, constraints) => Transform.scale(
        scale: scale,
        child: SizedBox(
          height: maxHeight * scale,
          width: constraints.maxWidth * scale,
          child: child,
        ),
      ),
    );
  }
}
