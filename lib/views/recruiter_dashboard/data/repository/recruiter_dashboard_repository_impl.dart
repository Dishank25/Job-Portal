import 'dart:io';
import 'package:dio/dio.dart';
import 'package:job_portal/utils/resourses/data_state.dart';
import 'package:retrofit/dio.dart';
import '../../../../utils/constants/urls.dart';
import '../data_source/recruiter_dashboard_api_service/recruiter_dashboard_api_service.dart';
import '../../domain/entities/recruiter_dashboard_entity.dart';
import '../../domain/repository/recruiter_dashboard_repository.dart';
import '../models/Recruiter_Dashboard_Response_Model.dart';

class RecruiterDashboardRepositoryImpl implements RecruiterDashboardRepository {
  final RecruiterDashboardApiService _apiService;

  RecruiterDashboardRepositoryImpl(this._apiService);

  @override
  Future<DataState<RecruiterDashboardEntity>> getTotalJobCount() async {
    try {
      final HttpResponse<RecruiterDashboardResponseModel> response =
      await _apiService.getTotalJobCount();

      // Cast to the superclass (RecruiterDashboardEntity)
      final RecruiterDashboardEntity entity = response.data;

      return DataSuccess<RecruiterDashboardEntity>(entity);
    } on DioException catch (e) {
      return DataFailed<RecruiterDashboardEntity>(e);
    } catch (e) {
      return DataFailed<RecruiterDashboardEntity>(
        DioException(
          error: e,
          requestOptions: RequestOptions(path: Urls.totalJobCount),
        ),
      );
    }
  }
}