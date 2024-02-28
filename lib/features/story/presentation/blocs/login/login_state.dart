import 'package:dio/dio.dart';
import 'package:flutter_story_app/features/story/data/models/responses/login/login_response.dart';

abstract class LoginState {
  final LoginResponse? response;
  final DioException? error;

  LoginState({this.response, this.error});
}

class LoginInitialState extends LoginState {
  LoginInitialState();
}

class LoginLoadingState extends LoginState {
  LoginLoadingState();
}

class LoginSuccessState extends LoginState {
  LoginSuccessState(LoginResponse response) : super(response: response);
}

class LoginErrorState extends LoginState {
  LoginErrorState(DioException error) : super(error: error);
}
