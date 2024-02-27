import 'package:flutter_story_app/features/story/data/models/responses/story/story_response_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'detail_response.g.dart';

@JsonSerializable()
class DetailResponse {
  final bool error;
  final String message;
  final StoryResponseItem story;

  DetailResponse({
    required this.error,
    required this.message,
    required this.story,
  });

  factory DetailResponse.fromJson(Map<String, dynamic> json) =>
      _$DetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DetailResponseToJson(this);
}
