import 'package:dio/dio.dart';
import 'package:flutter_story_app/features/story/data/models/responses/story/story_response.dart';

abstract class StoryState {
  final StoryResponse? response;
  final DioException? error;

  const StoryState({
    this.response,
    this.error,
  });
}

class StoryLoadingState extends StoryState {
  const StoryLoadingState();
}

class StoryErrorState extends StoryState {
  const StoryErrorState(DioException error) : super(error: error);
}

class StorySuccessState extends StoryState {
  const StorySuccessState(StoryResponse response) : super(response: response);
}
