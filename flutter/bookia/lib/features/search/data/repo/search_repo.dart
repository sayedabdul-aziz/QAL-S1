import 'package:bookia/core/services/dio/apis.dart';
import 'package:bookia/core/services/dio/dio_provider.dart';
import 'package:bookia/features/search/data/models/search_response.dart';
import 'package:flutter/material.dart';

class SearchRepo {
  static Future<SearchResponse?> search({
    required String query,
    int page = 1,
  }) async {
    try {
      final response = await DioProvider.getApi(
        endpoint: Apis.productsSearch,
        params: {'name': query, 'page': page},
      );
      if (response.statusCode == 200) {
        return SearchResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
