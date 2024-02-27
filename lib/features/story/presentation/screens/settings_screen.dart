import 'package:flutter/material.dart';
import 'package:flutter_story_app/config/themes/typography.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Settings', style: StoryTypography.authTitle),
      ),
    );
  }
}
