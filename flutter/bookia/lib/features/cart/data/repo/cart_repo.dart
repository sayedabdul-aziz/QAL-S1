import 'package:bookia/core/services/dio/apis.dart';
import 'package:bookia/core/services/dio/dio_provider.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/cart/data/models/cart_response/cart_item.dart';
import 'package:bookia/features/cart/data/models/cart_response/cart_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CartRepo {
  // Parses the response AND syncs the local cache with the server's current
  // list of product IDs — mirrors the same pattern used in WishlistRepo.
  static CartResponse _mapCartResponse(Response<dynamic> response) {
    var cartResponse = CartResponse.fromJson(response.data);
    List<CartItem> items = cartResponse.data?.cartItems ?? [];
    SharedPref.setCartItems(items); // server is source of truth on success
    return cartResponse;
  }

  static Future<CartResponse?> getCart() async {
    try {
      var response = await DioProvider.getApi(
        endpoint: Apis.cart,
        headers: {"Authorization": "Bearer ${SharedPref.getToken()}"},
      );
      if (response.statusCode == 200) {
        return _mapCartResponse(response);
      }
      return null;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  static Future<CartResponse?> addToCart(int productId) async {
    try {
      var response = await DioProvider.postApi(
        endpoint: Apis.addToCart,
        data: {"product_id": productId},
        headers: {"Authorization": "Bearer ${SharedPref.getToken()}"},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return _mapCartResponse(response);
      }
      return null;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  static Future<CartResponse?> removeFromCart({required int cartItemId}) async {
    try {
      var response = await DioProvider.postApi(
        endpoint: Apis.removeFromCart,
        data: {"cart_item_id": cartItemId},
        headers: {"Authorization": "Bearer ${SharedPref.getToken()}"},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return _mapCartResponse(response);
      }
      return null;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  static Future<CartResponse?> updateCart({
    required int cartItemId,
    required int quantity,
  }) async {
    try {
      var response = await DioProvider.postApi(
        endpoint: Apis.updateCart,
        data: {"cart_item_id": cartItemId, "quantity": quantity},
        headers: {"Authorization": "Bearer ${SharedPref.getToken()}"},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return _mapCartResponse(response);
      }
      return null;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  static Future<bool> checkout() async {
    try {
      var response = await DioProvider.getApi(
        endpoint: Apis.checkout,
        headers: {"Authorization": "Bearer ${SharedPref.getToken()}"},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }
      return false;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
