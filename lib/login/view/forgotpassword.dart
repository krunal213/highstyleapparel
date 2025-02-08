import 'package:flutter/material.dart';
import 'package:highstyleapparel/highstyleappbar.dart';
import 'package:highstyleapparel/navigations.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: HighStyleAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 32, left: 33, right: 33),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Forgot password?",
                    key: Key("text_screen_title"),
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left),
                SizedBox(height: 24),
                Text(
                    "Enter email associated with your account and we’ll send and email with intructions to reset your password",
                    style: TextStyle(
                      fontSize: 15.59,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.left),
                SizedBox(height: 48),
                TextFormField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.email_outlined),
                      hintText: 'Enter your email here',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFD6D6D6)),
                      ),
                    ),
                    onFieldSubmitted: (value) {
                      CreateNewPasswordRoute().push(context);
                    })
              ],
            ),
          ),
        ));
  }
}
