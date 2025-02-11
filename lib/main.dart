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
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
          fontFamily: 'Popins',
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(
                  Colors.black12.withOpacity(0.2)), // Ripple effect color
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        routerConfig: _router);
  }
}
