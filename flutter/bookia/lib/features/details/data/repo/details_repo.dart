import 'package:bookia/core/services/dio/apis.dart';
import 'package:bookia/core/services/dio/dio_provider.dart';
import 'package:bookia/features/details/data/models/product_details_response.dart';
import 'package:flutter/material.dart';

class DetailsRepo {
  static Future<ProductDetailsResponse?> getProductDetails(int id) async {
    try {
      var response = await DioProvider.getApi(
        endpoint: Apis.productDetails(id),
      );
      if (response.statusCode == 200) {
        return ProductDetailsResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
