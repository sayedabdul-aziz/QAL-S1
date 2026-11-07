import 'dart:async';

import 'package:bookia/features/home/data/models/best_seller_books_response/product.dart';
import 'package:bookia/features/search/data/repo/search_repo.dart';
import 'package:bookia/features/search/presentation/cubit/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitialState());

  // ── public data ───────────────────────────────────────────────────────────
  List<Product> products = [];

  bool get canLoadMore => _currentPage < _lastPage;

  // ── private state ─────────────────────────────────────────────────────────
  String _currentQuery = '';
  int _currentPage = 1;
  int _lastPage = 1;

  int totalProducts = 0;

  Timer? _debounceTimer;
  static const _debounceDuration = Duration(milliseconds: 500);

  // ── public methods ────────────────────────────────────────────────────────

  /// Called on every keystroke; debounces the actual API call by 500 ms.
  void onQueryChanged(String query) {
    _debounceTimer?.cancel();

    final trimmed = query.trim();

    if (trimmed.isEmpty) {
      products.clear();
      _currentQuery = '';
      emit(SearchInitialState());
      return;
    }

    // Show shimmer immediately so the UI feels responsive.
    emit(SearchLoadingState());

    _debounceTimer = Timer(_debounceDuration, () {
      _search(trimmed, page: 1);
    });
  }

  /// Fetch next page; called by the screen's scroll listener.
  Future<void> loadMore() async {
    if (!canLoadMore || state is SearchLoadingMoreState) return;
    emit(SearchLoadingMoreState());
    await _search(_currentQuery, page: _currentPage + 1);
  }

  // ── internal ──────────────────────────────────────────────────────────────

  Future<void> _search(String query, {required int page}) async {
    _currentQuery = query;
    _currentPage = page;

    if (page == 1) products.clear();

    final response = await SearchRepo.search(query: query, page: page);

    if (response?.data?.products != null) {
      products.addAll(response!.data!.products!);
      _lastPage = response.data!.meta?.lastPage ?? 1;
      totalProducts = response.data!.meta?.total ?? 0;

      if (products.isEmpty) {
        emit(SearchEmptyState());
      } else {
        emit(SearchSuccessState());
      }
    } else {
      // Page 1 failure → show error; later-page failure → stay on current list.
      if (page == 1) {
        emit(SearchErrorState());
      } else {
        _currentPage--; // roll back so the user can retry
        emit(SearchSuccessState());
      }
    }
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }
}
