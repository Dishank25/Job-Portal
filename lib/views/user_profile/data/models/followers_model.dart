import 'package:job_portal/views/user_profile/domain/entities/followers_entity.dart';

class FollowersModel extends FollowersEntity {
  FollowersModel({
    required super.count,
    required List<FollowerModel> super.followers,
  });

  factory FollowersModel.fromJson(Map<String, dynamic> json) {
    return FollowersModel(
      count: json['count'] ?? 0,
      followers: (json['followers'] as List<dynamic>?)
              ?.map((e) => FollowerModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'followers': followers.map((e) => (e as FollowerModel).toJson()).toList(),
    };
  }
}

class FollowerModel extends Follower {
  FollowerModel({
    required super.first_name,
    required super.last_name,
    required super.user_role,
  });

  factory FollowerModel.fromJson(Map<String, dynamic> json) {
    return FollowerModel(
      first_name: json['first_name'] ?? '',
      last_name: json['last_name'] ?? '',
      user_role: json['user_role'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': first_name,
      'last_name': last_name,
      'user_role': user_role,
    };
  }
}

class FollowingModel extends FollowingEntity {
  FollowingModel({
    required super.count,
    required List<FollowingItemModel> super.following,
  });

  factory FollowingModel.fromJson(Map<String, dynamic> json) {
    return FollowingModel(
      count: json['count'] ?? 0,
      following: (json['following'] as List<dynamic>?)
              ?.map((e) => FollowingItemModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'following':
          following.map((e) => (e as FollowingItemModel).toJson()).toList(),
    };
  }
}

class FollowingItemModel extends Following {
  FollowingItemModel({
    required super.first_name,
    required super.last_name,
    required super.user_role,
  });

  factory FollowingItemModel.fromJson(Map<String, dynamic> json) {
    return FollowingItemModel(
      first_name: json['first_name'] ?? '',
      last_name: json['last_name'] ?? '',
      user_role: json['user_role'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': first_name,
      'last_name': last_name,
      'user_role': user_role,
    };
  }
}
