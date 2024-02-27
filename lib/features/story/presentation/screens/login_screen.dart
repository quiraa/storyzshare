import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_story_app/config/routes/route_config.dart';
import 'package:flutter_story_app/config/routes/screens.dart';
import 'package:flutter_story_app/config/themes/typography.dart';
import 'package:flutter_story_app/features/story/presentation/blocs/login/login_bloc.dart';
import 'package:flutter_story_app/features/story/presentation/blocs/login/login_event.dart';

class LoginScreen extends HookWidget {
  LoginScreen({Key? key}) : super(key: key);

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: _buildContent(context),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Login',
                  style: StoryTypography.authTitle,
                ),
                const SizedBox(
                  height: 32.0,
                ),
                _buildEmailField(context),
                const SizedBox(
                  height: 16.0,
                ),
                _buildPasswordField(context),
                const SizedBox(
                  height: 16.0,
                ),
                _buildLoginButton(context),
                const SizedBox(
                  height: 64.0,
                ),
                _buildNavigateToRegisterButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField(BuildContext context) {
    return TextFormField(
      controller: _emailController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Enter Email',
        label: Text('Email'),
        prefixIcon: Icon(Icons.email),
      ),
      validator: _validateEmail,
      keyboardType: TextInputType.emailAddress,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (value) => FocusScope.of(context).nextFocus(),
    );
  }

  Widget _buildPasswordField(BuildContext context) {
    final isVisible = useState(false);

    return TextFormField(
      controller: _passwordController,
      obscureText: !isVisible.value,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: 'Enter Password',
        label: const Text('Password'),
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          onPressed: () => _togglePasswordVisibility(isVisible),
          icon: Icon(
            isVisible.value ? Icons.visibility : Icons.visibility_off,
          ),
        ),
      ),
      validator: _validatePassword,
      keyboardType: TextInputType.visiblePassword,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (value) => FocusScope.of(context).unfocus(),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: FilledButton(
        onPressed: () {
          _login(context);
        },
        child: const Text(
          'Login',
          style: StoryTypography.authSubtitle,
        ),
      ),
    );
  }

  Widget _buildNavigateToRegisterButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Don\'t have an account?',
          style: StoryTypography.authSubtitle,
        ),
        const SizedBox(
          width: 8.0,
        ),
        TextButton(
          onPressed: () => AppRouter.push(context, Screens.register),
          child: const Text(
            'Register',
            style: StoryTypography.authSubtitle,
          ),
        )
      ],
    );
  }

  void _togglePasswordVisibility(ValueNotifier<bool> passwordVisible) {
    // Periksa apakah teks password sedang terlihat atau tersembunyi, lalu ubah nilainya
    passwordVisible.value = !passwordVisible.value;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }
    // Regular expression untuk memeriksa format email
    String pattern = r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  void _login(BuildContext context) {
    if (_emailController.text.isNotEmpty && _emailController.text.isNotEmpty) {
      final email = _emailController.text;
      final password = _passwordController.text;
      BlocProvider.of<LoginBloc>(context).add(Login(email, password));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all value'),
        ),
      );
    }
  }
}