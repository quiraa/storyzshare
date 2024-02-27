// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_response_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoryResponseItem _$StoryResponseItemFromJson(Map<String, dynamic> json) =>
    StoryResponseItem(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      createdAt: json['createdAt'] as String,
      photoUrl: json['photoUrl'] as String,
      lon: json['lon'] as String,
      lat: json['lat'] as String,
    );

Map<String, dynamic> _$StoryResponseItemToJson(StoryResponseItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'createdAt': instance.createdAt,
      'photoUrl': instance.photoUrl,
      'lon': instance.lon,
      'lat': instance.lat,
    };
