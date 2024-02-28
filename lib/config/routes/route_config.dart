import 'package:flutter/material.dart';
import 'package:flutter_story_app/config/routes/screens.dart';
import 'package:flutter_story_app/features/story/presentation/screens/detail_screen.dart';
import 'package:flutter_story_app/features/story/presentation/screens/login_screen.dart';
import 'package:flutter_story_app/features/story/presentation/screens/register_screen.dart';
import 'package:flutter_story_app/features/story/presentation/screens/settings_screen.dart';
import 'package:flutter_story_app/features/story/presentation/screens/story_screen.dart';
import 'package:flutter_story_app/features/story/presentation/screens/upload_screen.dart';

PageRoute getPageRoute(String? routeName, Widget? screen) {
  return MaterialPageRoute(
    settings: RouteSettings(name: routeName),
    builder: (context) => screen!,
  );
}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Screens.story:
      return getPageRoute(
        settings.name,
        const StoryScreen(),
      );

    case Screens.detail:
      final args = settings.arguments as String;
      return getPageRoute(
        settings.name,
        DetailScreen(
          storyId: args,
        ),
      );

    case Screens.login:
      return getPageRoute(
        settings.name,
        LoginScreen(),
      );

    case Screens.settings:
      return getPageRoute(
        settings.name,
        SettingsScreen(),
      );

    case Screens.register:
      return getPageRoute(
        settings.name,
        RegisterScreen(),
      );

    case Screens.upload:
      return getPageRoute(
        settings.name,
        UploadScreen(),
      );

    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text('No Routes Defined for ${settings.name}'),
          ),
        ),
      );
  }
}

class AppRouter {
  static void push(BuildContext context, String routeName, {Object? args}) {
    Navigator.pushNamed(context, routeName, arguments: args);
  }

  static void pushAndReplace(BuildContext context, String routeName,
      {Object? args}) {
    Navigator.pushReplacementNamed(context, routeName, arguments: args);
  }

  static void pop(BuildContext context) {
    Navigator.pop(context);
  }
}
