import 'package:flutter/material.dart';
import 'package:flutter_story_app/config/themes/typography.dart';

class LoadingContentState extends StatelessWidget {
  const LoadingContentState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class EmptyContentState extends StatelessWidget {
  const EmptyContentState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.clear,
            size: 64.0,
            color: Colors.redAccent,
          ),
          SizedBox(
            height: 16.0,
          ),
          Text(
            'Empty Journal, Try To Add One',
            style: StoryTypography.authSubtitle,
          )
        ],
      ),
    );
  }
}
