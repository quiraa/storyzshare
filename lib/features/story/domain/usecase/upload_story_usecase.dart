import 'dart:io';

import 'package:flutter_story_app/core/state/data_state.dart';
import 'package:flutter_story_app/core/usecases/usecase.dart';
import 'package:flutter_story_app/features/story/data/models/responses/upload/upload_response.dart';
import 'package:flutter_story_app/features/story/domain/repository/story_repository.dart';

class UploadStoryUseCase
    implements UseCase<DataState<UploadResponse>, UploadStoryParams> {
  final StoryRepository repository;

  UploadStoryUseCase(this.repository);

  @override
  Future<DataState<UploadResponse>> call({UploadStoryParams? params}) {
    return repository.uploadStory(params!.photo, params.description);
  }
}

class UploadStoryParams {
  final File photo;
  final String description;

  UploadStoryParams(this.photo, this.description);
}
