import 'package:highstyleapparel/exceptions.dart';
import 'package:highstyleapparel/login/contract.dart';
import 'package:highstyleapparel/login/entity/login_request.dart';
import 'package:highstyleapparel/login/entity/login_response.dart';
import 'package:highstyleapparel/login/entity/register_request.dart';
import 'package:highstyleapparel/login/entity/register_response.dart';
import 'package:highstyleapparel/login/entity/reset_password_request.dart';
import 'package:highstyleapparel/login/entity/reset_password_response.dart';
import 'package:highstyleapparel/login/entity/send_otp_request.dart';
import 'package:highstyleapparel/login/entity/send_otp_response.dart';
import 'package:highstyleapparel/login/entity/verify_otp_request.dart';
import 'package:highstyleapparel/login/entity/verify_otp_response.dart';
import 'package:highstyleapparel/result.dart';

class LoginRepositoryImpl implements LoginFlowRepository {
  late final LoginFlowDiscDataSource _loginDiscDataSource;
  late final LoginFlowNetworkDataSource _loginNetworkDataSource;

  LoginRepositoryImpl(this._loginDiscDataSource, this._loginNetworkDataSource);

  @override
  Future<Result<String>> login(LoginRequest loginRequest) async {
    try {
      LoginResponse loginResponse =
          await _loginNetworkDataSource.login(loginRequest);

      await _loginDiscDataSource.saveCustomerId(loginResponse.userId);

      return Success(await _loginDiscDataSource.getCustomerId() as String);
    } on HighStyleApparelException catch (e) {
      return Error(e);
    }
  }

  @override
  Future<Result<String>> signup(RegisterRequest registerRequest) async {
    try {
      RegisterResponse registerResponse =
          await _loginNetworkDataSource.register(registerRequest);

      await _loginDiscDataSource.saveCustomerId(registerResponse.userId);

      return Success(await _loginDiscDataSource.getCustomerId() as String);
    } on HighStyleApparelException catch (e) {
      return Error(e);
    }
  }

  @override
  Future<Result<SendOtpResponse>> forgotPassword(
      SendOtpRequest sendOtpRequest) async {
    try {
      return Success(
          await _loginNetworkDataSource.sendOtpRequest(sendOtpRequest));
    } on HighStyleApparelException catch (e) {
      return Error(e);
    }
  }


  @override
  Future<Result<String>> isUserLogin() async {
    String? customerId = await _loginDiscDataSource.getCustomerId();
    if (customerId != null && customerId.isNotEmpty) {
      return Success(customerId);
    } else {
      return Error(HighStyleApparelException());
    }
  }

  @override
  Future<Result<ResetPasswordResponse>> resetPassword(
      ResetPasswordRequest resetPasswordRequest) async {
    try {
      return Success(
          await _loginNetworkDataSource.resetPassword(resetPasswordRequest));
    } on HighStyleApparelException catch (e) {
      return Error(e);
    }
  }

  @override
  Future<Result<VerifyOtpResponse>> verifyCode(VerifyOtpRequest verifyOtpRequest) async {
    try {
      return Success(
          await _loginNetworkDataSource.verifyCode(verifyOtpRequest));
    } on HighStyleApparelException catch (e) {
      return Error(e);
    }
  }
}
