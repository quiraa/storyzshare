import 'package:dio/dio.dart';
import 'package:flutter_story_app/features/story/data/models/responses/upload/upload_response.dart';

abstract class UploadState {
  final UploadResponse? response;
  final DioException? error;

  const UploadState({this.response, this.error});
}

class UploadInitialState extends UploadState {
  const UploadInitialState();
}

class UploadLoadingState extends UploadState {
  const UploadLoadingState();
}

class UploadErrorState extends UploadState {
  const UploadErrorState(DioException error) : super(error: error);
}

class UploadSuccessState extends UploadState {
  const UploadSuccessState(UploadResponse response) : super(response: response);
}
