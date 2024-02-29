import 'dart:ffi';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_story_app/features/story/data/models/responses/detail/detail_response.dart';
import 'package:flutter_story_app/features/story/data/models/responses/login/login_response.dart';
import 'package:flutter_story_app/features/story/data/models/responses/register/register_response.dart';
import 'package:flutter_story_app/features/story/data/models/responses/story/story_response.dart';
import 'package:flutter_story_app/features/story/data/models/responses/upload/upload_response.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: 'https://story-api.dicoding.dev/v1/')
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  @FormUrlEncoded()
  @POST('login')
  Future<HttpResponse<LoginResponse>> loginUser(
    @Field('email') String email,
    @Field('password') String password,
  );

  @FormUrlEncoded()
  @POST('register')
  Future<HttpResponse<RegisterResponse>> registerUser(
    @Field('name') String username,
    @Field('email') String email,
    @Field('password') String password,
  );

  @GET('stories')
  Future<HttpResponse<StoryResponse>> getAllStories(
    @Header('Authorization') String authorization,
  );

  @GET('stories/{id}')
  Future<HttpResponse<DetailResponse>> getDetailStory(
    @Header('Authorization') String authorization,
    @Path('id') String storyId,
  );

  @MultiPart()
  @POST('stories')
  Future<HttpResponse<UploadResponse>> uploadStory(
    @Header('Authorization') String authorization,
    @Part(name: 'description') String description,
    @Part(name: 'photo') File photo,
    @Part(name: 'lat') Float? lat,
    @Part(name: 'lon') Float? lon,
  );
}
