// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailResponse _$DetailResponseFromJson(Map<String, dynamic> json) =>
    DetailResponse(
      error: json['error'] as bool,
      message: json['message'] as String,
      story: StoryResponseItem.fromJson(json['story'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DetailResponseToJson(DetailResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'story': instance.story,
    };
