import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_story_app/config/routes/route_config.dart';
import 'package:flutter_story_app/config/themes/typography.dart';
import 'package:flutter_story_app/features/story/data/models/responses/story/story_response_item.dart';
import 'package:flutter_story_app/features/story/presentation/blocs/detail/detail_bloc.dart';
import 'package:flutter_story_app/features/story/presentation/blocs/detail/detail_state.dart';
import 'package:flutter_story_app/helpers/helpers.dart';

class DetailScreen extends HookWidget {
  final String? storyId;

  const DetailScreen({
    Key? key,
    required this.storyId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  _buildBody() {
    return BlocBuilder<DetailBloc, DetailState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case DetailLoadingState:
            return const Center(
              child: CircularProgressIndicator(),
            );

          case DetailErrorState:
            return Center(
              child: Text(
                state.error!.message!,
                textAlign: TextAlign.center,
              ),
            );

          case DetailSuccessState:
            return Scaffold(
              appBar: _appBar(context),
              body: _buildContent(
                context,
                state.response!.story,
              ),
            );

          default:
            return const Center(
              child: Text('Failed to get Story'),
            );
        }
      },
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      title: const Text('Detail Story'),
      centerTitle: true,
      leading: IconButton(
        onPressed: () => AppRouter.pop(context),
        icon: const Icon(Icons.arrow_back_ios_new_rounded),
      ),
    );
  }

  Widget _buildContent(BuildContext context, StoryResponseItem story) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImageBody(context, story),
          _buildDescriptionBody(context, story),
        ],
      ),
    );
  }

  Widget _buildImageBody(BuildContext context, StoryResponseItem story) {
    return CachedNetworkImage(
      imageUrl: story.photoUrl,
      placeholder: (context, url) => const Padding(
        padding: EdgeInsets.all(32.0),
        child: CircularProgressIndicator(),
      ),
      errorWidget: (context, url, error) => const Padding(
        padding: EdgeInsets.all(32.0),
        child: Icon(Icons.image_not_supported_rounded),
      ),
      height: 240,
      width: double.maxFinite,
      fit: BoxFit.cover,
    );
  }

  Widget _buildDescriptionBody(BuildContext context, StoryResponseItem story) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            story.name,
            style: StoryTypography.detailTitle,
          ),
          const SizedBox(height: 16.0),
          Text(
            Helpers.formatDate(story.createdAt),
            style: StoryTypography.detailDate,
          ),
          const SizedBox(height: 16.0),
          Text(
            story.description,
            style: StoryTypography.detailDescription,
          ),
        ],
      ),
    );
  }
}
