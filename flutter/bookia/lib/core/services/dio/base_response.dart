class BaseResponse<T> {
  T? data;
  String? message;
  List<dynamic>? error;
  int? status;

  BaseResponse({this.data, this.message, this.error, this.status});

  factory BaseResponse.fromJson(Map<String, dynamic> json) => BaseResponse(
    data: json['data'] as T?,
    message: json['message'] as String?,
    error: json['error'] as List<dynamic>?,
    status: json['status'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'data': data,
    'message': message,
    'error': error,
    'status': status,
  };
}
