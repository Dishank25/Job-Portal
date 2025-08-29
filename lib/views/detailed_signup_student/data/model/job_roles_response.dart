class JobrolesListResponse {
  final List<String> jobroles;

  JobrolesListResponse({required this.jobroles});

  factory JobrolesListResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> data = json['data'] ?? [];
    final List<String> jobroleTitles = data
        .map((item) =>
            item['title'] as String? ?? '') // Extract TITLE (not name)
        .where((title) => title.isNotEmpty)
        .toList();

    return JobrolesListResponse(
      jobroles: jobroleTitles,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'jobroles': jobroles,
    };
  }
}
