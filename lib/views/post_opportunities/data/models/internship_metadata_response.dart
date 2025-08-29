import 'package:job_portal/views/post_opportunities/domain/entities/internship_metadata_entity.dart';
import 'dart:developer' as developer show log;
import '../../domain/entities/skills_by_domain_entity.dart';

class InternshipMetadataResponseModel extends InternshipMetadataEntity {
  InternshipMetadataResponseModel({
    required super.duration,
    required super.startMonth,
    required super.perks,
    required super.cities,
    required super.domains,
    required super.skills,
    super.durationMap,
    super.perksMap,
    super.citiesMap,
    super.domainsMap,
    super.skillsMap,
    required super.skillsByDomain,
  });

//   factory InternshipMetadataResponseModel.fromJson(Map<String, dynamic> json) {
//     return InternshipMetadataResponseModel(
//       duration: List<String>.from(json['duration'] ?? []),
//       startMonth: List<String>.from(json['startMonth'] ?? []),
//       perks: List<String>.from(json['perks'] ?? []),
//       cities: List<String>.from(json['cities'] ?? []),
//       domains: List<String>.from(json['domains'] ?? []),
//       skills: List<String>.from(json['skills'] ?? []),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'duration': duration,
//       'startMonth': startMonth,
//       'perks': perks,
//       'cities': cities,
//       'domains': domains,
//       'skills': skills,
//     };
//   }
// }
  factory InternshipMetadataResponseModel.fromJson(Map<String, dynamic> json) {
    try {
      final data = json['data'] as Map<String, dynamic>? ?? {};

      developer.log('🔑 Available keys: ${data.keys}');

      List<String> extractValues(List<dynamic>? list, String valueKey) {
        if (list == null) return [];
        return list
            .where((item) =>
                item is Map<String, dynamic> && item[valueKey] != null)
            .map((item) => item[valueKey].toString())
            .toList();
      }

      Map<String, int> extractMap(
          List<dynamic>? list, String valueKey, String idKey) {
        if (list == null) return {};
        final map = <String, int>{};
        for (var item in list) {
          if (item is Map<String, dynamic>) {
            final value = item[valueKey];
            final id = item[idKey];
            if (value != null && id != null) {
              map[value.toString()] = id as int;
            }
          }
        }
        return map;
      }

      final durationList = extractValues(data['duration'], 'value');
      final perksList = extractValues(data['perks'], 'value');
      final citiesList = extractValues(data['locations'], 'name');
      final domainsList = extractValues(data['domains'], 'domain_name');

      // Flatten skills from skillsByDomain
      final List<SkillsByDomain> parsedSkillsByDomain = (data['skillsByDomain']
                  as List<dynamic>?)
              ?.map((e) => SkillsByDomain.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [];

      final List<String> allSkillNames = <String>[];
      final Map<String, int> allSkillsMap = <String, int>{};

      for (final domain in parsedSkillsByDomain) {
        for (final skill in domain.skills) {
          allSkillNames.add(skill.skillName);
          allSkillsMap[skill.skillName] = skill.skillId;
        }
      }

      return InternshipMetadataResponseModel(
        duration: durationList,
        perks: perksList,
        cities: citiesList,
        domains: domainsList,
        skills: allSkillNames, // ← Now populated
        startMonth: List<String>.generate(12, (i) => '${i + 1}'),
        durationMap: extractMap(data['duration'], 'value', 'id'),
        perksMap: extractMap(data['perks'], 'value', 'id'),
        citiesMap: extractMap(data['locations'], 'name', 'id'),
        domainsMap: extractMap(data['domains'], 'domain_name', 'domain_id'),
        skillsMap: allSkillsMap, // ← Now has real IDs
        skillsByDomain: parsedSkillsByDomain,
      );
    } catch (e, s) {
      developer.log('❌ Error in fromJson: $e\n$s');
      rethrow;
    }
  }
}
