import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/services/dio/dio_provider.dart';
import 'package:bookia/core/styles/themes.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DioProvider.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: Routes.router,
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

// UI <=> Cubit(States) <=> Data(Repo)
