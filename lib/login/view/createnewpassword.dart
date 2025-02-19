import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:highstyleapparel/highstyleappbar.dart';

class CreateNewPassword extends StatefulWidget {
  const CreateNewPassword({super.key});

  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  bool _obscureNewPasswordText = true;
  bool _obscureConfirmPasswordText = true;
  final Map<bool, IconData> _iconsVisibility = HashMap();

  @override
  void initState() {
    _iconsVisibility[true] = Icons.visibility_off;
    _iconsVisibility[false] = Icons.visibility;
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
                const Text("Create new password",
                    key: Key("text_screen_title"),
                    style: TextStyle(
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
                TextField(
                  key: const Key("text_field_new_password"),
                  obscureText: _obscureNewPasswordText,
                  decoration: InputDecoration(
                      hintText: 'New Password',
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFD6D6D6)),
                      ),
                      suffixIcon: IconButton(
                        key: const Key("icon_button_new_password"),
                        icon: Icon(
                          _iconsVisibility[_obscureNewPasswordText]
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureNewPasswordText = !_obscureNewPasswordText;
                          });
                        },
                      )),
                ),
                const SizedBox(height: 28),
                TextField(
                  key: const Key("text_field_confirm_password"),
                  obscureText: _obscureConfirmPasswordText,
                  decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFD6D6D6)),
                      ),
                      suffixIcon: IconButton(
                        key: const Key("icon_button_confirm_password"),
                        icon: Icon(
                            _iconsVisibility[_obscureConfirmPasswordText]
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureConfirmPasswordText =
                                !_obscureConfirmPasswordText;
                          });
                        },
                      )),
                ),
                const SizedBox(height: 64),
                Center(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        backgroundColor: const Color(0xFFAB8B57),
                        minimumSize: const Size(164, 48),
                        side: const BorderSide(
                          color: Colors.transparent, // Border color
                        )),
                    onPressed: null,
                    child: const Text("Confirm",
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
