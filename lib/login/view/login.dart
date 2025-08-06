import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:highstyleapparel/exceptions.dart';
import 'package:highstyleapparel/high_style_extension.dart';
import 'package:highstyleapparel/login/bloc/login_bloc.dart';
import 'package:highstyleapparel/navigations.dart';
import 'package:highstyleapparel/result.dart';
import 'package:highstyleapparel/generated/l10n.dart';

import '../../high_style_obscure_text_field.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late LoginBloc _loginFlowBloc;
  late final TextEditingController _emailAddressController;
  late final TextEditingController _passwordController;
  HighStyleProgressDialog? _highStyleProgressDialog;

  @override
  void initState() {
    _emailAddressController = TextEditingController();
    _passwordController = TextEditingController();
    _loginFlowBloc = GetIt.I<LoginBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.only(top: 63, left: 33, right: 33),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(S.of(context).title_login_screen_title,
                          key: const Key("text_screen_title"),
                          style: const TextStyle(
                            fontSize: 24.0,
                            color: Colors.black,
                            height: 2.2,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left),
                      const SizedBox(height: 48),
                      StreamBuilder<String>(
                          stream: _loginFlowBloc.invalidEmailStream,
                          builder: (context, snapShot) {
                            return TextField(
                              key: const Key("text_field_email_address"),
                              controller: _emailAddressController,
                              decoration: InputDecoration(
                                  hintText: S
                                      .of(context)
                                      .title_login_screen_email_address_hint,
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFFD6D6D6)),
                                  ),
                                  errorText: snapShot.errorText()),
                            );
                          }),
                      const SizedBox(height: 28),
                      StreamBuilder<String>(
                          stream: _loginFlowBloc.invalidPasswordStream,
                          builder: (context, snapShot) {
                            return HighStyleObscureTextField(
                                key: const Key("text_field_password"),
                                controller: _passwordController,
                                hintText: S.of(context).title_password_hint,
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFFD6D6D6)),
                                ),
                                errorText: snapShot.errorText());
                          }),
                      const SizedBox(height: 40),
                      Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                              key:
                                  const Key("gesture_detector_forgot_password"),
                              onTap: () => ForgotPasswordRoute().push(context),
                              child: Text(
                                key: const Key("text_forgot_password"),
                                S.of(context).title_forgot_password,
                                style: const TextStyle(
                                    fontSize: 12.0, color: Colors.black),
                              ))),
                      const SizedBox(height: 24),
                      Center(
                        child: OutlinedButton(
                          key: const Key("outlined_button_login"),
                          style: OutlinedButton.styleFrom(
                              backgroundColor: const Color(0xFFAB8B57),
                              minimumSize: const Size(164, 48),
                              side: const BorderSide(
                                color: Colors.transparent, // Border color
                              )),
                          onPressed: () => _loginFlowBloc.login(
                              _emailAddressController.text,
                              _passwordController.text),
                          child: Text(
                              key: const Key("text_login"),
                              S.of(context).title_login_uppercase,
                              style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            key: const Key("text_don't_have_an_account"),
                            S.of(context).title_dont_have_account,
                            style: const TextStyle(
                                fontSize: 14.0, color: Colors.black),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                              key: const Key("gesture_detector_sign_up"),
                              onTap: () => SignUpRoute().push(context),
                              child: Text(
                                key: const Key("text_sign_up"),
                                S.of(context).title_signup_title_case,
                                style: const TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                    decoration: TextDecoration.underline),
                              ))
                        ],
                      ),
                      StreamBuilder<Result<String>>(
                          stream: _loginFlowBloc.loginStream,
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
                                HomeRoute(customerId: result.value).go(context);
                              });
                            } else if (result is Error) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                _highStyleProgressDialog
                                    ?.hideHighStyleProgressDialog();
                                if (result.exception is NoInternetException ||
                                    result.exception is ClientErrorException ||
                                    result.exception
                                        is SomethingWentWrongException) {
                                  showHighStyleErrorDialog(result, () {
                                    hideHighStyleErrorDialog();
                                  });
                                }
                              });
                            }

                            return const SizedBox.shrink();
                          })
                    ],
                  )))),
    );
  }
}
