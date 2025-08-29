class CollegesListResponse {
  final List<String> colleges;

  CollegesListResponse({required this.colleges});

  factory CollegesListResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> data = json['data'] ?? [];
    final List<String> collegeNames = data
        .map((item) =>
            item['name'] as String? ??
            '') // Extract name from each college object
        .where((name) => name.isNotEmpty) // Filter out empty names
        .toList();

    return CollegesListResponse(
      colleges: collegeNames, // Now this is List<String>
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'colleges': colleges,
    };
  }
}
