class SkillsByDomain {
  final int domainId;
  final String domainName;
  final List<Skill> skills;

  const SkillsByDomain({
    required this.domainId,
    required this.domainName,
    required this.skills,
  });

  factory SkillsByDomain.fromJson(Map<String, dynamic> json) {
    final list = json['skills'] as List<dynamic>;
    return SkillsByDomain(
      domainId: json['domain_id'] as int,
      domainName: json['domain_name'] as String,
      skills: list.map((e) => Skill.fromJson(e)).toList() ?? [],
    );
  }
}

class Skill {
  final int skillId;
  final String skillName;

  const Skill({required this.skillId, required this.skillName});

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      skillId: json['skill_id'] as int,
      skillName: json['skill_name'] as String,
    );
  }
}
