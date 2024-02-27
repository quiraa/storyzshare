import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_story_app/core/state/data_state.dart';
import 'package:flutter_story_app/features/story/domain/usecase/get_stories_usecase.dart';
import 'package:flutter_story_app/features/story/presentation/blocs/story/story_State.dart';
import 'package:flutter_story_app/features/story/presentation/blocs/story/story_event.dart';

class StoryBloc extends Bloc<StoryEvent, StoryState> {
  final GetStoriesUseCase getStoriesUseCase;

  StoryBloc(this.getStoriesUseCase) : super(const StoryLoadingState()) {
    on<GetStoriesEvent>(onGetStoriesEvent);
  }

  void onGetStoriesEvent(
    GetStoriesEvent event,
    Emitter<StoryState> emit,
  ) async {
    final state = await getStoriesUseCase();

    if (state is DataSuccess) {
      emit(StorySuccessState(state.data!));
    }

    if (state is DataError) {
      emit(StoryErrorState(state.errorMessage!));
    }
  }
}
