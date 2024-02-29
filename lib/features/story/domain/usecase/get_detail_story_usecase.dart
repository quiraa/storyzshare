import 'package:flutter_story_app/core/state/data_state.dart';
import 'package:flutter_story_app/core/usecases/usecase.dart';
import 'package:flutter_story_app/features/story/data/models/responses/detail/detail_response.dart';
import 'package:flutter_story_app/features/story/domain/repository/story_repository.dart';

class GetDetailStoryUseCase
    implements UseCase<DataState<DetailResponse>, GetDetailStoryParams> {
  final StoryRepository repository;

  GetDetailStoryUseCase(this.repository);

  @override
  Future<DataState<DetailResponse>> call({GetDetailStoryParams? params}) {
    return repository.getDetailStory(params!.storyId);
  }
}

class GetDetailStoryParams {
  final String storyId;

  const GetDetailStoryParams(this.storyId);
}
