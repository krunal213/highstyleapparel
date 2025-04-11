import 'package:highstyleapparel/exceptions.dart';
import 'package:highstyleapparel/login/contract.dart';
import 'package:highstyleapparel/login/entity/send_otp_request.dart';
import 'package:highstyleapparel/login/entity/send_otp_response.dart';
import 'package:highstyleapparel/result.dart';
import 'package:rxdart/rxdart.dart';

class ForgotPasswordBloc {
  late final LoginFlowRepository _loginRepository;

  final _emailRegex =
      RegExp(r'^(?!.*\.\.)[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

  final _forgotPasswordStreamController =
      BehaviorSubject<Result<Map<String, dynamic>>>();

  Stream<Result<Map<String, dynamic>>> get forgotPasswordStream =>
      _forgotPasswordStreamController.stream;

  final _invalidEmailStreamController = BehaviorSubject<String>();

  Stream<String> get invalidEmailStream => _invalidEmailStreamController.stream;

  ForgotPasswordBloc(this._loginRepository);

  forgotPassword(String emailAddress) async {
    _forgotPasswordStreamController.add(Loading());
    try {
      if (emailAddress.isEmpty) {
        throw InvalidEmailAddressException();
      }
      if (!_emailRegex.hasMatch(emailAddress)) {
        throw InvalidEmailAddressException();
      }
      Result<SendOtpResponse> result =
          await _loginRepository.forgotPassword(SendOtpRequest(emailAddress));
      if (result is Success<SendOtpResponse>) {
        _forgotPasswordStreamController.add(Success<Map<String, dynamic>>({
          'emailAddress': emailAddress,
          'sessionId': result.value.sessionId,
        }));
      } else {
        _forgotPasswordStreamController.add(result as Error);
      }
    } on InvalidEmailAddressException catch (e) {
      _forgotPasswordStreamController.add(Error(e));
      _invalidEmailStreamController.addError(e.cause);
    }
  }
}
