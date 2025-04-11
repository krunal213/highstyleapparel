import 'dependencies.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'generated/l10n.dart';
import 'navigations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(HighStreetApparel());
}

class HighStreetApparel extends StatelessWidget {
  HighStreetApparel({super.key});

  final GoRouter _router = GoRouter(routes: $appRoutes);

  @override
  Widget build(BuildContext context) => MaterialApp.router(
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
          fontFamily: 'Popins'),
      debugShowCheckedModeBanner: false,
      routerConfig: _router);
}
