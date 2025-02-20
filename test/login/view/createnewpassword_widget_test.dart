import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:highstyleapparel/login/view/createnewpassword.dart';
import 'package:highstyleapparel/navigations.dart';

void main(){
  testWidgets('When Click On Suffix Button Of New Password', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: CreateNewPassword(),
    ));

    Finder text_field_new_password_finder = find.byKey(Key("text_field_new_password"));
    expect(text_field_new_password_finder, findsOneWidget);
    TextField text_field_new_password = tester.widget<TextField>(text_field_new_password_finder);
    expect(text_field_new_password.obscureText, true);

    Finder icon_button_new_password_finder = find.byKey(Key("icon_button_new_password"));
    expect(icon_button_new_password_finder, findsOneWidget);
    IconButton icon_button_new_password = tester.widget<IconButton>(icon_button_new_password_finder);
    Icon icon_password = icon_button_new_password.icon as Icon;
    expect(icon_password.icon, Icons.visibility_off);

    await tester.tap(icon_button_new_password_finder);
    await tester.pumpAndSettle();

    text_field_new_password_finder = find.byKey(Key("text_field_new_password"));
    expect(text_field_new_password_finder, findsOneWidget);
    text_field_new_password = tester.widget<TextField>(text_field_new_password_finder);
    expect(text_field_new_password.obscureText, false);

    icon_button_new_password_finder = find.byKey(Key("icon_button_new_password"));
    expect(icon_button_new_password_finder, findsOneWidget);
    icon_button_new_password = tester.widget<IconButton>(icon_button_new_password_finder);
    icon_password = icon_button_new_password.icon as Icon;
    expect(icon_password.icon, Icons.visibility);
  });

  testWidgets('When Click On Suffix Button Of Confirm New Password', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: CreateNewPassword(),
    ));

    Finder text_field_confirm_password_finder = find.byKey(Key("text_field_confirm_password"));
    expect(text_field_confirm_password_finder, findsOneWidget);
    TextField text_field_confirm_password = tester.widget<TextField>(text_field_confirm_password_finder);
    expect(text_field_confirm_password.obscureText, true);

    Finder icon_button_confirm_password_finder = find.byKey(Key("icon_button_confirm_password"));
    expect(icon_button_confirm_password_finder, findsOneWidget);
    IconButton icon_button_confirm_password = tester.widget<IconButton>(icon_button_confirm_password_finder);
    Icon icon_password = icon_button_confirm_password.icon as Icon;
    expect(icon_password.icon, Icons.visibility_off);

    await tester.tap(icon_button_confirm_password_finder);
    await tester.pumpAndSettle();

    text_field_confirm_password_finder = find.byKey(Key("text_field_confirm_password"));
    expect(text_field_confirm_password_finder, findsOneWidget);
    text_field_confirm_password = tester.widget<TextField>(text_field_confirm_password_finder);
    expect(text_field_confirm_password.obscureText, false);

    icon_button_confirm_password_finder = find.byKey(Key("icon_button_confirm_password"));
    expect(icon_button_confirm_password_finder, findsOneWidget);
    icon_button_confirm_password = tester.widget<IconButton>(icon_button_confirm_password_finder);
    icon_password = icon_button_confirm_password.icon as Icon;
    expect(icon_password.icon, Icons.visibility);
  });

  testWidgets('When Click On Outlined Button Of Confirm', (WidgetTester tester) async {
    GoRouter goRouter = GoRouter(
        routes: $appRoutes,
        initialLocation: CreateNewPasswordRoute().location
    );
    await tester.pumpWidget(MaterialApp.router(
        routerConfig: goRouter
    ));
    final buttonFinder = find.byKey(Key('outlined_button_confirm'));
    await tester.ensureVisible(buttonFinder);
    await tester.tap(buttonFinder);
    await tester.pump();
    expect(goRouter.state?.path, LoginRoute().location);
  });
}