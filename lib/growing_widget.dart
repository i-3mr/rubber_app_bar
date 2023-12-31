import 'package:flutter/material.dart';

/// A widget that grows to fit the available height up to a maximum height.
class GrowingWidget extends StatelessWidget {
  final double availableHeight;
  final double maxHeight;
  final Widget child;

  /// Creates a [GrowingWidget].
  ///
  /// The [child] is the widget to be displayed inside the [GrowingWidget].
  /// The [availableHeight] is the maximum height that the [GrowingWidget] can grow to.
  /// The [maxHeight] is the maximum height that the [GrowingWidget] can reach.
  const GrowingWidget({
    super.key,
    required this.child,
    required this.availableHeight,
    required this.maxHeight,
  });

  @override
  Widget build(BuildContext context) {
    final double height =
        availableHeight > maxHeight ? maxHeight : availableHeight;
    return SizedBox(
      height: height,
      child: child,
    );
  }
}
