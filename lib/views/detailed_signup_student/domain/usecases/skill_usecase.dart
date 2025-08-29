import 'package:dio/dio.dart';
import 'package:job_portal/utils/resourses/data_state.dart';
import 'package:job_portal/views/detailed_signup_student/data/model/domian_all_response.dart';
import 'package:job_portal/views/detailed_signup_student/data/model/skill_submission_response.dart';
import 'package:job_portal/views/detailed_signup_student/data/model/subskill_response.dart';
import 'package:job_portal/views/detailed_signup_student/domain/repository/skill_repository.dart';

class SkillUsecase {
  final SkillRepository repository;

  SkillUsecase(this.repository);

  Future<DataState<DomainAllResponse>> getDomains() async {
    final response = await repository.getDomains();
    return response;
  }

  Future<DataState<SubSkillResponse>> getSubSkills(String domain) async {
    final response = await repository.getSubSkills(domain);
    return response;
  }

  Future<DataState<SkillSubmitionResponse>> submitSkillsAndCertificates(
      Map<String, dynamic> data) async {
    final response = await repository.submitSkillsAndCertificates(data);
    return response;
  }
}
