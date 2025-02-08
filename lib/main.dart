import 'dependencies.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'navigations.dart';

void main() {
  initObjects();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter _router = GoRouter(routes: $appRoutes);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        title: 'CrowdFunding',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            fontFamily: 'Popins'),
        debugShowCheckedModeBanner: false,
        routerConfig: _router);
  }
}
