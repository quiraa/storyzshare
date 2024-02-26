import 'package:dio/dio.dart';
import 'package:flutter_story_app/core/constants/constants.dart';
import 'package:flutter_story_app/features/story/data/models/login_response.dart';
import 'package:flutter_story_app/features/story/data/models/register_response.dart';
import 'package:flutter_story_app/features/story/data/models/story_response.dart';
import 'package:retrofit/http.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  @GET(Constants.allStory)
  Future<StoryResponseModel> getAllStories({
    @Header('Authorization') String? authorization,
  });

  @FormUrlEncoded()
  @POST(Constants.login)
  Future<LoginResponseModel> loginUser({
    @Field('email') String? email,
    @Field('password') String? password,
  });

  @FormUrlEncoded()
  @POST(Constants.register)
  Future<RegisterResponseModel> registerUser({
    @Field('username') String? username,
    @Field('email') String? email,
    @Field('password') String? password,
  });
}
