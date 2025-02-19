// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:highstyleapparel/login/view/login.dart';
import 'package:highstyleapparel/navigations.dart';

void main() {

  /*testWidgets('When Login Screen Open', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Login(),
    ));

    Finder text_screen_title_finder = find.byKey(Key("text_screen_title"));
    expect(text_screen_title_finder, findsOneWidget);
    final text_widget_title = tester.widget<Text>(text_screen_title_finder);
    expect(text_widget_title.data, 'Log into\nyour account');
    expect((text_widget_title.style as TextStyle).color, Colors.black);
    expect((text_widget_title.style as TextStyle).fontSize,24.0);
    expect((text_widget_title.style as TextStyle).fontWeight,FontWeight.bold);
    expect(text_widget_title.textAlign,TextAlign.left);

    Finder text_form_field_email_address_finder = find.byKey(Key("text_form_field_email_address"));
    expect(text_form_field_email_address_finder, findsOneWidget);
    final text_form_field_email_address = tester.widget<TextField>(text_form_field_email_address_finder);
    expect(text_form_field_email_address.decoration?.hintText, 'Email address');

    Finder text_form_field_password_finder = find.byKey(Key("text_form_field_password"));
    expect(text_form_field_password_finder, findsOneWidget);
    final text_form_field_password = tester.widget<TextField>(text_form_field_password_finder);
    expect(text_form_field_password.decoration?.hintText, 'Password');

    Finder text_forgot_password_finder = find.byKey(Key("text_forgot_password"));
    expect(text_forgot_password_finder, findsOneWidget);
    final text_forgot_password = tester.widget<Text>(text_forgot_password_finder);
    expect(text_forgot_password.data, 'Forgot Password?');
    expect((text_forgot_password.style as TextStyle).color, Colors.black);
    expect((text_forgot_password.style as TextStyle).fontSize, 12.0);

    Finder text_login_finder = find.byKey(Key("text_login"));
    expect(text_login_finder, findsOneWidget);
    final text_login = tester.widget<Text>(text_login_finder);
    expect(text_login.data, 'LOG IN');
    expect((text_login.style as TextStyle).color, Colors.white);
    expect((text_login.style as TextStyle).fontSize, 16.0);
    expect((text_login.style as TextStyle).fontWeight,FontWeight.bold);

    Finder text_dont_have_an_account_finder = find.byKey(Key("text_don't_have_an_account"));
    expect(text_dont_have_an_account_finder, findsOneWidget);
    final text_dont_have_an_account = tester.widget<Text>(text_dont_have_an_account_finder);
    expect(text_dont_have_an_account.data, 'Don’t have an account?');
    expect((text_dont_have_an_account.style as TextStyle).fontSize,14.0);
    expect((text_dont_have_an_account.style as TextStyle).color,Colors.black);

    Finder text_sign_up_finder = find.byKey(Key("text_sign_up"));
    expect(text_sign_up_finder, findsOneWidget);
    final text_sign_up = tester.widget<Text>(text_sign_up_finder);
    expect(text_sign_up.data, 'Sign Up');
    expect((text_sign_up.style as TextStyle).fontSize,14.0);
    expect((text_sign_up.style as TextStyle).color,Colors.black);
    expect((text_sign_up.style as TextStyle).decoration,TextDecoration.underline);
  });*/

  testWidgets('When Click On Forgot Password? In Login Screen', (WidgetTester tester) async {
    GoRouter goRouter = GoRouter(
        routes: $appRoutes,
        initialLocation: LoginRoute().location
    );
    await tester.pumpWidget(MaterialApp.router(
        routerConfig: goRouter
    ));
    await tester.tap(find.byKey(Key('gesture_detector_forgot_password')));
    await tester.pumpAndSettle();
    expect(goRouter.state?.path, "/forgotpassword");
  });

  testWidgets('When Click On Sign Up In Login Screen', (WidgetTester tester) async {
    GoRouter goRouter = GoRouter(
        routes: $appRoutes,
        initialLocation: LoginRoute().location
    );
    await tester.pumpWidget(MaterialApp.router(
        routerConfig: goRouter
    ));
    await tester.tap(find.byKey(Key('gesture_detector_sign_up')));
    await tester.pumpAndSettle();
    expect(goRouter.state?.path, "/signup");
  });

}
