class SubSkillResponse {
  final List<String> skills;

  SubSkillResponse({required this.skills});

  factory SubSkillResponse.fromJson(Map<String, dynamic> json) {
    return SubSkillResponse(
      skills: List<String>.from(json['skills'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'skills': skills,
    };
  }
}
