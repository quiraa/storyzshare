import 'package:flutter_story_app/features/story/data/models/responses/story/story_response_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'story_response.g.dart';

@JsonSerializable()
class StoryResponse {
  final List<StoryResponseItem> listStory;
  final bool error;
  final String message;

  StoryResponse({
    required this.listStory,
    required this.error,
    required this.message,
  });

  factory StoryResponse.fromJson(Map<String, dynamic> json) =>
      _$StoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StoryResponseToJson(this);
}
