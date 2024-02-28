import 'package:flutter_story_app/core/state/data_state.dart';
import 'package:flutter_story_app/features/story/data/models/responses/detail/detail_response.dart';
import 'package:flutter_story_app/features/story/data/models/responses/login/login_response.dart';
import 'package:flutter_story_app/features/story/data/models/responses/register/register_response.dart';
import 'package:flutter_story_app/features/story/data/models/responses/story/story_response.dart';

abstract class StoryRepository {
  Future<DataState<StoryResponse>> getStories();

  Future<DataState<LoginResponse>> loginUser(
    String email,
    String password,
  );

  Future<DataState<RegisterResponse>> registerUser(
    String username,
    String email,
    String password,
  );

  Future<DataState<DetailResponse>> getDetailStory(String storyId);
}
