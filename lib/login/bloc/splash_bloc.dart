import 'package:highstyleapparel/login/contract.dart';
import 'package:highstyleapparel/result.dart';
import 'package:rxdart/rxdart.dart';

class SplashBloc {
  late final LoginFlowRepository _loginRepository;

  final _isUserLoginStreamController = BehaviorSubject<Result<String>>();

  Stream<Result<String>> get isUserLoginStream =>
      _isUserLoginStreamController.stream;

  SplashBloc(this._loginRepository);

  isUserLogin() async {
    _isUserLoginStreamController.add(Loading());
    await Future.delayed(const Duration(seconds: 1));
    _isUserLoginStreamController.add(await _loginRepository.isUserLogin());
  }
}
