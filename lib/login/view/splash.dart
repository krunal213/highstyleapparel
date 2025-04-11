import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:highstyleapparel/login/bloc/splash_bloc.dart';
import 'package:highstyleapparel/navigations.dart';
import 'package:highstyleapparel/result.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  late SplashBloc _splashBloc;

  @override
  void initState() {
    _splashBloc = GetIt.I<SplashBloc>();
    _splashBloc.isUserLogin();
  }

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
        const Center(
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
              SizedBox(height: 16),
              CircularProgressIndicator()
            ],
          ),
        ),
        StreamBuilder<Result<String>>(
          stream: _splashBloc.isUserLoginStream,
          builder: (context, snapshot) {
            Result<String>? result = snapshot.data;
            if (result is Success<String>) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                HomeRoute(customerId: result.value).go(context);
              });
            } else if (result is Error) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                WelcomeRoute().go(context);
              });
            }

            return const SizedBox.shrink();
          },
        )
      ]),
    );
  }
}
