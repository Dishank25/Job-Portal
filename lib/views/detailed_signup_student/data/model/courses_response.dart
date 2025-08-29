class CoursesListResponse {
  final List<String> courses;

  CoursesListResponse({required this.courses});

  factory CoursesListResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> data = json['data'] ?? [];
    final List<String> courseNames = data
        .map((item) =>
            item['name'] as String? ??
            '') // Extract name from each course object
        .where((name) => name.isNotEmpty) // Filter out empty names
        .toList();

    return CoursesListResponse(
      courses: courseNames, // Now this is List<String>
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'courses': courses,
    };
  }
}

class LocationsListResponse {
  final List<String> locations;

  LocationsListResponse({required this.locations});

  factory LocationsListResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> data = json['data'] ?? [];
    final List<String> locationNames = data
        .map((item) =>
            item['name'] as String? ?? '') // Extract name from each object
        .where((name) => name.isNotEmpty) // Filter out empty names
        .toList();

    return LocationsListResponse(
      locations: locationNames, // Now this is List<String>
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'locations': locations,
    };
  }
}
