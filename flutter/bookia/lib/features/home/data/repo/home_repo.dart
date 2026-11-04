import 'package:bookia/core/services/dio/apis.dart';
import 'package:bookia/core/services/dio/dio_provider.dart';
import 'package:bookia/features/home/data/models/best_seller_books_response/best_seller_books_response.dart';
import 'package:bookia/features/home/data/models/sliders_response/sliders_response.dart';
import 'package:flutter/material.dart';

class HomeRepo {
  static Future<SlidersResponse?> getSliders() async {
    try {
      var response = await DioProvider.getApi(endpoint: Apis.sliders);
      if (response.statusCode == 200) {
        return SlidersResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  static Future<BestSellerBooksResponse?> getBestSellerBooks() async {
    try {
      var response = await DioProvider.getApi(endpoint: Apis.bestSellerBooks);
      if (response.statusCode == 200) {
        return BestSellerBooksResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
