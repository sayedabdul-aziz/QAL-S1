import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se7ety/core/constants/app_images.dart';
import 'package:se7ety/core/presentation/enum/user_enum.dart';
import 'package:se7ety/core/routes/navigation.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/features/intro/splash/cubit/splash_cubit.dart';
import 'package:se7ety/features/intro/splash/cubit/splash_state.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is SplashSignedOutState) {
          pushWithReplacement(
            context,
            state.hasCompletedOnboarding ? Routes.welcome : Routes.onboarding,
          );
        } else if (state is SplashSignedInState) {
          final needsDoctorRegistration =
              state.userType == UserTypeEnum.doctor &&
              !state.isCompletedProfile;
          // The patient and doctor home routes are not registered yet.
          pushWithReplacement(
            context,
            needsDoctorRegistration
                ? Routes.doctorRegistration
                : Routes.welcome,
          );
        } else if (state is SplashFailureState) {
          pushWithReplacement(context, Routes.welcome);
        }
      },
      child: Scaffold(
        body: Center(child: Image.asset(AppImages.logo, width: 250)),
      ),
    );
  }
}
