import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_story_app/core/state/data_state.dart';
import 'package:flutter_story_app/features/story/domain/usecase/upload_story_usecase.dart';
import 'package:flutter_story_app/features/story/presentation/blocs/upload/upload_event.dart';
import 'package:flutter_story_app/features/story/presentation/blocs/upload/upload_state.dart';

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  final UploadStoryUseCase uploadStoryUseCase;

  UploadBloc(this.uploadStoryUseCase) : super(const UploadInitialState()) {
    on<UploadInitialEvent>(onUploadInitialEvent);
    on<UploadStoryEvent>(onUploadStoryEvent);
  }

  void onUploadStoryEvent(
    UploadStoryEvent event,
    Emitter<UploadState> emit,
  ) async {
    emit(const UploadLoadingState());

    final dataState = await uploadStoryUseCase(
      params: UploadStoryParams(event.photo!, event.description!),
    );

    if (dataState is DataSuccess) {
      emit(UploadSuccessState(dataState.data!));
    }

    if (dataState is DataError) {
      emit(UploadErrorState(dataState.error!));
    }
  }

  void onUploadInitialEvent(
    UploadInitialEvent event,
    Emitter<UploadState> emit,
  ) {
    emit(const UploadInitialState());
  }
}
