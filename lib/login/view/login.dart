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
                  padding: EdgeInsets.only(top: 63, left: 33, right: 33),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Log into\nyour account",
                          key: Key("text_screen_title"),
                          style: TextStyle(
                            fontSize: 24.0,
                            color: Colors.black,
                            height: 2.2,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left),
                      SizedBox(height: 48),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Email address',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFD6D6D6)),
                          ),
                        ),
                      ),
                      SizedBox(height: 28),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Password',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFD6D6D6)),
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                      Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                              onTap: () {
                                ForgotPasswordRoute().push(context);
                              },
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.black),
                              ))),
                      SizedBox(height: 24),
                      Center(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              backgroundColor: Color(0xFFAB8B57),
                              minimumSize: Size(164, 48),
                              side: BorderSide(
                                color: Colors.transparent, // Border color
                              )),
                          onPressed: () {
                            // TODO(developername): need to implement.
                            //VerificationCodeRoute().push(context);
                          },
                          child: Text("LOG IN",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                      ),
                      SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don’t have an account?",
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.black),
                          ),
                          SizedBox(width: 8),
                          GestureDetector(
                              onTap: () {
                                SignUpRoute().push(context);
                              },
                              child: Text(
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
