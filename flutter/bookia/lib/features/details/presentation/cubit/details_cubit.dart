import 'package:bookia/features/details/data/repo/details_repo.dart';
import 'package:bookia/features/details/presentation/cubit/details_state.dart';
import 'package:bookia/features/home/data/models/best_seller_books_response/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit() : super(DetailsInitialState());

  Product? product;

  Future<void> getProductDetails(int id) async {
    emit(DetailsLoadingState());

    final response = await DetailsRepo.getProductDetails(id);

    if (response?.data != null) {
      product = response!.data;
      emit(DetailsSuccessState());
    } else {
      emit(DetailsErrorState());
    }
  }
}
