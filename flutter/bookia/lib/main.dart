import 'package:bookia/core/routes/route_names.dart';
import 'package:bookia/core/styles/themes.dart';
import 'package:bookia/features/auth/login_register/cubit/auth_cubit.dart';
import 'package:bookia/features/auth/login_register/page/login_screen.dart';
import 'package:bookia/features/auth/login_register/page/register_screen.dart';
import 'package:bookia/features/spalsh/splash_screen.dart';
import 'package:bookia/features/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RouteNames.splash,
      routes: {
        RouteNames.splash: (context) => const SplashScreen(),
        RouteNames.welcome: (context) => const WelcomeScreen(),
        RouteNames.login: (context) => BlocProvider(
          create: (context) => AuthCubit(),
          child: LoginScreen(),
        ),
        RouteNames.register: (context) => BlocProvider(
          create: (context) => AuthCubit(),
          child: RegisterScreen(),
        ),
      },
      title: 'Bookia',
      theme: AppThemes.lightTheme,
    );
  }
}
