import 'package:highstyleapparel/login/contract.dart';

class LoginRepositoryImpl implements LoginFlowRepository {
  late final LoginFlowDiscDataSource _loginDiscDataSource;
  late final LoginFlowNetworkDataSource _loginNetworkDataSource;

  LoginRepositoryImpl(this._loginDiscDataSource, this._loginNetworkDataSource);

  @override
  login(String emailAddress, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  signup(String firstName, String? lastName, String emailAddress,
      String password, String confirmPassword, String mobileNumber) {
    // TODO: implement signup
    throw UnimplementedError();
  }

  @override
  forgotPassword(String emailAddress) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  @override
  createNewPassword(String password, String confirmPassword) {
    // TODO: implement createNewPassword
    throw UnimplementedError();
  }

  @override
  verifyCode(String verifyCode) {
    // TODO: implement verifyCode
    throw UnimplementedError();
  }
}
