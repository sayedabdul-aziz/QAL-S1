import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/wishlist/data/repo/wishlist_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'wishlist_action_state.dart';

class WishlistActionCubit extends Cubit<WishlistActionState> {
  WishlistActionCubit() : super(WishlistActionInitial());

  Future<void> addOrRemoveFromWishlist(int productId) async {
    bool isInWishlist = checkIfProductInWishlist(productId);
    if (isInWishlist) {
      // Offline-First
      offlineRemoving(productId);
      var data = await WishlistRepo.removeFromWishlist(productId);
      if (data != null) {
        emit(WishlistActionSuccess());
      } else {
        offlineAdding(productId);
        emit(WishlistActionError());
      }
    } else {
      // Offline-First
      offlineAdding(productId);
      var data = await WishlistRepo.addToWishlist(productId);
      if (data != null) {
        emit(WishlistActionSuccess());
      } else {
        offlineRemoving(productId);
        emit(WishlistActionError());
      }
    }
  }

  void offlineAdding(int productId) {
    List<int> wishlistIds = SharedPref.getWishlist();
    wishlistIds.add(productId);
    SharedPref.setWishlist(wishlistIds);
    emit(WishlistActionSuccess());
  }

  void offlineRemoving(int productId) {
    List<int> wishlistIds = SharedPref.getWishlist();
    wishlistIds.remove(productId);
    SharedPref.setWishlist(wishlistIds);
    emit(WishlistActionSuccess());
  }

  bool checkIfProductInWishlist(int productId) {
    // Using Caching
    // Every Fetching Wishlist from Server => Caching wishlist ids
    // Every Adding/Removing From Wishlist => Caching wishlist ids
    // Every Adding/Removing From Wishlist => Check if product in wishlist (Caching wishlist ids)
    List<int> wishlistIds = SharedPref.getWishlist();
    return wishlistIds.contains(productId);
  }
}
