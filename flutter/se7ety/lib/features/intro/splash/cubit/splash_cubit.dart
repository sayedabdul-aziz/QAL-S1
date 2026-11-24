import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se7ety/core/presentation/enum/user_enum.dart';
import 'package:se7ety/core/services/firebase/firestore_provider.dart';
import 'package:se7ety/core/services/local/shared_pref.dart';
import 'package:se7ety/features/intro/splash/cubit/splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashInitialState());

  Future<void> checkUserFlow() async {
    await Future<void>.delayed(const Duration(seconds: 2));
    if (isClosed) return;

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        emit(
          SplashSignedOutState(
            hasCompletedOnboarding: SharedPref.getOnboarding(),
          ),
        );
        return;
      }

      final profile = await FirestoreProvider.getUserById(user.uid);
      if (isClosed) return;

      emit(
        SplashSignedInState(
          userType: UserTypeEnum.fromString(profile?.userType ?? ''),
          isCompletedProfile: profile?.isCompletedProfile == true,
        ),
      );
    } catch (error) {
      debugPrint(error.toString());
      if (!isClosed) emit(const SplashFailureState());
    }
  }
}
