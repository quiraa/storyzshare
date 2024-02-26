import 'package:flutter_story_app/core/state/ui_state.dart';
import 'package:flutter_story_app/core/usecases/usecases.dart';
import 'package:flutter_story_app/features/story/domain/entities/story_response.dart';
import 'package:flutter_story_app/features/story/domain/repository/repository.dart';

class GetAllStoryUseCase
    implements UseCase<UiState<StoryResponseEntity>, void> {
  final Repository _repository;

  GetAllStoryUseCase(this._repository);

  @override
  Future<UiState<StoryResponseEntity>> call({void params}) {
    return _repository.getAllStory();
  }
}
