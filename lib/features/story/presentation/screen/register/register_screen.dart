import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_story_app/conf/route/app_router.dart';
import 'package:flutter_story_app/conf/route/screen_routes.dart';

class RegisterScreen extends HookWidget {
  RegisterScreen({Key? key}) : super(key: key);

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _buildBody(context),
      ),
    );
  }

  _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Register',
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 64.0),
          _buildUsernameField(),
          const SizedBox(height: 16.0),
          _buildEmailField(),
          const SizedBox(height: 16.0),
          _buildPasswordField(),
          const SizedBox(height: 16.0),
          _buildRegisterButton(),
          const SizedBox(height: 86.0),
          _buildToLoginButton(context)
        ],
      ),
    );
  }

  Widget _buildUsernameField() {
    return TextFormField(
      controller: _usernameController,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.person),
        label: Text('Username'),
        hintText: 'Enter Username',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.text,
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.mail),
        label: Text('Emal'),
        hintText: 'Enter Email',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.password),
        label: Text('Password'),
        hintText: 'Enter Password',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.visiblePassword,
    );
  }

  Widget _buildRegisterButton() {
    return SizedBox(
      width: double.maxFinite,
      child: FilledButton(
        onPressed: () {},
        child: const Text('Register'),
      ),
    );
  }

  Widget _buildToLoginButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Already have an account?'),
        const SizedBox(
          width: 8.0,
        ),
        TextButton(
          onPressed: () {
            AppRouter.push(context, ScreenRoutes.login);
          },
          child: const Text('Login'),
        )
      ],
    );
  }
}
