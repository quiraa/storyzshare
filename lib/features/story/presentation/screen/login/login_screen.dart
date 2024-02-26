import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_story_app/conf/route/app_router.dart';
import 'package:flutter_story_app/conf/route/screen_routes.dart';

class LoginScreen extends HookWidget {
  LoginScreen({Key? key}) : super(key: key);

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: _buildBody(context),
    ));
  }

  _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Login',
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 64.0),
          _buildEmailField(),
          const SizedBox(height: 16.0),
          _buildPasswordField(),
          const SizedBox(height: 16.0),
          _buildLoginButton(),
          const SizedBox(height: 64.0),
          _buildToRegisterButton(context)
        ],
      ),
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.mail),
        hintText: 'Your Email',
        label: Text('Email'),
      ),
      validator: (String? value) {},
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.password),
          label: Text('Password'),
          hintText: 'Your Password'),
      validator: (String? value) {},
      keyboardType: TextInputType.visiblePassword,
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.maxFinite,
      child: FilledButton(
        onPressed: () {},
        child: const Text('Login'),
      ),
    );
  }

  Widget _buildToRegisterButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Don\'t have an account?'),
        const SizedBox(
          width: 8.0,
        ),
        TextButton(
          onPressed: () {
            AppRouter.push(context, ScreenRoutes.register);
          },
          child: const Text('Register'),
        ),
      ],
    );
  }
}
