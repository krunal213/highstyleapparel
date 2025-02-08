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
                  padding: EdgeInsets.only(top: 63, left: 33, right: 33),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Create New Account",
                          key: Key("text_screen_title"),
                          style: TextStyle(
                            fontSize: 24.0,
                            color: Colors.black,
                            height: 2.4,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left),
                      SizedBox(height: 8),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'First Name*',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFD6D6D6)),
                          ),
                        ),
                      ),
                      SizedBox(height: 28),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Last Name',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFD6D6D6)),
                          ),
                        ),
                      ),
                      SizedBox(height: 28),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Email address*',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFD6D6D6)),
                          ),
                        ),
                      ),
                      SizedBox(height: 28),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Password*',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFD6D6D6)),
                          ),
                        ),
                      ),
                      SizedBox(height: 28),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Confirm password*',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFD6D6D6)),
                          ),
                        ),
                      ),
                      SizedBox(height: 28),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Enter Mobile Number*',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFD6D6D6)),
                          ),
                        ),
                      ),
                      SizedBox(height: 48),
                      Center(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              backgroundColor: Color(0xFFAB8B57),
                              minimumSize: Size(164, 48),
                              side: BorderSide(
                                color: Colors.transparent, // Border color
                              )),
                          onPressed: () {
                            VerificationCodeRoute().push(context);
                          },
                          child: Text("SIGN UP",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                      ),
                      SizedBox(height: 48),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have account?",
                            style:
                            TextStyle(fontSize: 14.0, color: Colors.black),
                          ),
                          SizedBox(width: 8),
                          GestureDetector(
                              onTap: () {
                                LoginRoute().push(context);
                              },
                              child: Text(
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
