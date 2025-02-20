import 'package:flutter/material.dart';
import 'package:highstyleapparel/navigations.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
                      const Text("Create New Account",
                          key: Key("text_screen_title"),
                          style: TextStyle(
                            fontSize: 24.0,
                            color: Colors.black,
                            height: 2.4,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left),
                      const SizedBox(height: 8),
                      const TextField(
                        key: Key("text_field_first_name"),
                        decoration: InputDecoration(
                          hintText: 'First Name*',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFD6D6D6)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),
                      const TextField(
                        key: Key("text_field_last_name"),
                        decoration: InputDecoration(
                          hintText: 'Last Name',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFD6D6D6)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),
                      const TextField(
                        key: Key("text_field_email_address"),
                        decoration: InputDecoration(
                          hintText: 'Email address*',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFD6D6D6)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),
                      const TextField(
                        key: Key("text_field_password"),
                        decoration: InputDecoration(
                          hintText: 'Password*',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFD6D6D6)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),
                      const TextField(
                        key: Key("text_field_confirm_password"),
                        decoration: InputDecoration(
                          hintText: 'Confirm password*',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFD6D6D6)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),
                      const TextField(
                        key: Key("text_field_mobile_number"),
                        decoration: InputDecoration(
                          hintText: 'Enter Mobile Number*',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFD6D6D6)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 48),
                      Center(
                        child: OutlinedButton(
                          key: Key("outlined_button_sign_up"),
                          style: OutlinedButton.styleFrom(
                              backgroundColor: Color(0xFFAB8B57),
                              minimumSize: Size(164, 48),
                              side: const BorderSide(
                                color: Colors.transparent, // Border color
                              )),
                          onPressed: () {
                            VerificationCodeRoute().push(context);
                          },
                          child: const Text("SIGN UP",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                      ),
                      const SizedBox(height: 48),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have account?",
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.black),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                              key: Key('gesture_detector_login'),
                              onTap: () {
                                LoginRoute().go(context);
                              },
                              child: const Text(
                                "Log In",
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
