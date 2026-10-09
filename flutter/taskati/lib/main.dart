import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:taskati/core/services/local/hive_provider.dart';
import 'package:taskati/core/styles/themes.dart';
import 'package:taskati/features/spalsh/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // init all services
  await HiveProvider.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: HiveProvider.userBox.listenable(),
      builder: (context, value, child) {
        bool isDark = HiveProvider.getData(HiveProvider.kIsDark) ?? false;
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          home: SplashScreen(),
        );
      },
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

//! Themes
// light and dark palette => token (textPrimary, textSecondary, background)
