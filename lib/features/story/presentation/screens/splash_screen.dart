import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_story_app/config/routes/route_config.dart';
import 'package:flutter_story_app/config/routes/screens.dart';
import 'package:flutter_story_app/config/themes/typography.dart';
import 'package:flutter_story_app/features/story/data/preferences/user_preference.dart';

class SplashScreen extends HookWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      void checkUserToken() async {
        await Future.delayed(const Duration(seconds: 2));

        final token = await UserPreference.getToken();

        if (token != null && token.isNotEmpty) {
          AppRouter.pushAndReplace(context, Screens.story);
        } else {
          AppRouter.pushAndReplace(context, Screens.login);
        }
      }

      checkUserToken();
      return () {};
    }, []);
    return const Scaffold(
      body: Center(
        child: Text(
          'Story App',
          style: StoryTypography.authTitle,
        ),
      ),
    );
  }
}
