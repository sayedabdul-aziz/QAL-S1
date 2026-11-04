import 'package:bookia/features/search/data/models/search_data.dart';

class SearchResponse {
  final SearchData? data;
  final String? message;
  final List<dynamic>? error;
  final int? status;

  const SearchResponse({this.data, this.message, this.error, this.status});

  factory SearchResponse.fromJson(Map<String, dynamic> json) => SearchResponse(
    data: json['data'] != null
        ? SearchData.fromJson(json['data'] as Map<String, dynamic>)
        : null,
    message: json['message'] as String?,
    error: json['error'] as List<dynamic>?,
    status: json['status'] as int?,
  );
}
