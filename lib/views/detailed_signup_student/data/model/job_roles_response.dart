class JobrolesListResponse {
  final List<String> jobroles;

  JobrolesListResponse({required this.jobroles});

  factory JobrolesListResponse.fromJson(Map<String, dynamic> json) {
    return JobrolesListResponse(
      jobroles: List<String>.from(json['jobroles'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'jobroles': jobroles,
    };
  }
}
