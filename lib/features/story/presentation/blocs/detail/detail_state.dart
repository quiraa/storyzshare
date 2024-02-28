import 'package:dio/dio.dart';
import 'package:flutter_story_app/features/story/data/models/responses/story/story_response_item.dart';

abstract class DetailState {
  final StoryResponseItem? story;
  final DioException? error;

  const DetailState({this.story, this.error});
}

class DetailLoadingState extends DetailState {
  const DetailLoadingState();
}

class DetailErrorState extends DetailState {
  const DetailErrorState(DioException error) : super(error: error);
}

class DetailSuccessState extends DetailState {
  const DetailSuccessState(StoryResponseItem story) : super(story: story);
}
