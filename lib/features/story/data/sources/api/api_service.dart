import 'package:dio/dio.dart';
import 'package:flutter_story_app/core/constants/constants.dart';
import 'package:flutter_story_app/features/story/data/models/responses/detail/detail_response.dart';
import 'package:flutter_story_app/features/story/data/models/responses/login/login_response.dart';
import 'package:flutter_story_app/features/story/data/models/responses/register/register_response.dart';
import 'package:flutter_story_app/features/story/data/models/responses/story/story_response.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  @GET(Constants.getAllStories)
  Future<HttpResponse<StoryResponse>> getAllStories(
    @Header('Authorization') String authorization,
  );

  @FormUrlEncoded()
  @GET(Constants.login)
  Future<HttpResponse<LoginResponse>> loginUser(
    @Field('email') String email,
    @Field('password') String password,
  );

  @FormUrlEncoded()
  @GET(Constants.register)
  Future<HttpResponse<RegisterResponse>> registerUser(
    @Field('username') String username,
    @Field('email') String email,
    @Field('password') String password,
  );

  @GET('/stories/{id}')
  Future<HttpResponse<DetailResponse>> getDetailStory(
    @Path('id') String id,
    @Header('Authorization') String authorization,
  );
}
