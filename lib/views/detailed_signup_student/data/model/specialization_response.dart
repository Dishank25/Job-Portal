class SpecializationListResponse {
  final List<String> specialization;

  SpecializationListResponse({required this.specialization});

  factory SpecializationListResponse.fromJson(Map<String, dynamic> json) {
    return SpecializationListResponse(
      specialization: List<String>.from(json['specialization'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'specialization': specialization,
    };
  }
}
