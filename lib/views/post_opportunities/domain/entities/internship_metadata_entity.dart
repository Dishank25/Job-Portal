import 'skills_by_domain_entity.dart';
// class InternshipMetadataEntity {
//   final List<String> duration;
//   final List<String> startMonth;
//   final List<String> perks;
//   final List<String> cities;
//   final List<String> domains;
//   final List<String> skills;

//   const InternshipMetadataEntity({
//     required this.duration,
//     required this.startMonth,
//     required this.perks,
//     required this.cities,
//     required this.domains,
//     required this.skills,
//   });
// }
class InternshipMetadataEntity {
  final List<String> duration;
  final List<String> startMonth;
  final List<String> perks;
  final List<String> cities;
  final List<String> domains;
  final List<String> skills;

  // ID Maps
  final Map<String, int> durationMap;
  final Map<String, int> perksMap;
  final Map<String, int> citiesMap;
  final Map<String, int> domainsMap;
  final Map<String, int> skillsMap;

  // Nested skills
  final List<SkillsByDomain> skillsByDomain;

  const InternshipMetadataEntity({
    required this.duration,
    required this.startMonth,
    required this.perks,
    required this.cities,
    required this.domains,
    required this.skills,
    this.durationMap = const {},
    this.perksMap = const {},
    this.citiesMap = const {},
    this.domainsMap = const {},
    this.skillsMap = const {},
    required this.skillsByDomain,
  });
}
