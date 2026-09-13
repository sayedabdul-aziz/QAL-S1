import 'package:flutter/material.dart';
import 'package:greenmart/core/styles/themes.dart';
import 'package:greenmart/features/spalsh/spalsh_screen.dart';

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
      home: const SplashScreen(),
    );
  }
}
