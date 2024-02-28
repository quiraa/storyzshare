import 'package:dio/dio.dart';

abstract class RegisterEvent {
  final String? username;
  final String? email;
  final String? password;
  final DioException? error;

  const RegisterEvent({this.username, this.email, this.password, this.error});
}

class RegisterInitialEvent extends RegisterEvent {
  const RegisterInitialEvent();
}

class RegisterUserEvent extends RegisterEvent {
  const RegisterUserEvent(
    String username,
    String email,
    String password,
  ) : super(username: username, email: email, password: password);
}

class RegisterLoadingEvent extends RegisterEvent {
  const RegisterLoadingEvent();
}

class RegisterErrorEvent extends RegisterEvent {
  RegisterErrorEvent(DioException error) : super(error: error);
}
