import 'package:flutter_story_app/features/story/domain/entities/register_response.dart';

class RegisterResponseModel extends RegisterResponseEntity {
  const RegisterResponseModel({
    bool? error,
    String? message,
  }) : super(
          error: error,
          message: message,
        );

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      error: json['error'],
      message: json['message'],
    );
  }

  factory RegisterResponseModel.fromEntity(RegisterResponseEntity entity) {
    return RegisterResponseModel(
      error: entity.error,
      message: entity.message,
    );
  }
}
