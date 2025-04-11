import 'package:highstyleapparel/exceptions.dart';
import 'package:highstyleapparel/login/contract.dart';
import 'package:highstyleapparel/login/entity/register_request.dart';
import 'package:highstyleapparel/result.dart';
import 'package:rxdart/rxdart.dart';

class SignUpBloc {
  late final LoginFlowRepository _loginRepository;

  final _emailRegex =
      RegExp(r'^(?!.*\.\.)[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

  final _phoneNumberRegex = RegExp(r'^[6-9]\d{9}$');

  final _signUpStreamController = BehaviorSubject<Result<String>>();

  Stream<Result<String>> get signUpStream => _signUpStreamController.stream;

  final _invalidFirstNameStreamController = BehaviorSubject<String>();

  Stream<String> get invalidFirstNameStream =>
      _invalidFirstNameStreamController.stream;

  final _invalidEmailStreamController = BehaviorSubject<String>();

  Stream<String> get invalidEmailStream => _invalidEmailStreamController.stream;

  final _invalidPasswordStreamController = BehaviorSubject<String>();

  Stream<String> get invalidPasswordStream =>
      _invalidPasswordStreamController.stream;

  final _invalidConfirmPasswordStreamController = BehaviorSubject<String>();

  Stream<String> get invalidConfirmPasswordStream =>
      _invalidConfirmPasswordStreamController.stream;

  final _invalidMobileNumberStreamController = BehaviorSubject<String>();

  Stream<String> get invalidMobileNumberStream =>
      _invalidMobileNumberStreamController.stream;

  SignUpBloc(this._loginRepository);

  signup(String firstName, String lastName, String emailAddress,
      String password, String confirmPassword, String mobileNumber) async {
    _signUpStreamController.add(Loading());
    try {
      if (firstName.isEmpty) {
        throw InvalidFirstNameException();
      }
      if (emailAddress.isEmpty) {
        throw InvalidEmailAddressException();
      }
      if (!_emailRegex.hasMatch(emailAddress)) {
        throw InvalidEmailAddressException();
      }
      if (password.isEmpty) {
        throw InvalidPasswordException();
      }
      if (confirmPassword.isEmpty) {
        throw InvalidConfirmPasswordException();
      }
      if (confirmPassword != password) {
        throw PasswordMisMatchException();
      }
      if (mobileNumber.isEmpty) {
        throw InvalidMobileNumberException();
      }
      if (!_phoneNumberRegex.hasMatch(mobileNumber)) {
        throw InvalidMobileNumberException();
      }
      _signUpStreamController.add(await _loginRepository.signup(RegisterRequest(
          firstName,
          lastName,
          emailAddress,
          password,
          int.parse(mobileNumber))));
    } on InvalidFirstNameException catch (e) {
      _signUpStreamController.add(Error(e));
      _invalidFirstNameStreamController.addError(e.cause);
    } on InvalidEmailAddressException catch (e) {
      _signUpStreamController.add(Error(e));
      _invalidFirstNameStreamController.addError("");
      _invalidEmailStreamController.addError(e.cause);
    } on InvalidPasswordException catch (e) {
      _signUpStreamController.add(Error(e));
      _invalidFirstNameStreamController.addError("");
      _invalidEmailStreamController.addError("");
      _invalidPasswordStreamController.addError(e.cause);
    } on InvalidConfirmPasswordException catch (e) {
      _signUpStreamController.add(Error(e));
      _invalidFirstNameStreamController.addError("");
      _invalidEmailStreamController.addError("");
      _invalidPasswordStreamController.addError("");
      _invalidConfirmPasswordStreamController.addError(e.cause);
    } on InvalidMobileNumberException catch (e) {
      _signUpStreamController.add(Error(e));
      _invalidFirstNameStreamController.addError("");
      _invalidEmailStreamController.addError("");
      _invalidPasswordStreamController.addError("");
      _invalidConfirmPasswordStreamController.addError("");
      _invalidMobileNumberStreamController.addError(e.cause);
    }
  }
}
