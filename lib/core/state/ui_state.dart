abstract class UiState<T> {
  final T? data;
  final String? error;

  const UiState({this.data, this.error});
}

class LoadingState extends UiState {
  const LoadingState();
}

class ErrorState<T> extends UiState<T> {
  const ErrorState(String error) : super(error: error);
}

class SuccessState<T> extends UiState<T> {
  const SuccessState(T data) : super(data: data);
}
