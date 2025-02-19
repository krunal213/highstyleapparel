import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:highstyleapparel/navigations.dart';

void main(){
  testWidgets('When Click On Enter Button After Typing Email Address In Forget Password Screen', (WidgetTester tester) async {
    GoRouter goRouter = GoRouter(
        routes: $appRoutes,
        initialLocation: ForgotPasswordRoute().location
    );
    await tester.pumpWidget(MaterialApp.router(
        routerConfig: goRouter
    ));

    Finder text_form_field_email_address_finder = find.byKey(Key("text_form_field_email_address"));

    // Enter text
    await tester.enterText(text_form_field_email_address_finder, '');

    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
    expect(goRouter.state?.path, "/createnewpassword");
  });
}