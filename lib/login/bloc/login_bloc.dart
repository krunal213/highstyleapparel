import 'package:highstyleapparel/exceptions.dart';
import 'package:highstyleapparel/login/contract.dart';
import 'package:highstyleapparel/login/entity/login_request.dart';
import 'package:highstyleapparel/result.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc {
  late final LoginFlowRepository _loginRepository;

  final _emailRegex =
      RegExp(r'^(?!.*\.\.)[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

  final _loginStreamController = BehaviorSubject<Result<String>>();

  Stream<Result<String>> get loginStream => _loginStreamController.stream;

  final _invalidEmailStreamController = BehaviorSubject<String>();

  Stream<String> get invalidEmailStream => _invalidEmailStreamController.stream;

  final _invalidPasswordStreamController = BehaviorSubject<String>();

  Stream<String> get invalidPasswordStream =>
      _invalidPasswordStreamController.stream;

  LoginBloc(this._loginRepository);

  login(String emailAddress, String password) async {
    _loginStreamController.add(Loading());
    try {
      if (emailAddress.isEmpty) {
        throw InvalidEmailAddressException();
      }
      if (!_emailRegex.hasMatch(emailAddress)) {
        throw InvalidEmailAddressException();
      }
      if (password.isEmpty) {
        throw InvalidPasswordException();
      }
      _loginStreamController.add(
          await _loginRepository.login(LoginRequest(emailAddress, password)));
    } on InvalidEmailAddressException catch (e) {
      _loginStreamController.add(Error(e));
      _invalidEmailStreamController.addError(e.cause);
    } on InvalidPasswordException catch (e) {
      _loginStreamController.add(Error(e));
      _invalidEmailStreamController.addError("");
      _invalidPasswordStreamController.addError(e.cause);
    }
  }
}
