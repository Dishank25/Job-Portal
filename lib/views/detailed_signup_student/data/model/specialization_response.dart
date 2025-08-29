class SpecializationListResponse {
  final List<String> specialization;

  SpecializationListResponse({required this.specialization});

  factory SpecializationListResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> data = json['data'] ?? [];
    final List<String> specializationNames = data
        .map((item) =>
            item['name'] as String? ??
            '') // Extract name from each specialization object
        .where((name) => name.isNotEmpty) // Filter out empty names
        .toList();

    return SpecializationListResponse(
      specialization: specializationNames, // Now this is List<String>
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'specialization': specialization,
    };
  }
}
