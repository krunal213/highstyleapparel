import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:highstyleapparel/exceptions.dart';
import 'package:highstyleapparel/generated/l10n.dart';
import 'package:highstyleapparel/high_style_app_bar.dart';
import 'package:highstyleapparel/high_style_extension.dart';
import 'package:highstyleapparel/login/bloc/verification_code_bloc.dart';
import 'package:highstyleapparel/login/high_style_count_down_timer.dart';
import 'package:highstyleapparel/navigations.dart';
import 'package:highstyleapparel/result.dart';
import 'package:pinput/pinput.dart';

class VerificationCode extends StatefulWidget {
  const VerificationCode(
      {super.key, required this.sessionId, required this.emailId});

  final String sessionId;
  final String emailId;

  @override
  State<VerificationCode> createState() => _VerificationCodeState();
}

class _VerificationCodeState extends State<VerificationCode> {
  HighStyleProgressDialog? _highStyleProgressDialog;
  late VerificationCodeBloc _verificationCodeBloc;
  final defaultPinTheme = PinTheme(
    width: 38,
    height: 38,
    decoration: BoxDecoration(
      border: Border.all(color: const Color(0xFFA5A7AC)),
      borderRadius: BorderRadius.circular(20),
    ),
  );

  @override
  void initState() {
    _verificationCodeBloc = GetIt.I<VerificationCodeBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const HighStyleAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 32, left: 33, right: 33),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(S.of(context).title_verification_code_tite,
                    key: const Key("text_screen_title"),
                    style: const TextStyle(
                      fontSize: 24.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                    ),
                    textAlign: TextAlign.left),
                const SizedBox(height: 16),
                Text(S.of(context).title_verification_code_sub_title,
                    style: const TextStyle(
                      fontSize: 14.0,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.left),
                const SizedBox(height: 48),
                Center(
                  child: Pinput(
                      key: const Key("pin_input_otp"),
                      length: 6,
                      defaultPinTheme: defaultPinTheme,
                      onCompleted: (pin) => _verificationCodeBloc.verifyOtp(
                          pin, widget.sessionId)),
                ),
                const SizedBox(height: 72),
                StreamBuilder<Result<String>>(
                    stream: _verificationCodeBloc.forgotPasswordStream,
                    builder: (context, snapShot) {
                      Result<String>? result = snapShot.data;
                      if (result is Loading) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _highStyleProgressDialog =
                              HighStyleProgressDialog(context);
                          _highStyleProgressDialog
                              ?.showHighStyleProgressDialog();
                        });
                      } else if (result is Success<String>) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _highStyleProgressDialog
                              ?.hideHighStyleProgressDialog();
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(result.value)));
                        });
                      } else if (result is Error) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _highStyleProgressDialog
                              ?.hideHighStyleProgressDialog();
                          if (result.exception is NoInternetException ||
                              result.exception is ClientErrorException ||
                              result.exception is SomethingWentWrongException) {
                            showHighStyleErrorDialog(result, () {
                              hideHighStyleErrorDialog();
                            });
                          }
                        });
                      }

                      return HighStyleCountDownTimer(
                          shouldRestartCountDown:
                              result is Success ? true : false,
                          onTap: () => _verificationCodeBloc
                              .forgotPassword(widget.emailId));
                    }),
                StreamBuilder<Result<String>>(
                    stream: _verificationCodeBloc.verifyOtpStream,
                    builder: (context, snapShot) {
                      Result<String>? result = snapShot.data;
                      if (result is Loading) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _highStyleProgressDialog =
                              HighStyleProgressDialog(context);
                          _highStyleProgressDialog
                              ?.showHighStyleProgressDialog();
                        });
                      } else if (result is Success<String>) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _highStyleProgressDialog
                              ?.hideHighStyleProgressDialog();
                          CreateNewPasswordRoute(sessionId: result.value)
                              .go(context);
                        });
                      } else if (result is Error) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _highStyleProgressDialog
                              ?.hideHighStyleProgressDialog();
                          if (result.exception is NoInternetException ||
                              result.exception is ClientErrorException ||
                              result.exception is SomethingWentWrongException) {
                            showHighStyleErrorDialog(result, () {
                              hideHighStyleErrorDialog();
                            });
                          }
                        });
                      }

                      return const SizedBox.shrink();
                    })
              ],
            ),
          ),
        ));
  }
}
