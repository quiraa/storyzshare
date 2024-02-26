import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_story_app/features/story/domain/entities/story_response.dart';

class StoryCardItem extends StatelessWidget {
  final StoryItem story;
  final void Function(StoryItem story)? onStoryClick;

  const StoryCardItem({
    Key? key,
    required this.story,
    required this.onStoryClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {},
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildStoryImage(),
          ],
        ),
      ),
    );
  }

  Widget _buildStoryImage() {
    return CachedNetworkImage(
      imageUrl: story.photoUrl ?? '',
      placeholder: (context, url) => Container(
        padding: const EdgeInsets.all(
          16.0,
        ),
        child: const CircularProgressIndicator(),
      ),
      errorWidget: (context, url, error) => Container(
        padding: const EdgeInsets.all(16.0),
        child: const Icon(
          Icons.error,
          color: Colors.redAccent,
          size: 48.0,
        ),
      ),
      fit: BoxFit.cover,
      height: 144.0,
      width: double.maxFinite,
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            story.name ?? '',
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            story.description ?? '',
          )
        ],
      ),
    );
  }
}
