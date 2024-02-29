import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_story_app/core/state/data_state.dart';
import 'package:flutter_story_app/features/story/domain/usecase/get_detail_story_usecase.dart';
import 'package:flutter_story_app/features/story/presentation/blocs/detail/detail_event.dart';
import 'package:flutter_story_app/features/story/presentation/blocs/detail/detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final GetDetailStoryUseCase getDetailStoryUseCase;

  DetailBloc(this.getDetailStoryUseCase) : super(const DetailLoadingState()) {
    on<GetDetailStoryEvent>(onGetDetailStoryEvent);
  }

  void onGetDetailStoryEvent(
    GetDetailStoryEvent event,
    Emitter<DetailState> emit,
  ) async {
    final state = await getDetailStoryUseCase(
      params: GetDetailStoryParams(event.storyId!),
    );

    if (state is DataSuccess) {
      emit(DetailSuccessState(state.data!));
    }

    if (state is DataError) {
      emit(DetailErrorState(state.error!));
    }
  }
}
