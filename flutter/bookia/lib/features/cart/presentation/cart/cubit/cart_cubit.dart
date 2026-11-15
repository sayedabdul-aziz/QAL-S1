import 'package:bookia/features/cart/data/models/cart_response/cart_item.dart';
import 'package:bookia/features/cart/data/repo/cart_repo.dart';
import 'package:bookia/features/cart/presentation/cart/cubit/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitialState());

  List<CartItem> cartItems = [];
  String total = '0';

  Future<void> getCart() async {
    if (!isClosed) emit(CartLoadingState());
    var data = await CartRepo.getCart();
    if (data != null) {
      cartItems = data.data?.cartItems ?? [];
      total = data.data?.total ?? '0';
      if (!isClosed) emit(CartSuccessState());
    } else {
      if (!isClosed) emit(CartErrorState(message: "Failed to get cart"));
    }
  }

  Future<void> checkout() async {
    emit(CartCheckoutLoadingState());
    var data = await CartRepo.checkout();
    if (data) {
      emit(CartCheckoutSuccessState());
    } else {
      emit(CartErrorState(message: "Failed to checkout"));
    }
  }
}
