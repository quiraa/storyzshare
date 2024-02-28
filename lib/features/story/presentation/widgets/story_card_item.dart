import 'package:flutter/material.dart';
import 'package:flutter_story_app/config/themes/typography.dart';
import 'package:flutter_story_app/features/story/data/models/responses/story/story_response_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_story_app/helpers/helpers.dart';

class AvailableStoryContent extends StatelessWidget {
  final List<StoryResponseItem>? listStory;
  final void Function(String? storyId)? onStoryClicked;

  const AvailableStoryContent({
    Key? key,
    required this.listStory,
    required this.onStoryClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemCount: listStory?.length ?? 0,
      separatorBuilder: (context, index) => const SizedBox(
        height: 16.0,
      ),
      itemBuilder: (context, index) {
        final StoryResponseItem story = listStory![index];
        return StoryCardItem(
          story: story,
          onStoryClicked: onStoryClicked,
        );
      },
    );
  }
}

class StoryCardItem extends StatelessWidget {
  final StoryResponseItem? story;
  final void Function(String? storyId)? onStoryClicked;

  const StoryCardItem({
    Key? key,
    required this.story,
    required this.onStoryClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          if (onStoryClicked != null && story != null) {
            onStoryClicked!(story!.id);
          }
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: _buildImageBody(),
            ),
            Expanded(
              flex: 3,
              child: _buildContent(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildImageBody() {
    return CachedNetworkImage(
      imageUrl: story?.photoUrl ?? '',
      errorWidget: (context, url, error) => const Padding(
        padding: EdgeInsets.all(32),
        child: Icon(Icons.image_not_supported),
      ),
      placeholder: (context, url) => const Padding(
        padding: EdgeInsets.all(32),
        child: CircularProgressIndicator(),
      ),
      height: 190,
      width: 156,
      fit: BoxFit.cover,
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            story?.name ?? '',
            style: StoryTypography.storyTitle,
            maxLines: 2,
          ),
          const SizedBox(height: 8),
          Text(
            story?.description ?? '',
            style: StoryTypography.storyDescription,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Text(
            Helpers.formatDate(story?.createdAt ?? ''),
            style: StoryTypography.storyDate,
            maxLines: 2,
          )
        ],
      ),
    );
  }
}
