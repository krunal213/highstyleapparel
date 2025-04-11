import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:highstyleapparel/generated/l10n.dart';
import 'package:highstyleapparel/navigations.dart';

class HighStreetApparelTest {
  final String initialLocation;
  final GoRouter _router;

  HighStreetApparelTest(this.initialLocation)
      : _router = GoRouter(routes: $appRoutes, initialLocation: initialLocation);

  GoRouter get router => _router;

  MaterialApp get widget => MaterialApp.router(
    locale: const Locale('en'),
    supportedLocales: S.delegate.supportedLocales,
    localizationsDelegates: const [
      S.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    title: 'HighStyleApparel',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      useMaterial3: true,
      fontFamily: 'Poppins', // Fixed typo (Popins → Poppins)
    ),
    debugShowCheckedModeBanner: false,
    routerConfig: _router,
  );
}
