import 'package:bookia/core/services/dio/apis.dart';
import 'package:bookia/core/services/dio/dio_provider.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/home/data/models/best_seller_books_response/product.dart';
import 'package:bookia/features/wishlist/data/models/wishlist_response/wishlist_response.dart';
import 'package:dio/src/response.dart';
import 'package:flutter/material.dart';

class WishlistRepo {
  static Future<WishlistResponse?> getWishlist() async {
    try {
      var response = await DioProvider.getApi(
        endpoint: Apis.wishlist,
        headers: {"Authorization": "Bearer ${SharedPref.getToken()}"},
      );
      if (response.statusCode == 200) {
        return _mapWishlistResponse(response);
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    }
    return null;
  }

  static Future<WishlistResponse?> removeFromWishlist(int productId) async {
    try {
      var response = await DioProvider.postApi(
        endpoint: Apis.removeFromWishlist,
        data: {"product_id": productId},
        headers: {"Authorization": "Bearer ${SharedPref.getToken()}"},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return _mapWishlistResponse(response);
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    }
    return null;
  }

  static Future<WishlistResponse?> addToWishlist(int productId) async {
    try {
      var response = await DioProvider.postApi(
        endpoint: Apis.addToWishlist,
        params: {"product_id": productId},
        headers: {"Authorization": "Bearer ${SharedPref.getToken()}"},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return _mapWishlistResponse(response);
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    }
    return null;
  }

  static WishlistResponse _mapWishlistResponse(Response<dynamic> response) {
    var wishlistResponse = WishlistResponse.fromJson(response.data);

    List<Product> products = wishlistResponse.data!.data ?? [];
    List<int> ids = products.map((e) => e.id ?? 0).toList();
    SharedPref.setWishlist(ids);
    return wishlistResponse;
  }
}
