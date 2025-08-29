import 'package:dio/dio.dart';
import 'package:job_portal/utils/constants/urls.dart';
import 'package:job_portal/views/detailed_signup_student/data/model/basic_user_data_response.dart';
import 'package:job_portal/views/detailed_signup_student/data/model/colleges_response.dart';
import 'package:job_portal/views/detailed_signup_student/data/model/courses_response.dart';
import 'package:job_portal/views/detailed_signup_student/data/model/domian_all_response.dart';
import 'package:job_portal/views/detailed_signup_student/data/model/job_roles_response.dart';
import 'package:job_portal/views/detailed_signup_student/data/model/skill_submission_response.dart';
import 'package:job_portal/views/detailed_signup_student/data/model/specialization_response.dart';
import 'package:job_portal/views/detailed_signup_student/data/model/submit_detailed_user_profile.dart';
import 'package:job_portal/views/detailed_signup_student/data/model/subskill_response.dart';
import 'package:retrofit/retrofit.dart';

part 'detailed_api_service.g.dart';

@RestApi(baseUrl: Urls.baseUrl)
abstract class DetailedApiService {
  factory DetailedApiService(Dio dio, {String? baseUrl}) = _DetailedApiService;

  @POST(Urls.getUserBasicInfo)
  Future<HttpResponse<BasicUserInfoResponse>> getBasicUserInfo(
      @Body() Map<String, dynamic> emailMap);

  @GET(Urls.getColleges)
  Future<HttpResponse<CollegesListResponse>> getColleges(
      @Body() Map<String, dynamic> emailMap);

  @GET(Urls.getSpecialization)
  Future<HttpResponse<SpecializationListResponse>> getSpecialization();

  @GET(Urls.getCourses)
  Future<HttpResponse<CoursesListResponse>> getCourses();

  @GET('${Urls.getSubSkills}/{domain}')
  Future<HttpResponse<SubSkillResponse>> getSubSkills(@Path() String domain);

  @GET(Urls.getDomainAll)
  Future<HttpResponse<DomainAllResponse>> getDomains();

  @GET(Urls.getJobroles)
  Future<HttpResponse<JobrolesListResponse>> getJobroles();

  @POST(Urls.submitDetailedUserProfile)
  Future<HttpResponse<SubmitDetailedUserProfile>> submitDetailedUserProfile(
      @Body() Map<String, dynamic> params);

  @POST(Urls.submitSkillsAndCertificates)
  @MultiPart()
  Future<HttpResponse<SkillSubmitionResponse>> submitSkillsAndCertificates(
      @Body() Map<String, dynamic> data);

  @GET(Urls.getLocations)
  Future<HttpResponse<LocationsListResponse>> getLocations();
}

// List<dynamic>
