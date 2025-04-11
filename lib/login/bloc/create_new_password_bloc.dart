import 'package:highstyleapparel/exceptions.dart';
import 'package:highstyleapparel/login/contract.dart';
import 'package:highstyleapparel/login/entity/reset_password_request.dart';
import 'package:highstyleapparel/login/entity/reset_password_response.dart';
import 'package:highstyleapparel/result.dart';
import 'package:rxdart/rxdart.dart';

class CreateNewPasswordBloc {
  late final LoginFlowRepository _loginRepository;

  final _resetPasswordStreamController = BehaviorSubject<Result<String>>();

  Stream<Result<String>> get resetPasswordStream =>
      _resetPasswordStreamController.stream;

  final _invalidPasswordStreamController = BehaviorSubject<String>();

  Stream<String> get invalidPasswordStream =>
      _invalidPasswordStreamController.stream;

  final _invalidConfirmPasswordStreamController = BehaviorSubject<String>();

  Stream<String> get invalidConfirmPasswordStream =>
      _invalidConfirmPasswordStreamController.stream;

  CreateNewPasswordBloc(this._loginRepository);

  resetPassword(
      String password, String confirmPassword, String sessionId) async {
    _resetPasswordStreamController.add(Loading());
    try {
      if (password.isEmpty) {
        throw InvalidPasswordException();
      }
      if (confirmPassword.isEmpty) {
        throw InvalidConfirmPasswordException();
      }
      if (confirmPassword != password) {
        throw PasswordMisMatchException();
      }
      final Result<ResetPasswordResponse> result = await _loginRepository
          .resetPassword(ResetPasswordRequest(sessionId, password));
      if (result is Success<ResetPasswordResponse>) {
        _resetPasswordStreamController.add(Success(result.value.message));
      } else {
        _resetPasswordStreamController.add(result as Error);
      }
    } on InvalidPasswordException catch (e) {
      _resetPasswordStreamController.add(Error(e));
      _invalidPasswordStreamController.addError(e.cause);
    } on InvalidConfirmPasswordException catch (e) {
      _resetPasswordStreamController.add(Error(e));
      _invalidPasswordStreamController.addError("");
      _invalidConfirmPasswordStreamController.addError(e.cause);
    }
  }
}
