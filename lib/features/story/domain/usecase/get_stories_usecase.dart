import 'package:flutter_story_app/core/state/data_state.dart';
import 'package:flutter_story_app/core/usecases/usecase.dart';
import 'package:flutter_story_app/features/story/data/models/responses/story/story_response.dart';
import 'package:flutter_story_app/features/story/domain/repository/story_repository.dart';

class GetStoriesUseCase
    implements UseCase<DataState<StoryResponse>, GetStoriesParams> {
  final StoryRepository repository;

  GetStoriesUseCase(this.repository);

  @override
  Future<DataState<StoryResponse>> call({GetStoriesParams? params}) {
    return repository.getStories(params!.token);
  }
}

class GetStoriesParams {
  final String token;

  GetStoriesParams(this.token);
}
