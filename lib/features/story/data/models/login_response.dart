import 'package:flutter_story_app/features/story/domain/entities/login_response.dart';

class LoginResponseModel extends LoginResponseEntity {
  const LoginResponseModel({
    bool? error,
    String? message,
    LoginResult? loginResult,
  }) : super(
          error: error,
          message: message,
          loginResult: loginResult,
        );

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      error: json['error'],
      message: json['message'],
      loginResult: LoginResult.fromJson(json['loginResult']),
    );
  }

  factory LoginResponseModel.fromEntity(LoginResponseEntity entity) {
    return LoginResponseModel(
      error: entity.error,
      message: entity.message,
      loginResult: entity.loginResult,
    );
  }
}
