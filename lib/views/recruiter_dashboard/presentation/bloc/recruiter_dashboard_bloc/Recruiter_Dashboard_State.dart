import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class RecruiterDashboardState extends Equatable {
  const RecruiterDashboardState();

  @override
  List<Object> get props => [];
}

class RecruiterDashboardInitial extends RecruiterDashboardState {}

class RecruiterDashboardLoading extends RecruiterDashboardState {}

class RecruiterDashboardLoaded extends RecruiterDashboardState {
  final int totalCount;

  const RecruiterDashboardLoaded(this.totalCount);

  @override
  List<Object> get props => [totalCount];
}

class RecruiterDashboardError extends RecruiterDashboardState {
  final String message;

  const RecruiterDashboardError(this.message);

  @override
  List<Object> get props => [message];
}