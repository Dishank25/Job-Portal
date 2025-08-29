class CollegesListResponse {
  final List<String> colleges;

  CollegesListResponse({required this.colleges});

  factory CollegesListResponse.fromJson(Map<String, dynamic> json) {
    return CollegesListResponse(
      colleges: List<String>.from(json['data'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'colleges': colleges,
    };
  }
}
