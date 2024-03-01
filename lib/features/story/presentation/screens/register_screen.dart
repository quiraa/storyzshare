import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_story_app/config/routes/route_config.dart';
import 'package:flutter_story_app/config/routes/screens.dart';
import 'package:flutter_story_app/config/themes/typography.dart';
import 'package:flutter_story_app/features/story/presentation/blocs/register/register_bloc.dart';
import 'package:flutter_story_app/features/story/presentation/blocs/register/register_event.dart';
import 'package:flutter_story_app/features/story/presentation/blocs/register/register_state.dart';
import 'package:flutter_story_app/helpers/helpers.dart';

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
      validator: (value) => Helpers().validateUsername(value),
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
      validator: (value) => Helpers().validateEmail(value),
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
          onPressed: () => Helpers().togglePasswordVisibility(isVisible),
          icon: Icon(
            isVisible.value ? Icons.visibility : Icons.visibility_off,
          ),
        ),
      ),
      validator: (value) => Helpers().validatePassword(value),
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
