import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rubber_app_bar/rubber_app_bar.dart';

void main() {
  testWidgets('RubberAppBar expands and collapses correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: RubberAppBar(
            height: 56.0,
            maxExtent: 200.0,
            builder: (double extent) {
              return Container(
                height: extent,
                color: Colors.blue,
              );
            },
          ),
          body: Container(),
        ),
      ),
    );

    // Verify initial state
// Verify initial state
    expect(find.byType(RubberAppBar), findsOneWidget);
    expect(find.byType(GestureDetector), findsOneWidget);
    expect(find.byType(AnimatedContainer), findsOneWidget);
    expect(find.byType(Container), findsNWidgets(3)); // Update this line

    expect(tester.getSize(find.byType(RubberAppBar).first).height,
        56.0); // Update this line

    // Expand the RubberAppBar
    await tester.drag(find.byType(GestureDetector), Offset(0, 300));
    await tester.pumpAndSettle();

    // Verify expanded state
    expect(tester.getSize(find.byType(Container).first).height,
        greaterThan(56.0)); // Update this line

    // Collapse the RubberAppBar
    await tester.drag(find.byType(GestureDetector), Offset(0, -300));
    await tester.pumpAndSettle();

    // Verify collapsed state
    expect(tester.getSize(find.byType(RubberAppBar).first).height,
        lessThanOrEqualTo(56.0)); // Update this line
  });
}
