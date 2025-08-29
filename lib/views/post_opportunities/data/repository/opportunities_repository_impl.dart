import 'dart:developer' as developer show log;
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:job_portal/utils/resourses/data_state.dart';
import 'package:job_portal/views/post_opportunities/data/data_sources/opportunities_api_service.dart';
import 'package:job_portal/views/post_opportunities/domain/entities/internship_metadata_entity.dart';
import 'package:job_portal/views/post_opportunities/domain/repository/opportunity_repository.dart';

class OpportunitiesRepositoryImpl extends OpportunityRepository {
  final OpportunitiesApiService _apiService;

  OpportunitiesRepositoryImpl(this._apiService);

  @override
  Future<DataState<InternshipMetadataEntity>>
      getOpportunityFormMetadata() async {
    try {
      final httpResponse = await _apiService.getMasterAll();

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final dataState =
            DataSuccess(httpResponse.data); // ← This should be your model
        developer.log('✅ Metadata loaded successfully: ${dataState.data}');
        return dataState;
      } else {
        developer.log('❌ API Error: ${httpResponse.response.statusMessage}');
        return DataFailed(DioException(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
          requestOptions: httpResponse.response.requestOptions,
        ));
      }
    } on DioException catch (e) {
      developer.log('📡 DioException: $e');
      if (e.response != null) {
        developer.log('📡 Response data: ${e.response?.data}');
      }
      return DataFailed(e);
    } on FormatException catch (e) {
      developer.log('📦 JSON Parse Error: $e');
      return DataFailed(DioException(
        error: 'Invalid JSON format',
        type: DioExceptionType.badResponse,
        requestOptions: RequestOptions(path: ''),
      ));
    } on Exception catch (e) {
      developer.log('💥 Unexpected error: $e');
      return DataFailed(DioException(
        error: e.toString(),
        type: DioExceptionType.unknown,
        requestOptions: RequestOptions(path: ''),
      ));
    }
  }

  @override
  Future<DataState<InternshipMetadataEntity>> createJobPost(
      Map<String, dynamic> params) async {
    try {
      final res = await _apiService.createJobPost(params);
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
      developer.log('...checkk response in repository : ${e.error}');

      return DataFailed(e);
    }
  }
}
