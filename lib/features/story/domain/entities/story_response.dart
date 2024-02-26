import 'package:equatable/equatable.dart';

class StoryResponseEntity extends Equatable {
  final List<StoryItem>? listStory;
  final bool? error;
  final String? message;

  const StoryResponseEntity({
    this.listStory,
    this.error,
    this.message,
  });

  @override
  List<Object?> get props {
    return [
      listStory,
      error,
      message,
    ];
  }
}

class StoryItem {
  final int? id;
  final String? name;
  final String? description;
  final String? photoUrl;
  final String? createdAt;
  final double? lat;
  final double? lon;

  const StoryItem({
    this.id,
    this.name,
    this.description,
    this.photoUrl,
    this.createdAt,
    this.lat,
    this.lon,
  });

  factory StoryItem.fromJson(Map<String, dynamic> json) {
    return StoryItem(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      photoUrl: json['photoUrl'],
      createdAt: json['createdAt'],
      lat: json['lat'],
      lon: json['lon'],
    );
  }
}
