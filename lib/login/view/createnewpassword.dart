import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:highstyleapparel/exceptions.dart';
import 'package:highstyleapparel/generated/l10n.dart';
import 'package:highstyleapparel/high_style_app_bar.dart';
import 'package:highstyleapparel/high_style_extension.dart';
import 'package:highstyleapparel/high_style_obscure_text_field.dart';
import 'package:highstyleapparel/login/bloc/create_new_password_bloc.dart';
import 'package:highstyleapparel/navigations.dart';
import 'package:highstyleapparel/result.dart';

class CreateNewPassword extends StatefulWidget {
  final String sessionId;

  const CreateNewPassword({required this.sessionId, super.key});

  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  late final CreateNewPasswordBloc _createNewPasswordBloc;
  late final TextEditingController _newPasswordController;
  late final TextEditingController _confirmPasswordController;
  HighStyleProgressDialog? _highStyleProgressDialog;

  @override
  void initState() {
    _createNewPasswordBloc = GetIt.I<CreateNewPasswordBloc>();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
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
                Text(S.of(context).title_create_newpassword_screen_title,
                    key: const Key("text_screen_title"),
                    style: const TextStyle(
                      fontSize: 24.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left),
                const SizedBox(height: 24),
                const Text(
                    "Your new password must be different from previously used password",
                    style: TextStyle(
                      fontSize: 15.59,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.left),
                const SizedBox(height: 48),
                StreamBuilder<String>(
                    stream: _createNewPasswordBloc.invalidPasswordStream,
                    builder: (context, snapShot) {
                      return HighStyleObscureTextField(
                          key: const Key("text_field_new_password"),
                          controller: _newPasswordController,
                          hintText: S.of(context).title_new_password_hint,
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFD6D6D6)),
                          ),
                          errorText: snapShot.hasError &&
                                  snapShot.error.toString().isNotEmpty
                              ? snapShot.error.toString()
                              : null);
                    }),
                const SizedBox(height: 28),
                StreamBuilder<String>(
                    stream: _createNewPasswordBloc.invalidConfirmPasswordStream,
                    builder: (context, snapShot) {
                      return HighStyleObscureTextField(
                          key: const Key("text_field_confirm_password"),
                          controller: _confirmPasswordController,
                          hintText: S.of(context).title_confirm_password_hint,
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFD6D6D6)),
                          ),
                          errorText: snapShot.hasError &&
                                  snapShot.error.toString().isNotEmpty
                              ? snapShot.error.toString()
                              : null);
                    }),
                const SizedBox(height: 64),
                Center(
                  child: OutlinedButton(
                    key: const Key("outlined_button_confirm"),
                    style: OutlinedButton.styleFrom(
                        backgroundColor: const Color(0xFFAB8B57),
                        minimumSize: const Size(164, 48),
                        side: const BorderSide(
                          color: Colors.transparent, // Border color
                        )),
                    onPressed: () => _createNewPasswordBloc.resetPassword(
                        _newPasswordController.text,
                        _confirmPasswordController.text,
                        widget.sessionId),
                    child: Text(S.of(context).title_confirm,
                        style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                ),
                StreamBuilder<Result<String>>(
                    stream: _createNewPasswordBloc.resetPasswordStream,
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
                          showHighStyleSuccessDialog(result, () {
                            hideHighStyleSuccessDialog();
                            LoginRoute().go(context);
                          });
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
