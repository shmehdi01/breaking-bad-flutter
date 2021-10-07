class PaginationRequest {
    final int limit;
    final int offset;

    PaginationRequest({required this.limit, required this.offset});

    Map<String, dynamic> toParams() => {'limit': limit, 'offset': offset} ;
}