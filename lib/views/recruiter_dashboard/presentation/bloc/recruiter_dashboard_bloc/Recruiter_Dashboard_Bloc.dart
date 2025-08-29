import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import '../../../data/data_source/recruiter_dashboard_api_service/recruiter_dashboard_api_service.dart';
import 'Recruiter_Dashboard_Event.dart';
import 'Recruiter_Dashboard_State.dart';

class RecruiterDashboardBloc
    extends Bloc<RecruiterDashboardEvent, RecruiterDashboardState> {
  final RecruiterDashboardApiService apiService;

  RecruiterDashboardBloc(this.apiService)
      : super(RecruiterDashboardInitial()) {
    on<FetchTotalJobCount>(_onFetchTotalJobCount);
  }

  // Future<void> _onFetchTotalJobCount(
  //     FetchTotalJobCount event,
  //     Emitter<RecruiterDashboardState> emit,
  //     ) async {
  //   emit(RecruiterDashboardLoading());
  //   try {
  //     print("Fetching total job count...");
  //     final response = await apiService.getTotalJobCount();
  //     print("Raw API Response Data: ${response.data}");
  //     print("Response JSON Body: ${response.data.toJson()}");
  //
  //     if (response.data != null) {
  //       emit(RecruiterDashboardLoaded(response.data.totalCount));
  //     } else {
  //       emit(RecruiterDashboardError("No data received"));
  //     }
  //   } on DioException catch (e) {
  //     print("Dio Error: ${e.message}");
  //     emit(RecruiterDashboardError("Network error: ${e.message}"));
  //   } catch (e) {
  //     print("Unexpected Error: $e");
  //     emit(RecruiterDashboardError("Unexpected error"));
  //   }
  // }

  Future<void> _onFetchTotalJobCount(
      FetchTotalJobCount event,
      Emitter<RecruiterDashboardState> emit,
      ) async {
    emit(RecruiterDashboardLoading());
    try {
      final response = await apiService.getTotalJobCount();
      if (response.data != null) {
        emit(RecruiterDashboardLoaded(response.data.totalCount));
      } else {
        emit(RecruiterDashboardError("No data received"));
      }
    } on Exception catch (e) {
      emit(RecruiterDashboardError(e.toString()));
    }
  }
}