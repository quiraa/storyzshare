abstract class LoginEvent {
  final String? email;
  final String? password;

  const LoginEvent({this.email, this.password});
}

class DefaultLogin extends LoginEvent {
  const DefaultLogin();
}

class Login extends LoginEvent {
  const Login(
    String email,
    String password,
  ) : super(email: email, password: password);
}
