import 'package:flutter/material.dart';
import 'package:highstyleapparel/highstyleappbar.dart';
import 'package:pinput/pinput.dart';

class VerificationCode extends StatefulWidget {
  const VerificationCode({super.key});

  @override
  State<VerificationCode> createState() => _VerificationCodeState();
}

class _VerificationCodeState extends State<VerificationCode> {
  final defaultPinTheme = PinTheme(
    width: 38,
    height: 38,
    decoration: BoxDecoration(
      border: Border.all(color: Color(0xFFA5A7AC)),
      borderRadius: BorderRadius.circular(20),
    ),
  );

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
                const Text("Verification code",
                    key: Key("text_screen_title"),
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                    ),
                    textAlign: TextAlign.left),
                const SizedBox(height: 16),
                const Text(
                    "Please enter the verification code we sent\nto your email address",
                    style: TextStyle(
                      fontSize: 14.0,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.left),
                const SizedBox(height: 48),
                Center(
                  child: Pinput(
                    length: 6,
                    defaultPinTheme: defaultPinTheme,
                  ),
                ),
                const SizedBox(height: 48),
                Row(
                  children: [
                    const Text(
                      "Resend in",
                      style:
                          TextStyle(fontSize: 14.0, color: Color(0xFFA5A7AC)),
                    ),
                    const SizedBox(height: 80),
                    GestureDetector(
                        onTap: null,
                        child: const Text(
                          "00:10",
                          style: TextStyle(
                              fontSize: 14.0, color: Color(0xFFA5A7AC)),
                        ))
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
