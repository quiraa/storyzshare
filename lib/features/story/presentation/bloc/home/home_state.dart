import 'package:equatable/equatable.dart';
import 'package:flutter_story_app/features/story/domain/entities/story_response.dart';

abstract class HomeState extends Equatable {
  final StoryResponseEntity? storyEntity;
  final String? error;

  const HomeState({this.storyEntity, this.error});

  @override
  List<Object?> get props {
    return [
      storyEntity!,
      error!,
    ];
  }
}

class HomeLoadingState extends HomeState {
  const HomeLoadingState();
}

class HomeErrorState extends HomeState {
  const HomeErrorState(String error) : super(error: error);
}

class HomeSuccessState extends HomeState {
  const HomeSuccessState(StoryResponseEntity storyEntity)
      : super(storyEntity: storyEntity);
}
