import 'package:job_portal/utils/resourses/data_state.dart';
import 'package:job_portal/views/job_related/domain/entities/all_jobs_entity.dart';
import 'package:job_portal/views/job_related/domain/entities/job_apply_entity.dart';
import 'package:job_portal/views/job_related/domain/entities/job_details_entity.dart';

abstract class JobsRepository {
  Future<DataState<List<AllJobsEntity>>> getOpportunities();

  Future<DataState<JobDetailsEntity>> getJobDetails(String id);

  Future<DataState<JobApplyEntity>> applyForJob(
      String jobId, Map<String, dynamic> params);
}
