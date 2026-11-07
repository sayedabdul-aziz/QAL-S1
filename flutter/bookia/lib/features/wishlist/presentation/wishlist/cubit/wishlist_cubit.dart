import 'package:bookia/features/home/data/models/best_seller_books_response/product.dart';
import 'package:bookia/features/wishlist/data/repo/wishlist_repo.dart';
import 'package:bookia/features/wishlist/presentation/wishlist/cubit/wishlist_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit() : super(WishlistInitialState());

  List<Product> products = [];

  int totalProducts = 0;

  Future<void> getWishlist() async {
    emit(WishlistLoadingState());
    var data = await WishlistRepo.getWishlist();
    if (data != null) {
      products = data.data!.data!;
      totalProducts = data.data!.total ?? 0;
      emit(WishlistSuccessState());
    } else {
      emit(WishlistErrorState(message: "Failed to get wishlist"));
    }
  }
}
