// MyApp app = MyApp();
// Person('Ahmed')

import 'package:first_app/first_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// custom widget

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: FirstScreen());
  }
}

// Shape (Circle, Rectangle, Square)
