class SearchState {}

class SearchInitialState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchSuccessState extends SearchState {}

/// Emitted while fetching the next page (products list is still visible).
class SearchLoadingMoreState extends SearchState {}

class SearchEmptyState extends SearchState {}

class SearchErrorState extends SearchState {
  final String message;
  SearchErrorState({this.message = 'Something went wrong'});
}
