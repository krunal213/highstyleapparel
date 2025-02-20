import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:highstyleapparel/login/view/createnewpassword.dart';
import 'package:highstyleapparel/login/view/verificationcode.dart';

import 'login/view/forgotpassword.dart';
import 'login/view/login.dart';
import 'login/view/signup.dart';
import 'login/view/welcome.dart';

part 'navigations.g.dart';

//https://pub.dev/packages/go_router
//https://github.com/flutter/packages/blob/main/packages/go_router_builder/example/lib/simple_example.dart
//https://pub.dev/documentation/go_router/latest/topics/Type-safe%20routes-topic.html

@TypedGoRoute<WelcomeRoute>(path: '/')
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
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const VerificationCode();
  }
}

@TypedGoRoute<ForgotPasswordRoute>(
    path: '/forgotpassword',
    routes: <TypedGoRoute<GoRouteData>>[
      TypedGoRoute<CreateNewPasswordRoute>(path: 'createnewpassword')
    ])
@immutable
class ForgotPasswordRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ForgotPassword();
  }
}

@immutable
class CreateNewPasswordRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CreateNewPassword();
  }
}
