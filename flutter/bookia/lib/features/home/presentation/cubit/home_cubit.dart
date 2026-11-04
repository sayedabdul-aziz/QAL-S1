// n apis (same screen)

import 'package:bookia/features/home/data/models/best_seller_books_response/best_seller_books_response.dart';
import 'package:bookia/features/home/data/models/best_seller_books_response/product.dart';
import 'package:bookia/features/home/data/models/sliders_response/slider.dart';
import 'package:bookia/features/home/data/models/sliders_response/sliders_response.dart';
import 'package:bookia/features/home/data/repo/home_repo.dart';
import 'package:bookia/features/home/presentation/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  List<SliderModel> sliders = [];
  List<Product> bestSellerBooks = [];

  Future<void> getHomeData() async {
    emit(HomeLoadingState());

    await Future.delayed(const Duration(seconds: 2));

    // run apis in parallel
    var futures = await Future.wait([
      HomeRepo.getSliders(),
      HomeRepo.getBestSellerBooks(),
    ]);

    var slidersRes = futures[0] as SlidersResponse?;
    var bestSellerBooksRes = futures[1] as BestSellerBooksResponse?;

    if (slidersRes != null || bestSellerBooksRes != null) {
      sliders = slidersRes?.data?.sliders ?? [];
      bestSellerBooks = bestSellerBooksRes?.data?.products ?? [];
      emit(HomeSuccessState());
    } else {
      emit(HomeErrorState());
    }
  }
}
