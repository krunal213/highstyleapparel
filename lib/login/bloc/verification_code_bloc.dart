import 'package:highstyleapparel/login/contract.dart';
import 'package:highstyleapparel/login/entity/send_otp_request.dart';
import 'package:highstyleapparel/login/entity/send_otp_response.dart';
import 'package:highstyleapparel/login/entity/verify_otp_request.dart';
import 'package:highstyleapparel/login/entity/verify_otp_response.dart';
import 'package:highstyleapparel/result.dart';
import 'package:rxdart/rxdart.dart';

class VerificationCodeBloc {
  late final LoginFlowRepository _loginRepository;

  final _verifyOtpStreamController = BehaviorSubject<Result<String>>();

  Stream<Result<String>> get verifyOtpStream =>
      _verifyOtpStreamController.stream;

  final _forgotPasswordStreamController = BehaviorSubject<Result<String>>();

  Stream<Result<String>> get forgotPasswordStream =>
      _forgotPasswordStreamController.stream;

  VerificationCodeBloc(this._loginRepository);

  verifyOtp(String verifyCode, String sessionId) async {
    _verifyOtpStreamController.add(Loading());
    final Result<VerifyOtpResponse> result = await _loginRepository
        .verifyCode(VerifyOtpRequest(sessionId, verifyCode));
    if (result is Success<VerifyOtpResponse>) {
      _verifyOtpStreamController.add(Success(sessionId));
    } else {
      _verifyOtpStreamController.add(result as Error);
    }
  }

  forgotPassword(String emailAddress) async {
    _forgotPasswordStreamController.add(Loading());
    Result<SendOtpResponse> result =
        await _loginRepository.forgotPassword(SendOtpRequest(emailAddress));
    if (result is Success<SendOtpResponse>) {
      _forgotPasswordStreamController.add(Success(result.value.message));
    } else {
      _forgotPasswordStreamController.add(result as Error);
    }
  }
}
