import '../../domain/entities/recruiter_dashboard_entity.dart';

class RecruiterDashboardResponseModel extends RecruiterDashboardEntity {
  RecruiterDashboardResponseModel({required int totalCount})
      : super(totalCount: totalCount);

  factory RecruiterDashboardResponseModel.fromJson(Map<String, dynamic> json) =>
      RecruiterDashboardResponseModel(
        totalCount: json['totalJobPosts'] as int? ?? 0,
      );

  Map<String, dynamic> toJson() => {
    'totalJobPosts': totalCount, // Keep consistent
  };
}