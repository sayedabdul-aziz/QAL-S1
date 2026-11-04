class DetailsState {}

class DetailsInitialState extends DetailsState {}

class DetailsLoadingState extends DetailsState {}

class DetailsSuccessState extends DetailsState {}

class DetailsErrorState extends DetailsState {
  final String message;
  DetailsErrorState({this.message = 'Something went wrong'});
}
