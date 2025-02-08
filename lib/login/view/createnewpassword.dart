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
                Text("Create new password",
                    key: Key("text_screen_title"),
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left),
                SizedBox(height: 24),
                Text(
                    "Your new password must be different from previously used password",
                    style: TextStyle(
                      fontSize: 15.59,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.left),
                SizedBox(height: 48),
                TextFormField(
                  obscureText: _obscureNewPasswordText,
                  decoration: InputDecoration(
                      hintText: 'New Password',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFD6D6D6)),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureNewPasswordText
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureNewPasswordText = !_obscureNewPasswordText;
                          });
                        },
                      )),
                ),
                SizedBox(height: 28),
                TextFormField(
                  obscureText: _obscureConfirmPasswordText,
                  decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFD6D6D6)),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirmPasswordText
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureConfirmPasswordText = !_obscureConfirmPasswordText;
                          });
                        },
                      )),
                ),
                SizedBox(height: 64),
                Center(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        backgroundColor: Color(0xFFAB8B57),
                        minimumSize: Size(164, 48),
                        side: BorderSide(
                          color: Colors.transparent, // Border color
                        )),
                    onPressed: () {
                      //VerificationCodeRoute().push(context);
                    },
                    child: Text("Confirm",
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
