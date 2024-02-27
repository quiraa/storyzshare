abstract class DataState<T> {
  final T? data;
  final String? errorMessage;

  const DataState({this.data, this.errorMessage});
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);
}

class DataError<T> extends DataState<T> {
  const DataError(String errorMessage) : super(errorMessage: errorMessage);
}
