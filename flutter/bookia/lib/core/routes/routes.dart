import 'package:bookia/core/routes/route_names.dart';
import 'package:bookia/features/auth/presentation/login_register/cubit/auth_cubit.dart';
import 'package:bookia/features/auth/presentation/login_register/page/login_screen.dart';
import 'package:bookia/features/auth/presentation/login_register/page/register_screen.dart';
import 'package:bookia/features/details/presentation/cubit/details_cubit.dart';
import 'package:bookia/features/details/presentation/page/details_screen.dart';
import 'package:bookia/features/main/main_app_screen.dart';
import 'package:bookia/features/search/presentation/cubit/search_cubit.dart';
import 'package:bookia/features/search/presentation/page/search_screen.dart';
import 'package:bookia/features/spalsh/splash_screen.dart';
import 'package:bookia/features/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class Routes {
  static final GoRouter router = GoRouter(
    initialLocation: RouteNames.splash,
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(
        path: RouteNames.splash,
        name: RouteNames.splash,
        builder: (context, state) => SplashScreen(),
      ),
      GoRoute(
        path: RouteNames.welcome,
        name: RouteNames.welcome,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: RouteNames.login,
        name: RouteNames.login,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        path: RouteNames.register,
        name: RouteNames.register,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: const RegisterScreen(),
        ),
      ),

      GoRoute(
        path: RouteNames.main,
        name: RouteNames.main,
        builder: (context, state) => const MainAppScreen(),
      ),

      GoRoute(
        path: RouteNames.details,
        name: RouteNames.details,
        builder: (context, state) {
          var id = state.extra as int;
          return BlocProvider(
            create: (_) => DetailsCubit(),
            child: DetailsScreen(productId: id),
          );
        },
      ),

      GoRoute(
        path: RouteNames.search,
        name: RouteNames.search,
        builder: (context, state) => BlocProvider(
          create: (_) => SearchCubit(),
          child: const SearchScreen(),
        ),
      ),
    ],
  );
}
