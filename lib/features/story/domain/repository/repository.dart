import 'package:flutter_story_app/core/state/ui_state.dart';
import 'package:flutter_story_app/features/story/domain/entities/login_response.dart';
import 'package:flutter_story_app/features/story/domain/entities/register_response.dart';
import 'package:flutter_story_app/features/story/domain/entities/story_response.dart';

abstract class Repository {
  Future<UiState<StoryResponseEntity>> getAllStory();

  Future<UiState<LoginResponseEntity>> loginUser(
    String email,
    String password,
  );

  Future<UiState<RegisterResponseEntity>> registerUser(
    String username,
    String email,
    String password,
  );
}
