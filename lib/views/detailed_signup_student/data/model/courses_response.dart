class CoursesListResponse {
  final List<String> courses;

  CoursesListResponse({required this.courses});

  factory CoursesListResponse.fromJson(Map<String, dynamic> json) {
    return CoursesListResponse(
      courses: List<String>.from(json['data'] ?? []),
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
    return LocationsListResponse(
      locations: List<String>.from(json['data'] ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'locations': locations,
    };
  }
}
