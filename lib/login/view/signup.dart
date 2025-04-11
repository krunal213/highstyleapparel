import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:highstyleapparel/exceptions.dart';
import 'package:highstyleapparel/high_style_extension.dart';
import 'package:highstyleapparel/login/bloc/signup_bloc.dart';
import 'package:highstyleapparel/navigations.dart';
import 'package:highstyleapparel/result.dart';
import 'package:highstyleapparel/generated/l10n.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late final SignUpBloc _signUpFlowBloc;
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailAddressController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  late final TextEditingController _mobileNumberController;
  HighStyleProgressDialog? _highStyleProgressDialog;

  @override
  void initState() {
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailAddressController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _mobileNumberController = TextEditingController();
    _signUpFlowBloc = GetIt.I<SignUpBloc>();
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
                      Text(S.of(context).title_create_new_account,
                          key: const Key("text_screen_title"),
                          style: const TextStyle(
                            fontSize: 24.0,
                            color: Colors.black,
                            height: 2.4,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left),
                      const SizedBox(height: 8),
                      StreamBuilder(
                          stream: _signUpFlowBloc.invalidFirstNameStream,
                          builder: (context, snapShot) {
                            return TextField(
                              key: const Key("text_field_first_name"),
                              controller: _firstNameController,
                              decoration: InputDecoration(
                                  hintText: S.of(context).title_first_name_hint,
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFFD6D6D6)),
                                  ),
                                  errorText: snapShot.hasError &&
                                      snapShot.error.toString().isNotEmpty
                                      ? snapShot.error.toString()
                                      : null),
                            );
                          }),
                      const SizedBox(height: 28),
                      TextField(
                        key: const Key("text_field_last_name"),
                        controller: _lastNameController,
                        decoration: InputDecoration(
                          hintText: S.of(context).title_last_name_hint,
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFD6D6D6)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),
                      StreamBuilder(
                          stream: _signUpFlowBloc.invalidEmailStream,
                          builder: (context, snapShot) {
                            return TextField(
                              key: const Key("text_field_email_address"),
                              controller: _emailAddressController,
                              decoration: InputDecoration(
                                  hintText:
                                      S.of(context).title_email_address_hint,
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFFD6D6D6)),
                                  ),
                                  errorText: snapShot.hasError &&
                                      snapShot.error.toString().isNotEmpty
                                      ? snapShot.error.toString()
                                      : null),
                            );
                          }),
                      const SizedBox(height: 28),
                      StreamBuilder(
                          stream: _signUpFlowBloc.invalidPasswordStream,
                          builder: (context, snapShot) {
                            return TextField(
                              key: const Key("text_field_password"),
                              controller: _passwordController,
                              decoration: InputDecoration(
                                  hintText: S
                                      .of(context)
                                      .title_password_hint_required,
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFFD6D6D6)),
                                  ),
                                  errorText: snapShot.hasError &&
                                      snapShot.error.toString().isNotEmpty
                                      ? snapShot.error.toString()
                                      : null),
                            );
                          }),
                      const SizedBox(height: 28),
                      StreamBuilder(
                          stream: _signUpFlowBloc.invalidConfirmPasswordStream,
                          builder: (context, snapShot) {
                            return TextField(
                              key: const Key("text_field_confirm_password"),
                              controller: _confirmPasswordController,
                              decoration: InputDecoration(
                                  hintText: S
                                      .of(context)
                                      .title_confirm_password_hint_required,
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFFD6D6D6)),
                                  ),
                                  errorText: snapShot.hasError &&
                                      snapShot.error.toString().isNotEmpty
                                      ? snapShot.error.toString()
                                      : null),
                            );
                          }),
                      const SizedBox(height: 28),
                      StreamBuilder(
                          stream: _signUpFlowBloc.invalidMobileNumberStream,
                          builder: (context, snapShot) {
                            return TextField(
                              key: const Key("text_field_mobile_number"),
                              controller: _mobileNumberController,
                              decoration: InputDecoration(
                                  hintText:
                                      S.of(context).title_mobile_number_hint,
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFFD6D6D6)),
                                  ),
                                  errorText: snapShot.hasError &&
                                      snapShot.error.toString().isNotEmpty
                                      ? snapShot.error.toString()
                                      : null),
                            );
                          }),
                      const SizedBox(height: 48),
                      Center(
                        child: OutlinedButton(
                          key: const Key("outlined_button_sign_up"),
                          style: OutlinedButton.styleFrom(
                              backgroundColor: const Color(0xFFAB8B57),
                              minimumSize: const Size(164, 48),
                              side: const BorderSide(
                                color: Colors.transparent, // Border color
                              )),
                          onPressed: () => _signUpFlowBloc.signup(
                              _firstNameController.text,
                              _lastNameController.text,
                              _emailAddressController.text,
                              _passwordController.text,
                              _confirmPasswordController.text,
                              _mobileNumberController.text),
                          child: Text(S.of(context).title_signup_uppercase,
                              style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                      ),
                      const SizedBox(height: 48),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            S.of(context).title_already_have_account,
                            style: const TextStyle(
                                fontSize: 14.0, color: Colors.black),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                              key: const Key('gesture_detector_login'),
                              onTap: () => LoginRoute().go(context),
                              child: Text(
                                S.of(context).title_login,
                                style: const TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                    decoration: TextDecoration.underline),
                              ))
                        ],
                      ),
                      StreamBuilder<Result<String>>(
                          stream: _signUpFlowBloc.signUpStream,
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
                          }),
                    ],
                  )))),
    );
  }
}
