class PaginationData<T> {
  List<T> list;
  Pagination pagination;

  PaginationData({required this.list, required this.pagination});
}

class Pagination {
  final int pageNumber;
  final bool last;
  final int totalPages;
  final int totalElements;
  final int numberOfElements;
  final bool first;
  final bool empty;

  Pagination(
      {required this.last,
      required this.totalElements,
      required this.totalPages,
      required this.empty,
      required this.first,
      required this.numberOfElements,
      required this.pageNumber});

  bool get endOfPage => !(pageNumber > totalPages);

  factory Pagination.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Pagination(
          empty: false, first: true, last: true, numberOfElements: 0, pageNumber: 0, totalElements: 0, totalPages: 0);
    }
    return Pagination(
        pageNumber: json["pageable"]["pageNumber"],
        empty: json["empty"],
        first: json["first"],
        last: json["last"],
        numberOfElements: json["numberOfElements"],
        totalElements: json["totalElements"],
        totalPages: json["totalPages"]);
  }
}
