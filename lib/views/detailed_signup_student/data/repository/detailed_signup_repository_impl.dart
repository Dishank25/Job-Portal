import 'dart:developer' as developer show log;
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:job_portal/utils/resourses/data_state.dart';
import 'package:job_portal/views/detailed_signup_student/data/data_source/detailed_api_service.dart';
import 'package:job_portal/views/detailed_signup_student/data/model/basic_user_data_response.dart';
import 'package:job_portal/views/detailed_signup_student/data/model/colleges_response.dart';
import 'package:job_portal/views/detailed_signup_student/data/model/courses_response.dart';
import 'package:job_portal/views/detailed_signup_student/data/model/job_roles_response.dart';
import 'package:job_portal/views/detailed_signup_student/data/model/skill_submission_response.dart';
import 'package:job_portal/views/detailed_signup_student/data/model/specialization_response.dart';
import 'package:job_portal/views/detailed_signup_student/data/model/submit_detailed_user_profile.dart';
import 'package:job_portal/views/detailed_signup_student/domain/repository/detailed_signup_repository.dart';

class DetailedSignupRepositoryImpl extends DetailedSignupRepository {
  final DetailedApiService _apiService;

  DetailedSignupRepositoryImpl(this._apiService);

  @override
  Future<DataState<BasicUserInfoResponse>> getBasicUserInfo(
      Map<String, dynamic> emailMap) async {
    try {
      final res = await _apiService.getBasicUserInfo(emailMap);
      if (res.response.statusCode == HttpStatus.ok) {
        developer.log('.checkk response in repository : ${res.data.message}');
        return DataSuccess(res.data);
      } else {
        developer.log('..checkk response in repository : ${res.data.message}');
        return DataFailed(DioException(
            error: res.response.statusMessage,
            response: res.response,
            type: DioExceptionType.badResponse,
            requestOptions: res.response.requestOptions));
      }
    } on DioException catch (e) {
      final error = e.type;
      developer.log('....checkk  : ${error}');
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<CollegesListResponse>> getColleges(
      Map<String, dynamic> emailMap) async {
    try {
      final res = await _apiService.getColleges(emailMap);
      if (res.response.statusCode == HttpStatus.ok) {
        developer.log('.checkk response in repository : ${res.data}');
        return DataSuccess(res.data);
      } else {
        developer.log('..checkk response in repository : ${res.data}');
        return DataFailed(DioException(
            error: res.response.statusMessage,
            response: res.response,
            type: DioExceptionType.badResponse,
            requestOptions: res.response.requestOptions));
      }
    } on DioException catch (e) {
      final error = e.type;
      developer.log('....checkk  : $error');
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<SpecializationListResponse>> getSpecialization() async {
    try {
      final res = await _apiService.getSpecialization();
      if (res.response.statusCode == HttpStatus.ok) {
        developer.log('.checkk response in repository : ${res.data}');
        return DataSuccess(res.data);
      } else {
        developer.log('..checkk response in repository : ${res.data}');
        return DataFailed(DioException(
            error: res.response.statusMessage,
            response: res.response,
            type: DioExceptionType.badResponse,
            requestOptions: res.response.requestOptions));
      }
    } on DioException catch (e) {
      final error = e.type;
      developer.log('....checkk  : $error');
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<CoursesListResponse>> getCourses() async {
    try {
      final res = await _apiService.getCourses();
      if (res.response.statusCode == HttpStatus.ok) {
        developer.log('.checkk response in repository : ${res.data}');
        return DataSuccess(res.data);
      } else {
        developer.log('..checkk response in repository : ${res.data}');
        return DataFailed(DioException(
            error: res.response.statusMessage,
            response: res.response,
            type: DioExceptionType.badResponse,
            requestOptions: res.response.requestOptions));
      }
    } on DioException catch (e) {
      final error = e.type;
      developer.log('....checkk  : $error');
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<LocationsListResponse>> getLocations() async {
    try {
      final res = await _apiService.getLocations();
      if (res.response.statusCode == HttpStatus.ok) {
        developer.log('.checkk response in repository : ${res.data}');
        return DataSuccess(res.data);
      } else {
        developer.log('..checkk response in repository : ${res.data}');
        return DataFailed(DioException(
            error: res.response.statusMessage,
            response: res.response,
            type: DioExceptionType.badResponse,
            requestOptions: res.response.requestOptions));
      }
    } on DioException catch (e) {
      final error = e.type;
      developer.log('....checkk  : $error');
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<JobrolesListResponse>> getJobroles() async {
    try {
      final res = await _apiService.getJobroles();
      if (res.response.statusCode == HttpStatus.ok) {
        developer.log('.checkk response in repository : ${res.data}');
        return DataSuccess(res.data);
      } else {
        developer.log('..checkk response in repository : ${res.data}');
        return DataFailed(DioException(
            error: res.response.statusMessage,
            response: res.response,
            type: DioExceptionType.badResponse,
            requestOptions: res.response.requestOptions));
      }
    } on DioException catch (e) {
      final error = e.type;
      developer.log('....checkk  : $error');
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<SubmitDetailedUserProfile>> submitDetailedUserProfile(
      Map<String, dynamic> params) async {
    try {
      final res = await _apiService.submitDetailedUserProfile(params);
      if (res.response.statusCode == HttpStatus.ok ||
          res.response.statusCode == HttpStatus.created ||
          res.response.statusCode == HttpStatus.conflict) {
        developer.log('.checkk response in repository : ${res.data}');
        return DataSuccess(res.data);
      } else {
        developer.log('..checkk response in repository : ${res.data}');
        return DataFailed(DioException(
            error: res.response.statusMessage,
            response: res.response,
            type: DioExceptionType.badResponse,
            requestOptions: res.response.requestOptions));
      }
    } on DioException catch (e) {
      final error = e.type;
      developer.log('....checkk  : $error');
      if (error == DioExceptionType.badResponse) {
        developer.log('...checkk response in repository : ${e.response}');
        final data = SubmitDetailedUserProfile.fromJson(e.response!.data);
        return DataSuccess(data);
      }
      return DataFailed(e);
    }
  }
}
