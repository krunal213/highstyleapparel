import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:highstyleapparel/high_style_obscure_text_field.dart';
import 'package:highstyleapparel/login/entity/reset_password_request.dart';
import 'package:highstyleapparel/login/entity/reset_password_response.dart';
import 'package:highstyleapparel/navigations.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import '../../dependencies.dart';
import '../../high_street_apparel.dart';
import '../repository/datasource/network/mock_login_flow_rest_client.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late GetIt getIt;
  late HighStreetApparelTest highStreetApparelTest;

  const String sessionId = "12345";
  const String password = "12345";

  setUp(() {
    getIt = initTestDependencies();
    registerFallbackValue(const ResetPasswordRequest(sessionId, password));
    highStreetApparelTest = HighStreetApparelTest(
        const CreateNewPasswordRoute(sessionId: sessionId).location);
  });

  tearDown(() {
    getIt.reset();
  });

  testWidgets('When New Password Is Empty', (tester) async {
    await tester.pumpWidget(highStreetApparelTest.widget);

    await tester
        .ensureVisible(find.byKey(const Key('outlined_button_confirm')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('outlined_button_confirm')));
    await tester.pump();
    await tester.pump();

    Finder textFieldNewPasswordFinder =
        find.byKey(const Key("text_field_new_password"));
    expect(textFieldNewPasswordFinder, findsOneWidget);

    final textFieldNewPassword =
        tester.widget<HighStyleObscureTextField>(textFieldNewPasswordFinder);
    expect(textFieldNewPassword.hintText, 'New Password');
    expect(textFieldNewPassword.errorText, 'Please enter a valid password.');
  });

  testWidgets('When Confirm Password Is Empty', (tester) async {
    await tester.pumpWidget(highStreetApparelTest.widget);

    await tester.enterText(
        find.byKey(const Key("text_field_new_password")), password);
    await tester.pumpAndSettle();

    await tester
        .ensureVisible(find.byKey(const Key('outlined_button_confirm')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('outlined_button_confirm')));
    await tester.pump();
    await tester.pump();

    Finder textFieldNewPasswordFinder =
        find.byKey(const Key("text_field_confirm_password"));
    expect(textFieldNewPasswordFinder, findsOneWidget);

    final textFieldNewPassword =
        tester.widget<HighStyleObscureTextField>(textFieldNewPasswordFinder);
    expect(textFieldNewPassword.hintText, 'Confirm Password');
    expect(textFieldNewPassword.errorText,
        'Please enter a valid confirm password.');
  });

  testWidgets('When Password Is Mismatch', (tester) async {
    await tester.pumpWidget(highStreetApparelTest.widget);

    await tester.enterText(
        find.byKey(const Key("text_field_new_password")), password);
    await tester.pumpAndSettle();

    const String confirmPassword = "1234";
    await tester.enterText(
        find.byKey(const Key("text_field_confirm_password")), confirmPassword);
    await tester.pumpAndSettle();

    await tester
        .ensureVisible(find.byKey(const Key('outlined_button_confirm')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('outlined_button_confirm')));
    await tester.pump();
    await tester.pump();

    Finder textFieldNewPasswordFinder =
        find.byKey(const Key("text_field_confirm_password"));
    expect(textFieldNewPasswordFinder, findsOneWidget);

    final textFieldNewPassword =
        tester.widget<HighStyleObscureTextField>(textFieldNewPasswordFinder);
    expect(textFieldNewPassword.hintText, 'Confirm Password');
    expect(textFieldNewPassword.errorText,
        'Mismatch detected! Please re-enter the correct confirm password.');
  });

  testWidgets('When Click On Confirm Button And Receive No Internet Exception',
      (WidgetTester tester) async {
    await tester.pumpWidget(highStreetApparelTest.widget);

    when(() => getIt.get<MockLoginFlowRestClient>().resetPasswordRequest(any()))
        .thenAnswer((_) async {
      await Future.delayed(const Duration(seconds: 1));

      throw DioException(
        requestOptions: RequestOptions(path: '/reset-password'),
        type: DioExceptionType.connectionError,
      );
    });

    await tester.enterText(
        find.byKey(const Key("text_field_new_password")), password);
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(const Key("text_field_confirm_password")), password);
    await tester.pumpAndSettle();

    await tester
        .ensureVisible(find.byKey(const Key('outlined_button_confirm')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('outlined_button_confirm')));
    await tester.pump();
    await tester.pump();

    await expectLater(find.byType(AlertDialog), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text("Loading"), findsOneWidget);

    await tester.pumpAndSettle();

    await expectLater(find.byType(AlertDialog), findsOneWidget);
    expect(find.text("Alert!"), findsOneWidget);
    expect(find.text("Please check internet connection"), findsOneWidget);

    await tester.tap(find.byKey(const Key('dialog_ok_button')));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsNothing);
  });

  testWidgets('When Click On Confirm Button And Receive 500',
      (WidgetTester tester) async {
    await tester.pumpWidget(highStreetApparelTest.widget);

    when(() => getIt.get<MockLoginFlowRestClient>().resetPasswordRequest(any()))
        .thenAnswer((_) async {
      await Future.delayed(const Duration(seconds: 1));

      throw DioException(
        requestOptions: RequestOptions(path: '/reset-password'),
        response: Response(
            requestOptions: RequestOptions(path: '/reset-password'),
            statusCode: 500),
      );
    });

    await tester.enterText(
        find.byKey(const Key("text_field_new_password")), password);
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(const Key("text_field_confirm_password")), password);
    await tester.pumpAndSettle();

    await tester
        .ensureVisible(find.byKey(const Key('outlined_button_confirm')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('outlined_button_confirm')));
    await tester.pump();
    await tester.pump();

    await expectLater(find.byType(AlertDialog), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text("Loading"), findsOneWidget);

    await tester.pumpAndSettle();

    await expectLater(find.byType(AlertDialog), findsOneWidget);
    expect(find.text("Alert!"), findsOneWidget);
    expect(find.text("Oops! Something went wrong."), findsOneWidget);

    await tester.tap(find.byKey(const Key('dialog_ok_button')));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsNothing);
  });

  testWidgets('When Click On Confirm Button And Receive Success',
      (WidgetTester tester) async {
    await tester.pumpWidget(highStreetApparelTest.widget);

    const String success = "Success";

    when(() => getIt.get<MockLoginFlowRestClient>().resetPasswordRequest(any()))
        .thenAnswer((_) async {
      await Future.delayed(const Duration(seconds: 1));

      return const ResetPasswordResponse(success);
    });

    await tester.enterText(
        find.byKey(const Key("text_field_new_password")), password);
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(const Key("text_field_confirm_password")), password);
    await tester.pumpAndSettle();

    await tester
        .ensureVisible(find.byKey(const Key('outlined_button_confirm')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('outlined_button_confirm')));
    await tester.pump();
    await tester.pump();

    await expectLater(find.byType(AlertDialog), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text("Loading"), findsOneWidget);

    await tester.pumpAndSettle();

    await expectLater(find.byType(AlertDialog), findsOneWidget);
    expect(find.text("Alert!"), findsOneWidget);
    expect(find.text("Success"), findsOneWidget);

    await tester.tap(find.byKey(const Key('dialog_ok_button')));
    await tester.pumpAndSettle();

    expect(highStreetApparelTest.router.state?.path, LoginRoute().location);
  });
}
