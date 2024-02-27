// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoryResponse _$StoryResponseFromJson(Map<String, dynamic> json) =>
    StoryResponse(
      listStory: (json['listStory'] as List<dynamic>)
          .map((e) => StoryResponseItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      error: json['error'] as bool,
      message: json['message'] as String,
    );

Map<String, dynamic> _$StoryResponseToJson(StoryResponse instance) =>
    <String, dynamic>{
      'listStory': instance.listStory,
      'error': instance.error,
      'message': instance.message,
    };
