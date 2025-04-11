import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:highstyleapparel/login/view/createnewpassword.dart';
import 'package:highstyleapparel/login/view/splash.dart';
import 'package:highstyleapparel/login/view/verificationcode.dart';

import 'home/view/home.dart';
import 'login/view/forgotpassword.dart';
import 'login/view/login.dart';
import 'login/view/signup.dart';
import 'login/view/welcome.dart';

part 'navigations.g.dart';

//https://pub.dev/packages/go_router
//https://github.com/flutter/packages/blob/main/packages/go_router_builder/example/lib/simple_example.dart
//https://pub.dev/documentation/go_router/latest/topics/Type-safe%20routes-topic.html
@TypedGoRoute<SplashRoute>(path: '/')
@immutable
class SplashRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const Splash();
  }
}

@TypedGoRoute<WelcomeRoute>(path: '/welcome')
@immutable
class WelcomeRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const Welcome();
  }
}

@TypedGoRoute<LoginRoute>(path: '/login')
@immutable
class LoginRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const Login();
  }
}

@TypedGoRoute<SignUpRoute>(path: '/signup')
@immutable
class SignUpRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SignUp();
  }
}

@TypedGoRoute<VerificationCodeRoute>(path: '/verificationcode')
@immutable
class VerificationCodeRoute extends GoRouteData {
  const VerificationCodeRoute({required this.sessionId, required this.emailId});

  final String sessionId;
  final String emailId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return VerificationCode(sessionId: sessionId, emailId: emailId);
  }
}

@TypedGoRoute<ForgotPasswordRoute>(path: '/forgotpassword')
@immutable
class ForgotPasswordRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ForgotPassword();
  }
}

@TypedGoRoute<CreateNewPasswordRoute>(path: '/createnewpassword')
@immutable
class CreateNewPasswordRoute extends GoRouteData {
  const CreateNewPasswordRoute({required this.sessionId});

  final String sessionId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CreateNewPassword(sessionId: sessionId);
  }
}

@TypedGoRoute<HomeRoute>(path: '/home')
@immutable
class HomeRoute extends GoRouteData {
  const HomeRoute({required this.customerId});

  final String customerId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Home(customerId: customerId);
  }
}
