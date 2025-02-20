// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:highstyleapparel/login/view/welcome.dart';
import 'package:highstyleapparel/navigations.dart';

void main() {
  testWidgets('When Welcome Screen Open', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Welcome(),
    ));

    Finder image_widget_background_finder =
        find.byKey(Key("image_widget_background"));
    expect(image_widget_background_finder, findsOneWidget);
    final image_widget_background =
        tester.widget<Image>(image_widget_background_finder);
    expect(image_widget_background.image, isA<AssetImage>());
    expect((image_widget_background.image as AssetImage).assetName,
        'assets/images/ic_welcome_background.png');

    Finder opacity_widget_finder = find.byKey(Key("opacity_widget"));
    expect(opacity_widget_finder, findsOneWidget);
    final opacity_widget = tester.widget<Opacity>(opacity_widget_finder);
    expect(opacity_widget.opacity, 0.85);

    Finder image_widget_icon_finder = find.byKey(Key("image_widget_icon"));
    expect(image_widget_icon_finder, findsOneWidget);
    final image_widget_icon = tester.widget<Image>(image_widget_icon_finder);
    expect(image_widget_icon.image, isA<AssetImage>());
    expect((image_widget_icon.image as AssetImage).assetName,
        'assets/images/ic_high_style.png');

    Finder text_widget_welcome_message_finder =
        find.byKey(Key("text_widget_welcome_message"));
    expect(text_widget_welcome_message_finder, findsOneWidget);
    final text_widget_welcome_message =
        tester.widget<Text>(text_widget_welcome_message_finder);
    expect(
        text_widget_welcome_message.data, 'Welcome to \n High Style Apparel');
    expect(
        (text_widget_welcome_message.style as TextStyle).color, Colors.white);

    Finder text_widget_slogan_finder = find.byKey(Key("text_widget_slogan"));
    expect(text_widget_slogan_finder, findsOneWidget);
    final text_widget_slogan = tester.widget<Text>(text_widget_slogan_finder);
    expect(text_widget_slogan.data, 'The home for a highstyleapparel');
    expect((text_widget_slogan.style as TextStyle).color, Colors.white);

    Finder outlinebutton_widget_login_finder =
        find.byKey(Key("outlinebutton_widget_login"));
    expect(outlinebutton_widget_login_finder, findsOneWidget);
    final outlinebutton_widget_login =
        tester.widget<OutlinedButton>(outlinebutton_widget_login_finder);
    expect(outlinebutton_widget_login.child, isA<Text>());
    expect((outlinebutton_widget_login.child as Text).data, 'LOG IN');
    expect(
        ((outlinebutton_widget_login.child as Text).style as TextStyle).color,
        Colors.white);

    Finder outlinebutton_widget_signup_finder =
        find.byKey(Key("outlinebutton_widget_signup"));
    expect(outlinebutton_widget_signup_finder, findsOneWidget);
    final outlinebutton_widget_signup =
        tester.widget<OutlinedButton>(outlinebutton_widget_signup_finder);
    expect(outlinebutton_widget_signup.child, isA<Text>());
    expect((outlinebutton_widget_signup.child as Text).data, 'SIGN UP');
    expect(
        ((outlinebutton_widget_signup.child as Text).style as TextStyle).color,
        Colors.white);
  });

  testWidgets('When Click On Signup Button In Welcome Screen', (WidgetTester tester) async {
    GoRouter goRouter = GoRouter(routes: $appRoutes);
    await tester.pumpWidget(MaterialApp.router(
      routerConfig: goRouter
    ));
    await tester.tap(find.byKey(Key('outlinebutton_widget_signup')));
    await tester.pumpAndSettle();
    expect(goRouter.state?.path, SignUpRoute().location);
  });

  testWidgets('When Click On Login Button In Welcome Screen', (WidgetTester tester) async {
    GoRouter goRouter = GoRouter(routes: $appRoutes);
    await tester.pumpWidget(MaterialApp.router(
        routerConfig: goRouter
    ));
    await tester.tap(find.byKey(Key('outlinebutton_widget_login')));
    await tester.pumpAndSettle();
    expect(goRouter.state?.path, LoginRoute().location);
  });

}
