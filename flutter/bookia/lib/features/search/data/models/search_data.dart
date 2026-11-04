import 'package:bookia/features/home/data/models/best_seller_books_response/product.dart';
import 'package:bookia/features/search/data/models/search_meta.dart';

class SearchData {
  final List<Product>? products;
  final SearchMeta? meta;

  const SearchData({this.products, this.meta});

  factory SearchData.fromJson(Map<String, dynamic> json) => SearchData(
    products: (json['products'] as List<dynamic>?)
        ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
        .toList(),
    meta: json['meta'] != null
        ? SearchMeta.fromJson(json['meta'] as Map<String, dynamic>)
        : null,
  );
}
