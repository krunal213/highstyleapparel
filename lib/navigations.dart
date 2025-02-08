import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:highstyleapparel/splash/splash.dart';

part 'navigations.g.dart';
//https://pub.dev/packages/go_router
//https://github.com/flutter/packages/blob/main/packages/go_router_builder/example/lib/simple_example.dart
//https://pub.dev/documentation/go_router/latest/topics/Type-safe%20routes-topic.html

@TypedGoRoute<SplashPageRoute>(path: '/')
@immutable
class SplashPageRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SplashPage();
  }
}


