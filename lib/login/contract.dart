abstract class LoginFlowDiscDataSource {}

abstract class LoginFlowNetworkDataSource {}

abstract class LoginFlowRepository {
  login(String emailAddress, String password);

  signup(String firstName, String? lastName, String emailAddress,
      String password, String confirmPassword, String mobileNumber);

  forgotPassword(String emailAddress);

  createNewPassword(String password, String confirmPassword);

  verifyCode(String verifyCode);
}
