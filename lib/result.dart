sealed class Result<T> {}

class Loading extends Result<void> {}

class Success<T> extends Result<T> {
  final T value;
  Success(this.value);
}

class Error extends Result<void> {
  final Exception exception;
  Error(this.exception);
}


