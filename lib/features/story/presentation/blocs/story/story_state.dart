import 'package:equatable/equatable.dart';
import 'package:flutter_story_app/features/story/data/models/responses/story/story_response.dart';

abstract class StoryState extends Equatable {
  final StoryResponse? response;
  final String? errorMessage;

  const StoryState({
    this.response,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [response!, errorMessage!];
}

class StoryLoadingState extends StoryState {
  const StoryLoadingState();
}

class StoryErrorState extends StoryState {
  const StoryErrorState(String? errorMessage)
      : super(errorMessage: errorMessage);
}

class StorySuccessState extends StoryState {
  const StorySuccessState(StoryResponse response) : super(response: response);
}
