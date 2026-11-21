import 'package:se7ety/core/presentation/enum/user_enum.dart';

class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthSuccessState extends AuthState {
  final UserTypeEnum userType;
  AuthSuccessState({required this.userType});
}

class AuthFailureState extends AuthState {
  final String message;
  AuthFailureState(this.message);
}
