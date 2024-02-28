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
      photoUrl: json['photoUrl'] as String,
      createdAt: json['createdAt'] as String,
      lon: (json['lon'] == null ? 0.0 : json['lon'] as num).toDouble(),
      lat: (json['lat'] == null ? 0.0 : json['lat'] as num).toDouble(),
    );

Map<String, dynamic> _$StoryResponseItemToJson(StoryResponseItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'photoUrl': instance.photoUrl,
      'createdAt': instance.createdAt,
      'lon': instance.lon,
      'lat': instance.lat,
    };
