import 'package:flutter_story_app/features/story/data/models/responses/login/login_response.dart';

abstract class LoginState {
  final LoginResponse? response;
  final String? message;

  const LoginState({this.response, this.message});
}

class LoginInitialState extends LoginState {
  const LoginInitialState();
}

class LoginLoadingState extends LoginState {
  const LoginLoadingState();
}

class LoginErrorState extends LoginState {
  const LoginErrorState(String message) : super(message: message);
}

class LoginSuccessState extends LoginState {
  const LoginSuccessState(LoginResponse response) : super(response: response);
}
