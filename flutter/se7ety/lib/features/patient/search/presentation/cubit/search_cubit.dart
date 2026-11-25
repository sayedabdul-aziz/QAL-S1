import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se7ety/features/patient/search/data/repo/search_repo.dart';
import 'package:se7ety/features/patient/search/presentation/cubit/search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this._repo) : super(SearchInitialState());

  final SearchRepo _repo;
  Timer? _debounce;
  int _requestId = 0;

  void searchDoctors(String query, {bool debounce = true}) {
    _debounce?.cancel();
    final requestId = ++_requestId;
    final searchKey = query.trim();
    if (query.isEmpty) {
      emit(SearchLoadingState());
    }

    if (debounce) {
      _debounce = Timer(
        const Duration(milliseconds: 350),
        () => _searchDoctors(searchKey, requestId),
      );
    } else {
      unawaited(_searchDoctors(searchKey, requestId));
    }
  }

  Future<void> _searchDoctors(String query, int requestId) async {
    try {
      final doctors = await _repo.searchDoctors(query);
      if (!isClosed && requestId == _requestId) {
        emit(SearchSuccessState(doctors));
      }
    } catch (error, stackTrace) {
      if (!isClosed && requestId == _requestId) {
        addError(error, stackTrace);
        emit(SearchFailureState());
      }
    }
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
