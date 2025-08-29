import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_portal/views/post_opportunities/domain/usecases/metadata_usecase.dart';
import 'package:job_portal/views/post_opportunities/presentation/bloc/opportunity_event.dart';
import 'package:job_portal/views/post_opportunities/presentation/bloc/opportunity_state.dart';

class OpportunityBloc extends Bloc<OpportunityEvent, OpportunityState> {
  final MetadataUsecase _metadataUsecase;
  final CreateJobPostUsecase _createJobPostUsecase;
  OpportunityBloc(this._metadataUsecase, this._createJobPostUsecase)
      : super(const OpportunityInitial()) {
    on<OpportunityMetaDataLoad>(_onLoadMetaData);
    on<OpportunityCreateJobPost>(_onCreateJobPost);
  }

  Future<void> _onLoadMetaData(
      OpportunityMetaDataLoad event, Emitter<OpportunityState> emit) async {
    try {
      emit(const OpportunityMetadataLoading());
      final response = await _metadataUsecase(params: null);
      emit(OpportunityMetadataLoaded(response.data!));
    } catch (e) {
      emit(const OpportunityMetadataError());
    }
  }

  Future<void> _onCreateJobPost(
      OpportunityCreateJobPost event, Emitter<OpportunityState> emit) async {
    try {
      emit(const OpportunityMetadataLoading());
      final response = await _createJobPostUsecase(params: event.params);
      emit(OpportunityMetadataLoaded(response.data!));
    } catch (e) {
      emit(const OpportunityMetadataError());
    }
  }
}
