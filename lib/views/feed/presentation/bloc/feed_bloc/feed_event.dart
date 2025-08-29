import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class FeedEvent extends Equatable {
  const FeedEvent();
}

class LoadFeedPosts extends FeedEvent {
  final String page;
  final String limit;
  const LoadFeedPosts(this.page, this.limit);

  @override
  List<Object?> get props => [page, limit];
}

class LoadFeedPostLike extends FeedEvent {
  final String feedpost_id;
  final Map<String, dynamic> map;

  const LoadFeedPostLike(this.feedpost_id, this.map);

  @override
  List<Object?> get props => [feedpost_id, map];
}

class LoadFeedPostComment extends FeedEvent {
  final String feedpost_id;
  final Map<String, dynamic> map;

  const LoadFeedPostComment(this.feedpost_id, this.map);

  @override
  List<Object?> get props => [feedpost_id, map];
}
