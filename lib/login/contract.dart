import 'package:highstyleapparel/login/entity/register_request.dart';
import 'package:highstyleapparel/login/entity/register_response.dart';
import 'package:highstyleapparel/login/entity/reset_password_request.dart';
import 'package:highstyleapparel/login/entity/reset_password_response.dart';
import 'package:highstyleapparel/login/entity/send_otp_response.dart';
import 'package:highstyleapparel/login/entity/verify_otp_request.dart';
import 'package:highstyleapparel/login/entity/verify_otp_response.dart';
import 'package:highstyleapparel/result.dart';

import 'entity/login_request.dart';
import 'entity/login_response.dart';
import 'entity/send_otp_request.dart';

abstract class LoginFlowDiscDataSource {
  Future<bool> saveCustomerId(String userId);

  Future<String?> getCustomerId();
}

abstract class LoginFlowNetworkDataSource {
  Future<RegisterResponse> register(RegisterRequest registerRequest);

  Future<LoginResponse> login(LoginRequest loginRequest);

  Future<SendOtpResponse> sendOtpRequest(SendOtpRequest sendOtpRequest);

  Future<ResetPasswordResponse> resetPassword(ResetPasswordRequest resetPasswordRequest);

  Future<VerifyOtpResponse> verifyCode(VerifyOtpRequest verifyOtpRequest);
}

abstract class LoginFlowRepository {
  Future<Result<String>> login(LoginRequest loginRequest);

  Future<Result<String>> signup(RegisterRequest registerRequest);

  Future<Result<SendOtpResponse>> forgotPassword(SendOtpRequest sendOtpRequest);

  Future<Result<ResetPasswordResponse>> resetPassword(ResetPasswordRequest resetPasswordRequest);

  Future<Result<VerifyOtpResponse>> verifyCode(VerifyOtpRequest verifyOtpRequest);

  Future<Result<String>> isUserLogin();

}
