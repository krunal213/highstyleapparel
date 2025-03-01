import 'package:highstyleapparel/login/contract.dart';
import 'package:highstyleapparel/result.dart';
import 'package:rx/constructors.dart' as rx;
import 'package:rx/converters.dart';

class InvalidEmailAddressException implements Exception {
  String cause = 'Please enter a valid email address.';

  InvalidEmailAddressException();
}

class InvalidPasswordException implements Exception {
  String cause = 'Please enter a valid password.';

  InvalidPasswordException();
}

class SomethingWentWrongException implements Exception {
  String cause = 'Oops! Something went wrong.';

  SomethingWentWrongException();
}

class InvalidFirstNameException implements Exception {
  String cause = 'Please enter a valid first name.';

  InvalidFirstNameException();
}

class InvalidConfirmPasswordException implements Exception {
  String cause = 'Please enter a valid confirm password.';

  InvalidConfirmPasswordException();
}

class InvalidMobileNumberException implements Exception {
  String cause = 'Please enter a valid mobile number.';

  InvalidMobileNumberException();
}

class PasswordMisMatchException implements Exception {
  String cause =
      'Mismatch detected! Please re-enter the correct confirm password.';

  PasswordMisMatchException();
}

class InvalidOTPException implements Exception {
  String cause = 'Please enter a valid otp.';

  InvalidOTPException();
}

class LoginFlowBloc {
  late final LoginFlowRepository _loginRepository;
  final _emailRegex =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

  LoginFlowBloc(this._loginRepository);

  login(String? emailAddress, String? password) => rx.create((emit) {
        emit.onNext(Loading());
        try {
          if (emailAddress == null) {
            throw InvalidEmailAddressException();
          }
          if (emailAddress.isEmpty) {
            throw InvalidEmailAddressException();
          }
          if (!_emailRegex.hasMatch(emailAddress)) {
            throw InvalidEmailAddressException();
          }
          if (password == null) {
            throw InvalidPasswordException();
          }
          if (password.isEmpty) {
            throw InvalidPasswordException();
          }
          emit.onNext(Success(_loginRepository.login(emailAddress, password)));
        } on InvalidEmailAddressException catch (e) {
          emit.onNext(Error(e));
        } on InvalidPasswordException catch (e) {
          emit.onNext(Error(e));
        } on Exception {
          emit.onNext(Error(SomethingWentWrongException()));
        }
        emit.complete();
      }).toStream();

  signup(String? firstName, String? lastName, String? emailAddress,
          String? password, String? confirmPassword, String? mobileNumber) =>
      rx.create((emit) {
        emit.onNext(Loading());
        try {
          if (firstName == null) {
            throw InvalidFirstNameException();
          }
          if (firstName.isEmpty) {
            throw InvalidFirstNameException();
          }
          if (emailAddress == null) {
            throw InvalidEmailAddressException();
          }
          if (emailAddress.isEmpty) {
            throw InvalidEmailAddressException();
          }
          if (!_emailRegex.hasMatch(emailAddress)) {
            throw InvalidEmailAddressException();
          }
          if (password == null) {
            throw InvalidPasswordException();
          }
          if (password.isEmpty) {
            throw InvalidPasswordException();
          }
          if (confirmPassword == null) {
            throw InvalidConfirmPasswordException();
          }
          if (confirmPassword.isEmpty) {
            throw InvalidConfirmPasswordException();
          }
          if (confirmPassword != password) {
            throw PasswordMisMatchException();
          }
          if (mobileNumber == null) {
            throw InvalidMobileNumberException();
          }
          if (mobileNumber.isEmpty) {
            throw InvalidMobileNumberException();
          }
          if (mobileNumber.length != 10) {
            throw InvalidMobileNumberException();
          }
          emit.onNext(Success(_loginRepository.signup(firstName, lastName,
              emailAddress, password, confirmPassword, mobileNumber)));
        } on InvalidFirstNameException catch (e) {
          emit.onNext(Error(e));
        } on InvalidEmailAddressException catch (e) {
          emit.onNext(Error(e));
        } on InvalidPasswordException catch (e) {
          emit.onNext(Error(e));
        } on InvalidConfirmPasswordException catch (e) {
          emit.onNext(Error(e));
        } on PasswordMisMatchException catch (e) {
          emit.onNext(Error(e));
        } on InvalidMobileNumberException catch (e) {
          emit.onNext(Error(e));
        } on Exception {
          emit.onNext(Error(SomethingWentWrongException()));
        }
        emit.complete();
      }).toStream();

  forgotPassword(String? emailAddress) => rx.create((emit) {
        emit.onNext(Loading());
        try {
          if (emailAddress == null) {
            throw InvalidEmailAddressException();
          }
          if (emailAddress.isEmpty) {
            throw InvalidEmailAddressException();
          }
          if (!_emailRegex.hasMatch(emailAddress)) {
            throw InvalidEmailAddressException();
          }
          emit.onNext(Success(_loginRepository.forgotPassword(emailAddress)));
        } on InvalidEmailAddressException catch (e) {
          emit.onNext(Error(e));
        } on Exception {
          emit.onNext(Error(SomethingWentWrongException()));
        }
        emit.complete();
      }).toStream();

  createNewPassword(String? password, String? confirmPassword) =>
      rx.create((emit) {
        emit.onNext(Loading());
        try {
          if (password == null) {
            throw InvalidPasswordException();
          }
          if (password.isEmpty) {
            throw InvalidPasswordException();
          }
          if (confirmPassword == null) {
            throw InvalidConfirmPasswordException();
          }
          if (confirmPassword.isEmpty) {
            throw InvalidConfirmPasswordException();
          }
          if (confirmPassword != password) {
            throw PasswordMisMatchException();
          }
          emit.onNext(Success(
              _loginRepository.createNewPassword(password, confirmPassword)));
        } on InvalidPasswordException catch (e) {
          emit.onNext(Error(e));
        } on InvalidConfirmPasswordException catch (e) {
          emit.onNext(Error(e));
        } on PasswordMisMatchException catch (e) {
          emit.onNext(Error(e));
        } on Exception {
          emit.onNext(Error(SomethingWentWrongException()));
        }
        emit.complete();
      }).toStream();

  verifyOtp(String? verifyCode) => rx.create((emit) {
        emit.onNext(Loading());
        try {
          if (verifyCode == null) {
            throw InvalidOTPException();
          }
          if (verifyCode.isEmpty) {
            throw InvalidOTPException();
          }
          if (verifyCode.length != 6) {
            throw InvalidOTPException();
          }
          emit.onNext(Success(_loginRepository.verifyCode(verifyCode)));
        } on InvalidOTPException catch (e) {
          emit.onNext(Error(e));
        } on Exception {
          emit.onNext(Error(SomethingWentWrongException()));
        }
        emit.complete();
      }).toStream();
}
