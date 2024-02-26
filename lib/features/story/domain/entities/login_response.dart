import 'package:equatable/equatable.dart';

class LoginResponseEntity extends Equatable {
  final bool? error;
  final String? message;
  final LoginResult? loginResult;

  const LoginResponseEntity({
    this.error,
    this.message,
    this.loginResult,
  });

  @override
  List<Object?> get props {
    return [
      error,
      message,
      loginResult,
    ];
  }
}

class LoginResult {
  final String? userId;
  final String? name;
  final String? token;

  const LoginResult({
    this.userId,
    this.name,
    this.token,
  });

  factory LoginResult.fromJson(Map<String, dynamic> json) {
    return LoginResult(
      userId: json['userId'],
      name: json['name'],
      token: json['token'],
    );
  }
}
