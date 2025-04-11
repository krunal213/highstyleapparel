import 'package:flutter/material.dart';
import 'package:highstyleapparel/navigations.dart';
import 'package:highstyleapparel/generated/l10n.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        const Image(
          key: Key("image_widget_background"),
          image: AssetImage('assets/images/ic_welcome_background.png'),
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
        ),
        Opacity(
            key: const Key("opacity_widget"),
            opacity: 0.85,
            child: Container(
              color: Colors.black,
              height: double.infinity,
              width: double.infinity,
            )),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Image(
                key: Key("image_widget_icon"),
                image: AssetImage('assets/images/ic_high_style.png'),
                width: 254,
                height: 216,
              ),
              Text(S.of(context).title_welcome_screen_title,
                  key: const Key("text_widget_welcome_message"),
                  style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textAlign: TextAlign.center),
              const SizedBox(height: 2),
              Text(S.of(context).title_welcome_screen_sub_title,
                  key: const Key("text_widget_slogan"),
                  style: const TextStyle(fontSize: 16.0, color: Colors.white),
                  textAlign: TextAlign.center),
              const SizedBox(height: 16),
              OutlinedButton(
                  key: const Key("outlinebutton_widget_login"),
                  style: OutlinedButton.styleFrom(
                          backgroundColor: const Color(0xFF444343),
                          minimumSize: const Size(164, 48),
                          side: const BorderSide(
                            color: Colors.white, // Border color
                            width: 1.18, // Stroke size (thickness)
                          ))
                      .copyWith(
                          overlayColor: MaterialStateProperty.all(
                              Colors.white.withOpacity(0.2))),
                  onPressed: () =>
                    LoginRoute().go(context),
                  child: Text(S.of(context).title_login_uppercase,
                      style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white))),
              const SizedBox(height: 16),
              OutlinedButton(
                key: const Key("outlinebutton_widget_signup"),
                style: OutlinedButton.styleFrom(
                        backgroundColor: const Color(0xFF444343),
                        minimumSize: const Size(164, 48),
                        side: const BorderSide(
                          color: Colors.white, // Border color
                          width: 1.18, // Stroke size (thickness)
                        ))
                    .copyWith(
                        overlayColor: MaterialStateProperty.all(
                            Colors.white.withOpacity(0.3))),
                onPressed: () =>
                  SignUpRoute().go(context),
                child: Text(S.of(context).title_signup_uppercase,
                    style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              )
            ],
          ),
        )
      ]),
    );
  }
}
