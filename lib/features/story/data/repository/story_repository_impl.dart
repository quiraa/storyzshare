import 'package:dio/dio.dart';
import 'package:flutter_story_app/core/constants/constants.dart';
import 'package:flutter_story_app/core/state/data_state.dart';
import 'package:flutter_story_app/features/story/data/models/responses/detail/detail_response.dart';
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
  Future<DataState<StoryResponse>> getStories() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString(Constants.tokenKey);

      if (token == null) {
        return DataError(
          DioException(
            requestOptions: RequestOptions(path: ''),
          ),
        );
      }

      final storiesResponse = await api.getAllStories('Bearer $token');
      if (!storiesResponse.data.error) {
        return DataSuccess(storiesResponse.data);
      } else {
        return DataError(
          DioException(
            error: storiesResponse.response.statusMessage,
            response: storiesResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: storiesResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (err) {
      return DataError(err);
    }
  }

  @override
  Future<DataState<LoginResponse>> loginUser(
    String email,
    String password,
  ) async {
    try {
      final loginResponse = await api.loginUser(email, password);

      if (!loginResponse.data.error) {
        final token = loginResponse.data.loginResult.token;
        await saveTokenToPreferences(token);
        print('USER TOKEN : $token');

        await saveSessionToPreferences(true);

        return DataSuccess(loginResponse.data);
      } else {
        return DataError(
          DioException(
            error: loginResponse.response.statusMessage,
            response: loginResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: loginResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (err) {
      return DataError(err);
    }
  }

  @override
  Future<DataState<RegisterResponse>> registerUser(
    String username,
    String email,
    String password,
  ) async {
    try {
      final registerResponse = await api.registerUser(
        username,
        email,
        password,
      );

      if (!registerResponse.data.error) {
        return DataSuccess(registerResponse.data);
      } else {
        return DataError(
          DioException(
            error: registerResponse.response.statusMessage,
            response: registerResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: registerResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (err) {
      return DataError(err);
    }
  }

  @override
  Future<DataState<DetailResponse>> getDetailStory(String storyId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString(Constants.tokenKey);

      if (token == null) {
        return DataError(
          DioException(
            requestOptions: RequestOptions(path: ''),
          ),
        );
      }

      final detailResponse = await api.getDetailStory('Bearer $token', storyId);

      if (!detailResponse.data.error) {
        return DataSuccess(detailResponse.data);
      } else {
        return DataError(
          DioException(
            error: detailResponse.response.statusMessage,
            response: detailResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: detailResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (err) {
      return DataError(err);
    }
  }
}

Future<void> saveTokenToPreferences(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(Constants.tokenKey, token);
  print('USER TOKEN SAVED TO PREFERENCE: $token');
}

Future<void> saveSessionToPreferences(bool isLoggedIn) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool(Constants.loginKey, isLoggedIn);
}
