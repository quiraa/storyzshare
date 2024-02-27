abstract class RegisterEvent {
  final String? username;
  final String? email;
  final String? password;

  const RegisterEvent({this.username, this.email, this.password});
}

// class DefaultRegister extends RegisterEvent {
//   const DefaultRegister();
// }

class Register extends RegisterEvent {
  const Register(
    String username,
    String email,
    String password,
  ) : super(username: username, email: email, password: password);
}
