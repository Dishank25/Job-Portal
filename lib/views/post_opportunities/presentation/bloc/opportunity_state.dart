import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:job_portal/views/post_opportunities/domain/entities/internship_metadata_entity.dart';

@immutable
abstract class OpportunityState extends Equatable {
  const OpportunityState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class OpportunityInitial extends OpportunityState {
  const OpportunityInitial();
}

class OpportunityMetadataLoading extends OpportunityState {
  const OpportunityMetadataLoading();
}

class OpportunityMetadataLoaded extends OpportunityState {
  final InternshipMetadataEntity internshipMetadata;

  const OpportunityMetadataLoaded(this.internshipMetadata);
}

class OpportunityMetadataError extends OpportunityState {
  const OpportunityMetadataError();
}

class OpportunityJobPostLoading extends OpportunityState {
  const OpportunityJobPostLoading();
}

class OpportunityJobPostLoaded extends OpportunityState {
  final InternshipMetadataEntity internshipMetadata;

  const OpportunityJobPostLoaded(this.internshipMetadata);
}

class OpportunityJobPostError extends OpportunityState {
  const OpportunityJobPostError();
}
