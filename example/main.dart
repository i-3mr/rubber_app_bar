import 'package:flutter/material.dart';
import 'package:rubber_app_bar/growing_container.dart';
import 'package:rubber_app_bar/rubber_app_bar.dart';
import 'package:rubber_app_bar/scale_up_container.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Travel App',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RubberAppBar(
        transitionCurve: Curves.ease,
        height: 200,
        maxExtent: 500,
        mode: RubberAppBarMode.movementDirection,
        builder: (extending) => Container(
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 9, 58, 255),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(45),
              bottomRight: Radius.circular(45),
            ),
          ),
          child: SafeArea(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text(
                    'Rubber App Bar',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 233, 233, 233),
                    ),
                  ),

                  // the condition is to render the widget only when
                  // the user is dragging the app bar downwards
                  // If you don't use this condition, you will get
                  // an overflow error when you try to drag the app bar upwards
                  if (extending > 0)
                    GrowingWidget(
                      availableHeight: extending,
                      maxHeight: 200,
                      child: const DummyWidget(
                        color: Color.fromARGB(255, 255, 204, 0),
                        height: 200,
                      ),
                    ),

                  // the condition is to render the widget only when
                  // the pervious widget is rendered and took its space
                  // 200 here represents the height of the previous widget
                  if (extending > 200)
                    // here we want to render two widgets,
                    // so we put them in a list and use the spread operator
                    ...[
                    const SizedBox(height: 20),
                    // extending - 200 is the available height for the widget
                    ScaleUpWidget(
                      availableHeight: extending - 200,
                      maxHeight: 150,
                      child: const DummyWidget(
                        color: Color.fromARGB(255, 255, 204, 0),
                        height: 150,
                      ),
                    )
                  ],
                  const Spacer(),
                  // Drag handle
                  const DragHandler(),
                ],
              ),
            ),
          ),
        ),
      ),

      // Here we are using this property to allow the app bar to be on top of the body
      // if you don't use it, the app bar will push the body down
      extendBodyBehindAppBar: true,
      body: const Center(
        child: Text(
          'This is the body!',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2A2A2A),
          ),
        ),
      ),
    );
  }
}

class DragHandler extends StatelessWidget {
  const DragHandler({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      width: 50,
      height: 5,
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

class DummyWidget extends StatelessWidget {
  final Color color;
  final double height;
  const DummyWidget({
    super.key,
    required this.color,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Center(
        child: Text(
          'Dummy Widget',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2A2A2A),
          ),
        ),
      ),
    );
  }
}
