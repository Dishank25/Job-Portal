import 'package:job_portal/utils/resourses/data_state.dart';
import 'package:job_portal/utils/usecase/usecases.dart';
import 'package:job_portal/views/post_opportunities/domain/entities/internship_metadata_entity.dart';
import 'package:job_portal/views/post_opportunities/domain/repository/opportunity_repository.dart';

class MetadataUsecase
    implements
        UseCase<DataState<InternshipMetadataEntity>, Map<String, dynamic>> {
  final OpportunityRepository _repository;
  MetadataUsecase(this._repository);

  @override
  Future<DataState<InternshipMetadataEntity>> call(
      {Map<String, dynamic>? params}) async {
    return _repository.getOpportunityFormMetadata();
  }
}

class CreateJobPostUsecase
    implements
        UseCase<DataState<InternshipMetadataEntity>, Map<String, dynamic>> {
  final OpportunityRepository _repository;
  CreateJobPostUsecase(this._repository);

  @override
  Future<DataState<InternshipMetadataEntity>> call(
      {Map<String, dynamic>? params}) async {
    return _repository.createJobPost(params ?? {});
  }
}
