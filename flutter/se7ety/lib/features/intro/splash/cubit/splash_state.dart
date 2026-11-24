import 'package:se7ety/core/presentation/enum/user_enum.dart';

sealed class SplashState {
  const SplashState();
}

class SplashInitialState extends SplashState {
  const SplashInitialState();
}

class SplashSignedOutState extends SplashState {
  const SplashSignedOutState({required this.hasCompletedOnboarding});

  final bool hasCompletedOnboarding;
}

class SplashSignedInState extends SplashState {
  const SplashSignedInState({
    required this.userType,
    required this.isCompletedProfile,
  });

  final UserTypeEnum userType;
  final bool isCompletedProfile;
}

class SplashFailureState extends SplashState {
  const SplashFailureState();
}
