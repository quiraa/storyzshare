import 'package:dio/dio.dart';
import 'package:flutter_story_app/features/story/data/models/responses/detail/detail_response.dart';

abstract class DetailState {
  final DetailResponse? response;
  final DioException? error;

  const DetailState({
    this.response,
    this.error,
  });
}

class DetailLoadingState extends DetailState {
  const DetailLoadingState();
}

class DetailErrorState extends DetailState {
  const DetailErrorState(DioException error) : super(error: error);
}

class DetailSuccessState extends DetailState {
  const DetailSuccessState(DetailResponse response) : super(response: response);
}
