import 'package:json_annotation/json_annotation.dart';

part 'story_response_item.g.dart';

@JsonSerializable()
class StoryResponseItem {
  final String id;
  final String name;
  final String description;
  final String photoUrl;
  final String createdAt;
  final double lon;
  final double lat;

  StoryResponseItem({
    required this.id,
    required this.name,
    required this.description,
    required this.photoUrl,
    required this.createdAt,
    required this.lon,
    required this.lat,
  });

  factory StoryResponseItem.fromJson(Map<String, dynamic> json) =>
      _$StoryResponseItemFromJson(json);

  Map<String, dynamic> toJson() => _$StoryResponseItemToJson(this);
}
