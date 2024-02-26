import 'package:flutter_story_app/core/constants/constants.dart';
import 'package:flutter_story_app/core/state/ui_state.dart';
import 'package:flutter_story_app/features/story/data/models/login_response.dart';
import 'package:flutter_story_app/features/story/data/models/register_response.dart';
import 'package:flutter_story_app/features/story/data/models/story_response.dart';
import 'package:flutter_story_app/features/story/data/source/remote/api_service.dart';
import 'package:flutter_story_app/features/story/domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  final ApiService _apiService;

  RepositoryImpl(this._apiService);

  @override
  Future<UiState<StoryResponseModel>> getAllStory() async {
    try {
      final response = await _apiService.getAllStories(
        authorization: 'Bearer ${Constants().token}',
      );

      if (!response.error!) {
        return SuccessState(response);
      } else {
        return ErrorState(response.message ?? '');
      }
    } catch (e) {
      return ErrorState(e.toString());
    }
  }

  @override
  Future<UiState<LoginResponseModel>> loginUser(
    String email,
    String password,
  ) async {
    try {
      final response = await _apiService.loginUser(
        email: email,
        password: password,
      );

      if (!response.error!) {
        return SuccessState(response);
      } else {
        return ErrorState(response.message ?? '');
      }
    } catch (e) {
      return ErrorState(e.toString());
    }
  }

  @override
  Future<UiState<RegisterResponseModel>> registerUser(
    String username,
    String email,
    String password,
  ) async {
    try {
      final response = await _apiService.registerUser(
        username: username,
        email: email,
        password: password,
      );

      if (!response.error!) {
        return SuccessState(response);
      } else {
        return ErrorState(response.message ?? '');
      }
    } catch (e) {
      return ErrorState(e.toString());
    }
  }
}
