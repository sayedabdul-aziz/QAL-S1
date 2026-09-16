import 'package:flutter/material.dart';
import 'package:taskati/core/styles/themes.dart';
import 'package:taskati/features/spalsh/splash_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
      home: SplashScreen(),
    );
  }
}
