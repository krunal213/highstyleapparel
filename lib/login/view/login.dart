import 'package:flutter/material.dart';
import 'package:highstyleapparel/navigations.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
                      const Text("Log into\nyour account",
                          key: Key("text_screen_title"),
                          style: TextStyle(
                            fontSize: 24.0,
                            color: Colors.black,
                            height: 2.2,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left),
                      const SizedBox(height: 48),
                      const TextField(
                        key: Key("text_form_field_email_address"),
                        decoration: InputDecoration(
                          hintText: 'Email address',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFD6D6D6)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),
                      const TextField(
                        key: Key("text_form_field_password"),
                        decoration: InputDecoration(
                          hintText: 'Password',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFD6D6D6)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                              key: const Key("gesture_detector_forgot_password"),
                              onTap: () {
                                ForgotPasswordRoute().push(context);
                              },
                              child: const Text(
                                key: Key("text_forgot_password"),
                                "Forgot Password?",
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.black),
                              ))),
                      const SizedBox(height: 24),
                      Center(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              backgroundColor: const Color(0xFFAB8B57),
                              minimumSize: const Size(164, 48),
                              side: const BorderSide(
                                color: Colors.transparent, // Border color
                              )),
                          onPressed: null,
                          child: const Text(
                              key: Key("text_login"),
                              "LOG IN",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            key: Key("text_don't_have_an_account"),
                            "Don’t have an account?",
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.black),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                              key: const Key("gesture_detector_sign_up"),
                              onTap: () {
                                SignUpRoute().push(context);
                              },
                              child: const Text(
                                key: Key("text_sign_up"),
                                "Sign Up",
                                style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                    decoration: TextDecoration.underline),
                              ))
                        ],
                      )
                    ],
                  )))),
    );
  }
}
