class RecruiterDashboardEntity {
  final int totalCount;

  const RecruiterDashboardEntity({
    required this.totalCount,
  });

  factory RecruiterDashboardEntity.fromJson(Map<String, dynamic> json) {
    return RecruiterDashboardEntity(
      totalCount: json['totalJobPosts'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalCount': totalCount,
    };
  }
}