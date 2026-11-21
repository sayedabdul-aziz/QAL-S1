import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se7ety/core/presentation/enum/user_enum.dart';
import 'package:se7ety/core/services/firebase/firestore_provider.dart';
import 'package:se7ety/features/auth/data/models/doctor_model.dart';
import 'package:se7ety/features/auth/data/models/patient_model.dart';
import 'package:se7ety/features/auth/data/models/user_model.dart';
import 'package:se7ety/features/auth/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> login() async {
    emit(AuthLoadingState());
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      var user = credential.user;
      if (user == null) {
        emit(AuthFailureState('لا يوجد مستخدم بهذا الايميل'));
        return;
      }

      // Need to Know Type of user by Firestore (Users Collection)
      var userModel = await FirestoreProvider.getUserById(user.uid);
      // convert string to enum
      UserTypeEnum userType = UserTypeEnum.fromString(
        userModel?.userType ?? '',
      );
      emit(AuthSuccessState(userType: userType));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(AuthFailureState('لا يوجد مستخدم بهذا الايميل'));
      } else if (e.code == 'wrong-password') {
        emit(AuthFailureState('كلمة المرور غير صحيحة'));
      } else {
        emit(AuthFailureState('حدث خطأ ما'));
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(AuthFailureState('حدث خطأ ما'));
    }
  }

  Future<void> register(UserTypeEnum userType) async {
    emit(AuthLoadingState());

    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );

      // stored user data (uid, email, displayName)
      var user = credential.user;

      user?.updateDisplayName(nameController.text);
      user?.sendEmailVerification();

      // store in firestore
      var userModel = UserModel(
        uid: user?.uid,
        email: user?.email,
        name: nameController.text,
        userType: userType.name,
      );
      await FirestoreProvider.createUser(userModel);

      if (userType == UserTypeEnum.doctor) {
        var doctor = DoctorModel(
          uid: user?.uid,
          email: user?.email,
          name: nameController.text,
        );
        await FirestoreProvider.createDoctor(doctor);
      } else {
        var patient = PatientModel(
          uid: user?.uid,
          email: user?.email,
          name: nameController.text,
        );
        await FirestoreProvider.createPatient(patient);
      }

      emit(AuthSuccessState(userType: userType));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(AuthFailureState('كلمة المرور قصيرة'));
      } else if (e.code == 'email-already-in-use') {
        emit(AuthFailureState('البريد الالكتروني مستخدم بالفعل'));
      } else {
        emit(AuthFailureState('حدث خطأ ما'));
      }
    } catch (e) {
      emit(AuthFailureState('حدث خطأ ما'));
    }
  }
}

// Auth (User Data) => uid, displayName, email , photoUrl
// Firestore (Main Database)
// Patient Collection
// Doctor Collection
// Users (id) => role
//

// id,name,age,email,phone,address
// id,name,age,email,phone1,phon2,address,specialization,bio,open/close hour
