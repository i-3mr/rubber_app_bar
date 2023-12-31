# Rubber App Bar Flutter Package

## Description

The `rubber_app_bar` Flutter package is designed to enhance your app's user interface by providing a flexible and customizable Rubber App Bar. This package allows developers to create app bars that smoothly expand, contract, and transform based on user interactions.

## Key Features

- Smoothly expand, contract, and transform based on user interactions
- Customizable
- Flexible
- Easy to use

## Installation

```bash
  flutter pub add rubber_app_bar
```

## How to use

### 1. Put the `RubberAppBar` widget in the `appBar` property of the `Scaffold` widget

```dart
Scaffold(
  appBar: RubberAppBar(
    // ...
  ),
  // ...
)
```

### 2. Set the `height` property to the height of the app bar when it is collapsed

```dart
Scaffold(
  appBar: RubberAppBar(
    height: 200,
    // ...
  ),
  // ...
)
```

### 3. Set the `maxExtent` property to the height of the app bar when it is expanded

```dart
Scaffold(
  appBar: RubberAppBar(
    height: 200,
    maxExtent: 500,
    // ...
  ),
  // ...
)
```

### 4. Set the `builder` property to a function that returns the app bar's content (Your Custom Widget)

```dart
Scaffold(
  appBar: RubberAppBar(
    height: 200,
    maxExtent: 500,
    builder: (extending) => YourCustomWidget(),
    // ...
  ),
  // ...
)
```

### 5. Use the `extending` parameter to control the app bar's content

You will see that the builder gives you a parameter called `extending` which is the realtime expanding value of the app bar.
You can use this value to render your widgets conditionally based on the expanding value. For example, I want to render a widget with a height of 200 when the app bar is expanded to 200.

```dart
Scaffold(
  appBar: RubberAppBar(
    height: 200,
    maxExtent: 500,
    builder: (extending) => Column(
      children: [
        if (extending > 200)
          Container(
            height: 200,
            color: Colors.red,
          ),
      ],
    ),
    )
    // ...
  ),
```

### 5.A. Use the `extending` parameter in a better way

You can move, scale, rotate or do whatever you want with the widgets based on the `extending` value. For example, I want to scale up a widget from 0 to 1 as the app bar expands from 200 to 300.

```dart
Scaffold(
  appBar: RubberAppBar(
    height: 200,
    maxExtent: 500,
    builder: (extending) => Column(
      children: [
        if (extending > 200)
          Transform.scale(
            // (extending >= 300 ? 100 : (extending - 200)) == a range between [0, 100],
            // so we divide it by 100 to get [0, 1]
            scale: (extending >= 300 ? 100 : (extending - 200)) / 100,
            child: Container(
              height: 200,
              color: Colors.red,
            ),
          ),
      ],
    ),
    )
    // ...
  ),
```

### 6. Use the `mode` property to control the app bar's behavior

The default behavior of the app bar is to expand when the user drags it downwards and contract when the user drags it upwards. You can change this behavior by setting the `mode` property to `RubberAppBarMode.movementDirection` or `RubberAppBarMode.halfway`. The `RubberAppBarMode.movementDirection` mode will expand the app bar when the user drags it downwards and contract it when the user drags it upwards. The `RubberAppBarMode.halfway` mode will expand the app bar when the user drags it downwards and contract it when the user drags it upwards until it reaches the half of the `maxExtent` value, then it will expand the app bar when the user drags it upwards and contract it when the user drags it downwards.

```dart
Scaffold(
  appBar: RubberAppBar(
    height: 200,
    maxExtent: 500,
    mode: RubberAppBarMode.movementDirection,
    builder: (extending) => YourCustomWidget(),
    )
    // ...
  ),
```

### 7. Use the `transitionCurve` property to control the app bar's transition curve

The default transition curve of the app bar is `Curves.ease`. You can change this curve by setting the `transitionCurve` property to any curve you want.

```dart
Scaffold(
  appBar: RubberAppBar(
    height: 200,
    maxExtent: 500,
    transitionCurve: Curves.ease,
    builder: (extending) => YourCustomWidget(),
    )
    // ...
  ),
```

### 8. Use the `extendBodyBehindAppBar` property to control the app bar's position

The default position of the app bar is on top of the body. So as the app bar expands, it pushes the body down. You can change this behavior by setting the `extendBodyBehindAppBar` Scaffold's property to `true`. This will allow the app bar to be on top of the body. So as the app bar expands, it will be on top of the body.

```dart
Scaffold(
  extendBodyBehindAppBar: true,
  appBar: RubberAppBar(
    height: 200,
    maxExtent: 500,
    builder: (extending) => YourCustomWidget(),
    )
    // ...
  ),
```

### 9. Start your Scaffold body with a `SizedBox` widget with a height of `YourCustomWidget`'s height

In order to prevent the first top part of the body from being hidden behind the app bar, you need to start your Scaffold body with a `SizedBox` widget with a height of `YourCustomWidget`'s height. For example, if your `YourCustomWidget`'s height is 200, you need to start your Scaffold body with a `SizedBox` widget with a height of 200 as the first child in a `Column` for example.

```dart
Scaffold(
  extendBodyBehindAppBar: true,
  appBar: RubberAppBar(
    height: 200,
    maxExtent: 500,
    builder: (extending) => YourCustomWidget(),
    )
    body: Column(
      children: [
        // This is the first child
        SizedBox(height: 200),
        // The rest of the body
        // ...
      ],
    ),
  ),
```

## Example

```dart
import 'package:flutter/material.dart';
import 'package:rubber_app_bar/growing_widget.dart';
import 'package:rubber_app_bar/rubber_app_bar.dart';
import 'package:rubber_app_bar/scale_up_widget.dart';

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

```

## Demo

<img src="https://lh3.googleusercontent.com/drive-viewer/AEYmBYRtV34KNJV0a5gVmAuTdfi35EPQxbIDT7L0KBvuJ7VzvSbD476NxCAxPFL98kpCPjPfcXnzzIsr05qs5d_r1LgEXrmvhw=w2879-h1625" width="300" height="600" />
