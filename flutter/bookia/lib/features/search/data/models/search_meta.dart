class SearchMeta {
  final int? total;
  final int? perPage;
  final int? currentPage;
  final int? lastPage;

  const SearchMeta({this.total, this.perPage, this.currentPage, this.lastPage});

  factory SearchMeta.fromJson(Map<String, dynamic> json) => SearchMeta(
    total: json['total'] as int?,
    perPage: json['per_page'] as int?,
    currentPage: json['current_page'] as int?,
    lastPage: json['last_page'] as int?,
  );
}
