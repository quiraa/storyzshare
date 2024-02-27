import 'package:flutter/material.dart';
import 'package:flutter_story_app/features/story/data/models/responses/story/story_response_item.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AvailableStoryContent extends StatelessWidget {
  final List<StoryResponseItem>? listStory;
  // final void Function(StoryResponseItem story)? onStoryClicked;

  const AvailableStoryContent({
    Key? key,
    required this.listStory,
    // required this.onStoryClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemCount: listStory!.length,
      separatorBuilder: (context, index) => const SizedBox(
        height: 16.0,
      ),
      itemBuilder: (context, index) {
        final StoryResponseItem story = listStory![index];
        return StoryCardItem(story: story);
      },
    );
  }
}

class StoryCardItem extends StatelessWidget {
  final StoryResponseItem? story;
  // final void Function(StoryResponseItem story)? onStoryClicked;

  const StoryCardItem({
    Key? key,
    required this.story,
    // required this.onStoryClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {},
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [CachedNetworkImage(imageUrl: story!.photoUrl)],
        ),
      ),
    );
  }
}
