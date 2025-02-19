import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:highstyleapparel/navigations.dart';

void main(){
  testWidgets('When Click On SIGN UP In Sign Up Screen', (WidgetTester tester) async {
    GoRouter goRouter = GoRouter(
        routes: $appRoutes,
        initialLocation: SignUpRoute().location
    );
    await tester.pumpWidget(MaterialApp.router(
        routerConfig: goRouter
    ));
    final buttonFinder = find.byKey(Key('outlined_button_sign_up'));
    await tester.ensureVisible(buttonFinder);
    await tester.tap(buttonFinder);
    await tester.pump();
    expect(goRouter.state?.path, "/verificationcode");
  });

  testWidgets('When Click On Log In In Sign Up Screen', (WidgetTester tester) async {
    GoRouter goRouter = GoRouter(
        routes: $appRoutes,
        initialLocation: SignUpRoute().location
    );
    await tester.pumpWidget(MaterialApp.router(
        routerConfig: goRouter
    ));
    final buttonFinder = find.byKey(Key('gesture_detector_login'));
    await tester.ensureVisible(buttonFinder);
    await tester.tap(buttonFinder);
    await tester.pump();
    expect(goRouter.state?.path, "/login");
  });

}