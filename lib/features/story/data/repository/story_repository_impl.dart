import 'package:flutter_story_app/core/state/data_state.dart';
import 'package:flutter_story_app/features/story/data/models/responses/login/login_response.dart';
import 'package:flutter_story_app/features/story/data/models/responses/register/register_response.dart';
import 'package:flutter_story_app/features/story/data/models/responses/story/story_response.dart';
import 'package:flutter_story_app/features/story/data/sources/api/api_service.dart';
import 'package:flutter_story_app/features/story/domain/repository/story_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoryRepositoryImpl implements StoryRepository {
  final ApiService api;

  StoryRepositoryImpl(this.api);

  @override
  Future<DataState<StoryResponse>> getStories(String token) async {
    try {
      final response = await api.getAllStories('Bearer $token');
      if (!response.data.error) {
        return DataSuccess(response.data);
      } else {
        return DataError(response.data.message);
      }
    } catch (err) {
      return DataError(err.toString());
    }
  }

  @override
  Future<DataState<LoginResponse>> loginUser(
    String email,
    String password,
  ) async {
    try {
      final response = await api.loginUser(email, password);
      if (!response.data.error) {
        final token = response.data.loginResult.token;
        await saveTokenToPreferences(token);
        await saveSessionToPreferences(true);
        return DataSuccess(response.data);
      } else {
        return DataError(response.data.message);
      }
    } catch (err) {
      return DataError(err.toString());
    }
  }

  @override
  Future<DataState<RegisterResponse>> registerUser(
    String username,
    String email,
    String password,
  ) async {
    try {
      final response = await api.registerUser(username, email, password);
      if (!response.data.error) {
        return DataSuccess(response.data);
      } else {
        return DataError(response.data.message);
      }
    } catch (err) {
      return DataError(err.toString());
    }
  }
}

Future<void> saveTokenToPreferences(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token);
}

Future<void> saveSessionToPreferences(bool isLoggedIn) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', isLoggedIn);
}
