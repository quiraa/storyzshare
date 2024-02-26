import 'package:flutter_story_app/features/story/domain/entities/story_response.dart';

class StoryResponseModel extends StoryResponseEntity {
  const StoryResponseModel({
    bool? error,
    String? message,
    List<StoryItem>? listStory,
  }) : super(
          error: error,
          message: message,
          listStory: listStory,
        );

  factory StoryResponseModel.fromJson(Map<String, dynamic> json) {
    return StoryResponseModel(
      error: json['error'],
      message: json['message'],
      listStory: json['listStory'],
    );
  }

  factory StoryResponseModel.fromEntity(StoryResponseEntity entity) {
    return StoryResponseModel(
      error: entity.error,
      message: entity.message,
      listStory: entity.listStory,
    );
  }
}
