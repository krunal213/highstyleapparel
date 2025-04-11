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
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'login_flow_rest_client.g.dart';

//https://pub.dev/packages/retrofit
@RestApi(baseUrl: "https://high-style-apparel-application.onrender.com/")
abstract class LoginFlowRestClient {
  factory LoginFlowRestClient(Dio dio, {String baseUrl}) = _LoginFlowRestClient;

  @POST('/api/auth/register')
  Future<RegisterResponse> register(@Body() RegisterRequest registerRequest);

  @POST('/api/auth/login')
  Future<LoginResponse> login(@Body() LoginRequest loginRequest);

  //1
  @POST('/api/auth/send-reset-otp')
  Future<SendOtpResponse> sendOtpRequest(@Body() SendOtpRequest sendOtpRequest);

  //2
  @POST('/api/auth/reset-password')
  Future<ResetPasswordResponse> resetPasswordRequest(@Body() ResetPasswordRequest resetPasswordRequest);

  //3
  @POST('/api/auth/verify-reset-otp')
  Future<VerifyOtpResponse> verifyCode(@Body() VerifyOtpRequest verifyOtpRequest);

}
