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
import 'package:highstyleapparel/login/repository/datasource/network/login_flow_rest_client.dart';
import 'package:dio/dio.dart';

class LoginFlowNetworkDataSourceImpl implements LoginFlowNetworkDataSource {
  late final LoginFlowRestClient _loginFlowRestClient;

  LoginFlowNetworkDataSourceImpl(this._loginFlowRestClient);

  @override
  Future<RegisterResponse> register(RegisterRequest registerRequest) async {
    try {
      return await _loginFlowRestClient.register(registerRequest);
    } on DioException catch (err) {
      if (err.type == DioExceptionType.connectionError) {
        throw NoInternetException();
      } else if (err.response != null && err.response?.statusCode == 400) {
        throw ClientErrorException(err.response?.data["message"]);
      } else {
        throw SomethingWentWrongException();
      }
    }
  }

  @override
  Future<LoginResponse> login(LoginRequest loginRequest) async {
    try {
      return await _loginFlowRestClient.login(loginRequest);
    } on DioException catch (err) {
      if (err.type == DioExceptionType.connectionError) {
        throw NoInternetException();
      } else if (err.response != null &&
          (err.response!.statusCode == 400 ||
              err.response!.statusCode == 404)) {
        throw ClientErrorException(err.response?.data["message"]);
      } else {
        throw SomethingWentWrongException();
      }
    }
  }

  @override
  Future<SendOtpResponse> sendOtpRequest(SendOtpRequest sendOtpRequest) async {
    try {
      return await _loginFlowRestClient.sendOtpRequest(sendOtpRequest);
    } on DioException catch (err) {
      if (err.type == DioExceptionType.connectionError) {
        throw NoInternetException();
      } else if (err.response != null && err.response!.statusCode == 404) {
        throw ClientErrorException(err.response?.data["message"]);
      } else {
        throw SomethingWentWrongException();
      }
    }
  }

  @override
  Future<ResetPasswordResponse> resetPassword(
      ResetPasswordRequest resetPasswordRequest) async {
    try {
      return await _loginFlowRestClient
          .resetPasswordRequest(resetPasswordRequest);
    } on DioException catch (err) {
      if (err.type == DioExceptionType.connectionError) {
        throw NoInternetException();
      } else {
        throw SomethingWentWrongException();
      }
    }
  }

  @override
  Future<VerifyOtpResponse> verifyCode(
      VerifyOtpRequest verifyOtpRequest) async {
    try {
      return await _loginFlowRestClient.verifyCode(verifyOtpRequest);
    } on DioException catch (err) {
      if (err.type == DioExceptionType.connectionError) {
        throw NoInternetException();
      } else if (err.response != null && err.response!.statusCode == 400) {
        throw ClientErrorException(err.response?.data["message"]);
      } else {
        throw SomethingWentWrongException();
      }
    }
  }
}
