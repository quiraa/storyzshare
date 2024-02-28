import 'package:dio/dio.dart';
import 'package:flutter_story_app/features/story/data/models/responses/register/register_response.dart';

abstract class RegisterState {
  final RegisterResponse? response;
  final DioException? error;

  RegisterState({this.response, this.error});
}

class RegisterInitialState extends RegisterState {
  RegisterInitialState();
}

class RegisterLoadingState extends RegisterState {
  RegisterLoadingState();
}

class RegisterSuccessState extends RegisterState {
  RegisterSuccessState(RegisterResponse response) : super(response: response);
}

class RegisterErrorState extends RegisterState {
  RegisterErrorState(DioException error) : super(error: error);
}
