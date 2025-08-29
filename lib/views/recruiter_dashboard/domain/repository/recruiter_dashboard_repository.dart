import 'package:job_portal/utils/resourses/data_state.dart';
import 'package:job_portal/views/recruiter_dashboard/domain/entities/recruiter_dashboard_entity.dart';

abstract class RecruiterDashboardRepository {
  Future<DataState<RecruiterDashboardEntity>> getTotalJobCount();
}