import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:highstyleapparel/exceptions.dart';
import 'package:highstyleapparel/high_style_app_bar.dart';
import 'package:highstyleapparel/high_style_extension.dart';
import 'package:highstyleapparel/login/bloc/forgot_password_bloc.dart';
import 'package:highstyleapparel/navigations.dart';
import 'package:highstyleapparel/result.dart';
import 'package:highstyleapparel/generated/l10n.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  late final ForgotPasswordBloc _forgotPasswordBloc;
  HighStyleProgressDialog? _highStyleProgressDialog;

  @override
  void initState() {
    _forgotPasswordBloc = GetIt.I<ForgotPasswordBloc>();
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
                Text(S.of(context).title_forgot_password,
                    key: const Key("text_screen_title"),
                    style: const TextStyle(
                      fontSize: 24.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left),
                const SizedBox(height: 24),
                Text(S.of(context).title_forgot_password_screen_sub_title,
                    style: const TextStyle(
                      fontSize: 15.59,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.left),
                const SizedBox(height: 48),
                StreamBuilder<String>(
                    stream: _forgotPasswordBloc.invalidEmailStream,
                    builder: (context, snapShot) {
                      return TextField(
                          key: const Key("text_field_email_address"),
                          decoration: InputDecoration(
                            icon: const Icon(Icons.email_outlined),
                            hintText: S
                                .of(context)
                                .title_forgot_password_screen_email_address_hint,
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFD6D6D6)),
                            ),
                            errorText: snapShot.hasError &&
                                    snapShot.error.toString().isNotEmpty
                                ? snapShot.error.toString()
                                : null,
                          ),
                          onSubmitted: (emailAddress) =>
                              _forgotPasswordBloc.forgotPassword(emailAddress));
                    }),
                StreamBuilder<Result<Map<String, dynamic>>>(
                    stream: _forgotPasswordBloc.forgotPasswordStream,
                    builder: (context, snapShot) {
                      Result<Map<String, dynamic>>? result = snapShot.data;
                      if (result is Loading) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _highStyleProgressDialog =
                              HighStyleProgressDialog(context);
                          _highStyleProgressDialog
                              ?.showHighStyleProgressDialog();
                        });
                      } else if (result is Success<Map<String, dynamic>>) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _highStyleProgressDialog
                              ?.hideHighStyleProgressDialog();
                          VerificationCodeRoute(
                                  sessionId: result.value['sessionId'],
                                  emailId: result.value['emailAddress'])
                              .push(context);
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
