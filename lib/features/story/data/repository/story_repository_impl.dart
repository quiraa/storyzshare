import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_story_app/core/state/data_state.dart';
import 'package:flutter_story_app/features/story/data/models/responses/detail/detail_response.dart';
import 'package:flutter_story_app/features/story/data/models/responses/login/login_response.dart';
import 'package:flutter_story_app/features/story/data/models/responses/register/register_response.dart';
import 'package:flutter_story_app/features/story/data/models/responses/story/story_response.dart';
import 'package:flutter_story_app/features/story/data/models/responses/upload/upload_response.dart';
import 'package:flutter_story_app/features/story/data/preferences/user_preference.dart';
import 'package:flutter_story_app/features/story/data/sources/api/api_service.dart';
import 'package:flutter_story_app/features/story/domain/repository/story_repository.dart';
import 'package:flutter_story_app/helpers/helpers.dart';

class StoryRepositoryImpl implements StoryRepository {
  final ApiService api;

  StoryRepositoryImpl(this.api);

  @override
  Future<DataState<StoryResponse>> getStories() async {
    try {
      String? token = await UserPreference.getToken();

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
        await UserPreference.setToken(loginResponse.data.loginResult.token);
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
  Future<DataState<UploadResponse>> uploadStory(
    File photo,
    String description,
  ) async {
    try {
      String? token = await UserPreference.getToken();
      File compressedPhoto = await Helpers.compressImage(photo);

      final uploadResponse = await api.uploadStory(
        'Bearer $token',
        description,
        compressedPhoto,
        null,
        null,
      );

      if (!uploadResponse.data.error) {
        return DataSuccess(uploadResponse.data);
      } else {
        return DataError(
          DioException(
            error: uploadResponse.response.statusMessage,
            response: uploadResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: uploadResponse.response.requestOptions,
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
      String? token = await UserPreference.getToken();

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
            type: DioExceptionType.badResponse,
            response: detailResponse.response,
            requestOptions: detailResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (err) {
      return DataError(err);
    }
  }
}
