import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/cart/data/models/cart_response/cart_item.dart';
import 'package:bookia/features/cart/data/repo/cart_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_action_state.dart';

class CartActionCubit extends Cubit<CartActionState> {
  CartActionCubit() : super(CartActionInitial());

  int cartItemId = 0;
  int quantity = 1;
  int stock = 0;

  void addToCart(int productId) async {
    offlineAdding(productId);
    var data = await CartRepo.addToCart(productId);
    if (data != null) {
      getCartItemIdById(productId, data.data?.cartItems ?? []);
      getStock(productId, data.data?.cartItems ?? []);
      emit(CartActionSuccess());
    } else {
      offlineRemoving(productId);
      emit(CartActionError());
    }
  }

  Future<void> updatePlus(int productId) async {
    quantity++;
    emit(CartActionSuccess());
    var data = await CartRepo.updateCart(
      cartItemId: cartItemId,
      quantity: quantity,
    );
    if (data != null) {
      getStock(productId, data.data?.cartItems ?? []);
      emit(CartActionSuccess());
    } else {
      quantity--;
      emit(CartActionError());
    }
  }

  Future<void> removeFromCart(int productId) async {
    offlineRemoving(productId);
    var data = await CartRepo.removeFromCart(cartItemId: cartItemId);
    if (data != null) {
      emit(CartActionSuccess());
    } else {
      offlineAdding(productId);
      emit(CartActionError());
    }
  }

  Future<void> updateMinus(int productId) async {
    quantity--;
    emit(CartActionSuccess());
    var data = await CartRepo.updateCart(
      cartItemId: cartItemId,
      quantity: quantity,
    );
    if (data != null) {
      getStock(productId, data.data?.cartItems ?? []);
      emit(CartActionSuccess());
    } else {
      quantity++;
      emit(CartActionError());
    }
  }

  void offlineAdding(int productId) {
    List<CartItem> cartItems = SharedPref.getCartItems();
    // Placeholder item — real data (itemId, stock, etc.) is written back
    // by _mapCartResponse once the API call succeeds.
    cartItems.add(CartItem(itemProductId: productId));
    SharedPref.setCartItems(cartItems);
    emit(CartActionSuccess());
  }

  void offlineRemoving(int productId) {
    List<CartItem> cartItems = SharedPref.getCartItems();
    cartItems.removeWhere((e) => e.itemProductId == productId);
    SharedPref.setCartItems(cartItems);
    emit(CartActionSuccess());
  }

  void getCartItemIdById(int productId, List<CartItem> items) {
    CartItem cartItem = items.firstWhere(
      (element) => element.itemProductId == productId,
    );
    cartItemId = cartItem.itemId ?? 0;
  }

  void getStock(int productId, List<CartItem> items) {
    CartItem cartItem = items.firstWhere(
      (element) => element.itemProductId == productId,
    );
    stock = cartItem.itemProductStock ?? 0;
  }

  bool checkIfProductInCart(int productId) {
    List<CartItem> cartItems = SharedPref.getCartItems();
    int index = cartItems.indexWhere((e) => e.itemProductId == productId);
    if (index != -1) {
      // Hydrate cubit fields from cache so updatePlus / updateMinus /
      // removeFromCart all work correctly on a fresh widget build —
      // no prior addToCart call needed in the same session.
      cartItemId = cartItems[index].itemId ?? 0;
      stock = cartItems[index].itemProductStock ?? 0;
      quantity = cartItems[index].itemQuantity ?? 1;
      return true;
    }
    return false;
  }
}
