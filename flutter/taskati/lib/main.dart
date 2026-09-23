import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:taskati/core/styles/themes.dart';
import 'package:taskati/features/spalsh/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // init all services
  await Hive.initFlutter();
  await Hive.openBox('userBox');
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

// Data Source (Business)

// Local DB =>
// Remote DB => Firebase/Supabase , Backend API
// Assets
// static

// check network? get feed from api(cache to local) : get from local db
// after login => cache user data in local db, check cached data => get profile from api

// Caching:
// 1) little DB (Primitive) => Shared Preferences / Secure Storage
// 2) heavy DB (Objects) => Hive / SQLite
