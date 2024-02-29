import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_story_app/config/routes/route_config.dart';
import 'package:flutter_story_app/config/routes/screens.dart';
import 'package:flutter_story_app/config/themes/typography.dart';
import 'package:flutter_story_app/features/story/presentation/blocs/register/register_bloc.dart';
import 'package:flutter_story_app/features/story/presentation/blocs/register/register_event.dart';
import 'package:flutter_story_app/features/story/presentation/blocs/register/register_state.dart';

class RegisterScreen extends HookWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isVisible = useState<bool>(false);
    return Scaffold(
      body: _buildBody(isVisible),
    );
  }

  _buildBody(ValueNotifier<bool> isVisible) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case RegisterInitialState:
            return _buildContent(context, isVisible);

          case RegisterLoadingState:
            return const Center(
              child: CircularProgressIndicator(),
            );

          case RegisterSuccessState:
            return AlertDialog(
              title: const Text('Success'),
              content: const Text('Click OK to continue'),
              actions: [
                TextButton(
                  onPressed: () => AppRouter.push(context, Screens.login),
                  child: const Text('OK'),
                )
              ],
            );

          case RegisterErrorState:
            return AlertDialog(
              title: const Text('Error Occured'),
              content: Text(state.error!.message!),
              actions: [
                TextButton(
                  onPressed: () {
                    BlocProvider.of<RegisterBloc>(context).add(
                      const RegisterInitialEvent(),
                    );
                  },
                  child: const Text('OK'),
                )
              ],
            );

          default:
            return _buildContent(context, isVisible);
        }
      },
    );
  }

  Widget _buildContent(
    BuildContext context,
    ValueNotifier<bool> isVisible,
  ) {
    return Center(
        child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Register',
              style: StoryTypography.authTitle,
            ),
            const SizedBox(
              height: 32.0,
            ),
            _buildUsernameField(context),
            const SizedBox(
              height: 16.0,
            ),
            _buildEmailField(context),
            const SizedBox(
              height: 16.0,
            ),
            _buildPasswordField(context, isVisible),
            const SizedBox(
              height: 16.0,
            ),
            _buildRegisterButton(context),
            const SizedBox(
              height: 64.0,
            ),
            _buildNavigateToLoginButton(context),
          ],
        ),
      ),
    ));
  }

  Widget _buildUsernameField(BuildContext context) {
    return TextFormField(
      controller: _usernameController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Enter Username',
        label: Text('Username'),
        prefixIcon: Icon(Icons.person),
      ),
      validator: _validateUsername,
      keyboardType: TextInputType.emailAddress,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (value) => FocusScope.of(context).nextFocus(),
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

  Widget _buildPasswordField(
    BuildContext context,
    ValueNotifier<bool> isVisible,
  ) {
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

  Widget _buildRegisterButton(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: FilledButton(
        onPressed: () => _registerUser(context),
        child: const Text(
          'Register',
          style: StoryTypography.authSubtitle,
        ),
      ),
    );
  }

  Widget _buildNavigateToLoginButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Already have an account?',
          style: StoryTypography.authSubtitle,
        ),
        const SizedBox(
          width: 8.0,
        ),
        TextButton(
          onPressed: () => AppRouter.pushAndRemoveUntil(context, Screens.login),
          child: const Text(
            'Login',
            style: StoryTypography.authSubtitle,
          ),
        )
      ],
    );
  }

  void _togglePasswordVisibility(ValueNotifier<bool> passwordVisible) {
    passwordVisible.value = !passwordVisible.value;
  }

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a username';
    }
    if (value.length < 4) {
      return 'Username must be at least 4 characters long';
    }
    return null;
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

    String pattern = r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  void _registerUser(BuildContext context) {
    if (_usernameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      final username = _usernameController.text.toString();
      final email = _emailController.text.toString();
      final password = _passwordController.text.toString();

      BlocProvider.of<RegisterBloc>(context).add(
        RegisterUserEvent(username, email, password),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in the blank fields'),
        ),
      );
    }
  }
}
