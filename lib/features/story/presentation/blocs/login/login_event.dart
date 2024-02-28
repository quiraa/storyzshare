import 'package:dio/dio.dart';

abstract class LoginEvent {
  final String? email;
  final String? password;
  final DioException? error;

  const LoginEvent({this.email, this.password, this.error});
}

class LoginInitialEvent extends LoginEvent {
  const LoginInitialEvent();
}

class LoginUserEvent extends LoginEvent {
  const LoginUserEvent(String email, String password)
      : super(email: email, password: password);
}

class LoginLoadingEvent extends LoginEvent {
  const LoginLoadingEvent();
}

class LoginErrorEvent extends LoginEvent {
  const LoginErrorEvent(DioException error) : super(error: error);
}
