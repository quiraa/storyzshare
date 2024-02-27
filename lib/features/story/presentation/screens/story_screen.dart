import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_story_app/config/themes/typography.dart';
import 'package:flutter_story_app/features/story/presentation/blocs/story/story_State.dart';
import 'package:flutter_story_app/features/story/presentation/blocs/story/story_bloc.dart';
import 'package:flutter_story_app/features/story/presentation/widgets/story_card_item.dart';

class StoryScreen extends StatelessWidget {
  const StoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Story',
          style: StoryTypography.authTitle,
        ),
      ),
    );
  }

  PreferredSizeWidget _storyAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Story App'),
    );
  }

  _buildBody() {
    return BlocBuilder<StoryBloc, StoryState>(builder: (context, state) {
      switch (state.runtimeType) {
        case StoryLoadingState:
        case StoryErrorState:
        case StorySuccessState:
          return AvailableStoryContent(
            listStory: state.response!.listStory,
          );

        default:
          return const SizedBox();
      }
    });
  }
}

// class StoryContent extends HookWidget {
//   final List<StoryResponseItem> listStory;
//   // final void Function(StoryResponseItem story)? onStoryClicked;

//   const StoryContent({
//     Key? key,
//     required this.listStory,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     switch (listStory.isNotEmpty) {
//       case true:
//         return AvailableStoryContent(
//           listStory: listStory,
//         );

//       case false:
//         return const EmptyContentState();
//     }
//   }
// }
