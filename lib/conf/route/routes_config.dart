import 'package:flutter/material.dart';
import 'package:flutter_story_app/conf/route/screen_routes.dart';
import 'package:flutter_story_app/features/story/presentation/screen/home/home_screen.dart';
import 'package:flutter_story_app/features/story/presentation/screen/register/register_screen.dart';
import 'package:flutter_story_app/features/story/presentation/screen/login/login_screen.dart';

class RoutesConfig {
  PageRoute getPageRoute(String? routeName, Widget? screen) {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => screen!,
    );
  }

  Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case ScreenRoutes.home:
        return getPageRoute(
          settings.name,
          HomeScreen(),
        );

      case ScreenRoutes.login:
        return getPageRoute(
          settings.name,
          LoginScreen(),
        );

      case ScreenRoutes.register:
        return getPageRoute(
          settings.name,
          RegisterScreen(),
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
}
