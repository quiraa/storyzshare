import 'package:flutter_story_app/features/story/data/models/responses/register/register_response.dart';

abstract class RegisterState {
  final RegisterResponse? response;
  final String? message;

  const RegisterState({this.response, this.message});
}

class RegisterInitialState extends RegisterState {
  const RegisterInitialState();
}

class RegisterLoadingState extends RegisterState {
  const RegisterLoadingState();
}

class RegisterErrorState extends RegisterState {
  const RegisterErrorState(String message) : super(message: message);
}

class RegisterSuccessState extends RegisterState {
  const RegisterSuccessState(RegisterResponse response)
      : super(response: response);
}
