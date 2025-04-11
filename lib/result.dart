import 'package:highstyleapparel/exceptions.dart';

sealed class Result<T> {}

class Loading extends Result<Never> {

  Loading();
}

class Success<T> extends Result<T> {
  final T value;

  Success(this.value);
}

class Error extends Result<Never> {
  final HighStyleApparelException exception;

  Error(this.exception);
}
