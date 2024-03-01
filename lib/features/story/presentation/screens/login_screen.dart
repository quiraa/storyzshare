import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_story_app/config/routes/route_config.dart';
import 'package:flutter_story_app/config/routes/screens.dart';
import 'package:flutter_story_app/config/themes/typography.dart';
import 'package:flutter_story_app/features/story/presentation/blocs/login/login_bloc.dart';
import 'package:flutter_story_app/features/story/presentation/blocs/login/login_event.dart';
import 'package:flutter_story_app/features/story/presentation/blocs/login/login_state.dart';
import 'package:flutter_story_app/helpers/helpers.dart';

class LoginScreen extends HookWidget {
  LoginScreen({Key? key}) : super(key: key);

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isVisible = useState(false);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: _buildBody(isVisible),
        ),
      ),
    );
  }

  _buildBody(ValueNotifier<bool> isVisible) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case LoginInitialState:
            return _buildContent(context, isVisible);

          case LoginLoadingState:
            return const CircularProgressIndicator();

          case LoginErrorEvent:
            return AlertDialog(
              title: const Text('Error Occured'),
              content: Text(state.error!.message!),
              actions: [
                TextButton(
                  onPressed: () {
                    BlocProvider.of<LoginBloc>(context).add(
                      const LoginInitialEvent(),
                    );
                  },
                  child: const Text('Retry'),
                )
              ],
            );

          case LoginSuccessState:
            return AlertDialog(
              title: const Text('Success'),
              content: const Text('Click OK to continue'),
              actions: [
                TextButton(
                  onPressed: () {
                    AppRouter.pushAndRemoveUntil(context, Screens.story);
                  },
                  child: const Text('OK  '),
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
                _buildPasswordField(context, isVisible),
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
      validator: (value) => Helpers().validateEmail(value),
      keyboardType: TextInputType.emailAddress,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (value) => FocusScope.of(context).nextFocus(),
    );
  }

  Widget _buildPasswordField(
      BuildContext context, ValueNotifier<bool> isVisible) {
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

  Widget _buildLoginButton(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: FilledButton(
        onPressed: () {
          _loginUser(context);
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
          onPressed: () =>
              AppRouter.pushAndRemoveUntil(context, Screens.register),
          child: const Text(
            'Register',
            style: StoryTypography.authSubtitle,
          ),
        )
      ],
    );
  }

  void _loginUser(BuildContext context) {
    if (_emailController.text.isNotEmpty && _emailController.text.isNotEmpty) {
      final email = _emailController.text.toString();
      final password = _passwordController.text.toString();
      BlocProvider.of<LoginBloc>(context).add(LoginUserEvent(email, password));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all value'),
        ),
      );
    }
  }
}
