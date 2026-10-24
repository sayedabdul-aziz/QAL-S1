import 'package:bookia/core/routes/route_names.dart';
import 'package:bookia/core/services/dio/dio_provider.dart';
import 'package:bookia/core/styles/themes.dart';
import 'package:bookia/features/auth/presentation/login_register/cubit/auth_cubit.dart';
import 'package:bookia/features/auth/presentation/login_register/page/login_screen.dart';
import 'package:bookia/features/auth/presentation/login_register/page/register_screen.dart';
import 'package:bookia/features/spalsh/splash_screen.dart';
import 'package:bookia/features/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DioProvider.init();
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

// APIs:
// BaseUrl => https://codingarabic.eraapro.com
// Endpoint => /register , /login , /profile
// Request => Method, Params, Headers, Body
// Response => Status Code, Body

// Api Call Flow:
// UI <-> Cubit (States) <-> Data(Repository)

// Json (Map<String, dynamic>)
// X json["data"]["user"]["name"]
// json.data.user.name

// Refresh Token
// Auth Response : Access Token, Refresh Token
// Token Expired : Call Refresh Token Api (Refresh Token)

// Http, Dio

// Feature/
// Data (Models/ Repositories)
// Presentation (Cubit/ Page/ Widgets)
