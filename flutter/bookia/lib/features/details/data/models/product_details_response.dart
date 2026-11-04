import 'package:bookia/features/home/data/models/best_seller_books_response/product.dart';

class ProductDetailsResponse {
  Product? data;
  String? message;
  int? status;

  ProductDetailsResponse({this.data, this.message, this.status});

  factory ProductDetailsResponse.fromJson(Map<String, dynamic> json) =>
      ProductDetailsResponse(
        data: json['data'] != null
            ? Product.fromJson(json['data'] as Map<String, dynamic>)
            : null,
        message: json['message'] as String?,
        status: json['status'] as int?,
      );
}
