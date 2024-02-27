import 'package:json_annotation/json_annotation.dart';

part 'login_result_response.g.dart';

@JsonSerializable()
class LoginResultResponse {
  final String userId;
  final String name;
  final String token;

  LoginResultResponse({
    required this.userId,
    required this.name,
    required this.token,
  });

  factory LoginResultResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResultResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResultResponseToJson(this);
}
