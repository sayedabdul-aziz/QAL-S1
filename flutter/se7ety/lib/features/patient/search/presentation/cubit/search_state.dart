import 'package:se7ety/features/auth/data/models/doctor_model.dart';

sealed class SearchState {}

class SearchInitialState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchSuccessState extends SearchState {
  final List<DoctorModel> doctors;

  SearchSuccessState(this.doctors);
}

class SearchFailureState extends SearchState {}
