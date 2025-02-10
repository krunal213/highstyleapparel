import 'package:flutter/material.dart';
import 'package:highstyleapparel/navigations.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Image(
          key: Key("image_widget_background"),
          image: AssetImage('assets/images/ic_welcome_background.png'),
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
        ),
        Opacity(
            key: Key("opacity_widget"),
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
              Image(
                key: Key("image_widget_icon"),
                image: AssetImage('assets/images/ic_high_style.png'),
                width: 254,
                height: 216,
              ),
              Text(
                  "Welcome to \n High Style Apparel",
                  key: Key("text_widget_welcome_message"),
                  style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textAlign: TextAlign.center),
              SizedBox(height: 2),
              Text("The home for a highstyleapparel",
                  key: Key("text_widget_slogan"),
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                  textAlign: TextAlign.center),
              SizedBox(height: 16),
              OutlinedButton(
                  key: Key("outlinebutton_widget_login"),
                  style: OutlinedButton.styleFrom(
                      backgroundColor: Color(0xFF444343),
                      minimumSize: Size(164, 48),
                      side: BorderSide(
                        color: Colors.white, // Border color
                        width: 1.18, // Stroke size (thickness)
                      )),
                  onPressed: () {
                    LoginRoute().push(context);
                  },
                  child: Text("LOG IN",
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white))),
              SizedBox(height: 16),
              OutlinedButton(
                key: Key("outlinebutton_widget_signup"),
                style: OutlinedButton.styleFrom(
                    backgroundColor: Color(0xFF444343),
                    minimumSize: Size(164, 48),
                    side: BorderSide(
                      color: Colors.white, // Border color
                      width: 1.18, // Stroke size (thickness)
                    )),
                onPressed: () {
                  SignUpRoute().push(context);
                },
                child: Text("SIGN UP",
                    style: TextStyle(
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
