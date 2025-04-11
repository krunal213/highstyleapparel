class HighStyleApparelException implements Exception {
  late String cause;
}

class NoInternetException implements HighStyleApparelException {
  NoInternetException();

  @override
  String cause = 'Please check internet connection';
}

class ClientErrorException implements HighStyleApparelException {
  ClientErrorException(this.cause);

  @override
  String cause;
}

class InvalidEmailAddressException implements HighStyleApparelException {
  @override
  String cause = 'Please enter a valid email address.';

  InvalidEmailAddressException();
}

class InvalidPasswordException implements HighStyleApparelException {
  @override
  String cause = 'Please enter a valid password.';

  InvalidPasswordException();
}

class SomethingWentWrongException implements HighStyleApparelException {
  @override
  String cause = 'Oops! Something went wrong.';

  SomethingWentWrongException();
}

class InvalidFirstNameException implements HighStyleApparelException {
  @override
  String cause = 'Please enter a valid first name.';

  InvalidFirstNameException();
}

class InvalidConfirmPasswordException implements HighStyleApparelException {
  @override
  String cause = 'Please enter a valid confirm password.';

  InvalidConfirmPasswordException();
}

class InvalidMobileNumberException implements HighStyleApparelException {
  @override
  String cause = 'Please enter a valid mobile number.';

  InvalidMobileNumberException();
}

class PasswordMisMatchException implements InvalidConfirmPasswordException {
  @override
  String cause =
      'Mismatch detected! Please re-enter the correct confirm password.';

  PasswordMisMatchException();
}
