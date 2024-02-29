import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_story_app/config/routes/route_config.dart';
import 'package:flutter_story_app/config/routes/screens.dart';
import 'package:flutter_story_app/features/story/data/models/responses/story/story_response_item.dart';
import 'package:flutter_story_app/features/story/presentation/blocs/detail/detail_bloc.dart';
import 'package:flutter_story_app/features/story/presentation/blocs/detail/detail_event.dart';
import 'package:flutter_story_app/features/story/presentation/blocs/story/story_State.dart';
import 'package:flutter_story_app/features/story/presentation/blocs/story/story_bloc.dart';
import 'package:flutter_story_app/features/story/presentation/blocs/story/story_event.dart';
import 'package:flutter_story_app/features/story/presentation/widgets/content_state.dart';
import 'package:flutter_story_app/features/story/presentation/widgets/story_card_item.dart';

class StoryScreen extends HookWidget {
  const StoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _buildBody(),
      ),
    );
  }

  _buildBody() {
    return BlocBuilder<StoryBloc, StoryState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case StoryLoadingState:
            return const Center(
              child: CircularProgressIndicator(),
            );

          case StoryErrorState:
            return AlertDialog(
              title: const Text('Error Occured'),
              content: Text(state.error!.message!),
              actions: [
                TextButton(
                  onPressed: () {
                    BlocProvider.of<StoryBloc>(context).add(
                      const GetStoriesEvent(),
                    );
                  },
                  child: const Text('Retry'),
                ),
              ],
            );

          case StorySuccessState:
            return StoryContent(
              listStory: state.response!.listStory,
              onStoryClicked: (String storyId) {
                BlocProvider.of<DetailBloc>(context).add(
                  GetDetailStoryEvent(storyId),
                );
                AppRouter.push(context, Screens.detail, args: storyId);
              },
            );

          default:
            return const SizedBox();
        }
      },
    );
  }
}

class StoryContent extends HookWidget {
  final List<StoryResponseItem> listStory;
  final void Function(String storyId) onStoryClicked;

  const StoryContent({
    Key? key,
    required this.listStory,
    required this.onStoryClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      floatingActionButton: _fabUpload(context),
      body: listStory.isNotEmpty
          ? AvailableStoryContent(
              listStory: listStory,
              onStoryClicked: onStoryClicked,
            )
          : const EmptyContentState(),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      title: const Text('Story App'),
      centerTitle: true,
      automaticallyImplyLeading: false,
      surfaceTintColor: Colors.white,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: IconButton(
            onPressed: () => AppRouter.push(context, Screens.settings),
            icon: const Icon(Icons.settings_rounded),
          ),
        )
      ],
    );
  }

  Widget _fabUpload(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => AppRouter.push(context, Screens.upload),
      child: const Icon(
        Icons.upload_file_rounded,
      ),
    );
  }
}
