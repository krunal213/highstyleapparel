import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:highstyleapparel/login/view/createnewpassword.dart';
import 'package:highstyleapparel/login/view/verificationcode.dart';
import 'package:highstyleapparel/splash/splash.dart';

import 'login/view/forgotpassword.dart';
import 'login/view/login.dart';
import 'login/view/signup.dart';

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
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const VerificationCode();
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
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CreateNewPassword();
  }
}

