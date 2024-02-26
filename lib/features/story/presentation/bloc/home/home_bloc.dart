import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_story_app/features/story/domain/usecase/get_all_story_usecase.dart';
import 'package:flutter_story_app/features/story/presentation/bloc/home/home_event.dart';
import 'package:flutter_story_app/features/story/presentation/bloc/home/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetAllStoryUseCase getAllStoryUseCase;

  HomeBloc(this.getAllStoryUseCase) : super(const HomeLoadingState()) {}

  void onGetAllStory(GetAllStoryEvent event, Emitter<HomeState> emit) async {
    final state = await getAllStoryUseCase();

    if (state is HomeSuccessState) {
      emit(HomeSuccessState(state.data!));
    }

    if (state is HomeErrorState) {
      print(state.data!.message ?? '');
      emit(HomeErrorState(state.data!.message ?? ''));
    }
  }
}
