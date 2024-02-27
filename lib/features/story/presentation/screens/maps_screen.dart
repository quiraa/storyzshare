import 'package:flutter/material.dart';
import 'package:flutter_story_app/config/themes/typography.dart';

class MapsScreen extends StatelessWidget {
  const MapsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Text(
        'Maps',
        style: StoryTypography.authTitle,
      )),
    );
  }
}
