import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:highstyleapparel/login/entity/login_request.dart';
import 'package:highstyleapparel/login/entity/login_response.dart';
import 'package:highstyleapparel/navigations.dart';
import 'package:integration_test/integration_test.dart';
import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import '../../dependencies.dart';
import '../../high_street_apparel.dart';
import '../repository/datasource/network/mock_login_flow_rest_client.dart';
import '../repository/datasource/sharedpref/mock_shared_preferences.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late GetIt getIt;
  late HighStreetApparelTest highStreetApparelTest;

  const String userId = "12345";
  const String email = "test@example.com";
  const String password = "password123";

  setUp(() {
    getIt = initTestDependencies();
    registerFallbackValue(const LoginRequest(email, password));
    highStreetApparelTest = HighStreetApparelTest(LoginRoute().location);
  });

  tearDown(() {
    getIt.reset();
  });

  testWidgets('When Email Address Is Empty', (tester) async {
    await tester.pumpWidget(highStreetApparelTest.widget);

    await tester.ensureVisible(find.byKey(const Key('outlined_button_login')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('outlined_button_login')));
    await tester.pumpAndSettle();

    Finder textFieldEmailAddressFinder =
        find.byKey(const Key("text_field_email_address"));
    expect(textFieldEmailAddressFinder, findsOneWidget);

    final textFieldEmailAddress =
        tester.widget<TextField>(textFieldEmailAddressFinder);
    expect(textFieldEmailAddress.decoration?.hintText, 'Email address');
    expect(textFieldEmailAddress.decoration?.errorText,
        'Please enter a valid email address.');
  });

  testWidgets('When Email Address Is Invalid', (tester) async {
    await tester.pumpWidget(highStreetApparelTest.widget);

    List<String> invalidEmails = [
      'plainaddress',
      'user@.com',
      'user@domain',
      '@missingusername.com',
      'user@domain..com',
      'user@domain,com',
      'user@domain@domain.com'
    ];

    for (var email in invalidEmails) {
      await tester.enterText(
          find.byKey(const Key("text_field_email_address")), email);
      await tester.pumpAndSettle();

      await tester
          .ensureVisible(find.byKey(const Key('outlined_button_login')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('outlined_button_login')));
      await tester.pumpAndSettle();

      Finder textFieldEmailAddressFinder =
          find.byKey(const Key("text_field_email_address"));
      expect(textFieldEmailAddressFinder, findsOneWidget);
      final textFieldEmailAddress =
          tester.widget<TextField>(textFieldEmailAddressFinder);
      expect(textFieldEmailAddress.decoration?.hintText, 'Email address');
      expect(textFieldEmailAddress.decoration?.errorText,
          'Please enter a valid email address.');
    }
  });

  testWidgets('When Password Is Empty', (tester) async {
    await tester.pumpWidget(highStreetApparelTest.widget);

    await tester.enterText(
        find.byKey(const Key("text_field_email_address")), email);
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.byKey(const Key('outlined_button_login')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('outlined_button_login')));
    await tester.pumpAndSettle();

    Finder textFieldPasswordFinder =
        find.byKey(const Key("text_field_password"));
    expect(textFieldPasswordFinder, findsOneWidget);
    final textFieldPassword = tester.widget<TextField>(textFieldPasswordFinder);
    expect(textFieldPassword.decoration?.hintText, 'Password');
    expect(textFieldPassword.decoration?.errorText,
        'Please enter a valid password.');
  });

  testWidgets('When Click On Login Button And Receive No Internet Exception',
      (WidgetTester tester) async {
    await tester.pumpWidget(highStreetApparelTest.widget);

    when(() => getIt.get<MockLoginFlowRestClient>().login(any())).thenAnswer((_) async {
      await Future.delayed(const Duration(seconds: 1));

      throw DioException(
        requestOptions: RequestOptions(path: '/login'),
        type: DioExceptionType.connectionError,
      );
    });
    when(() => getIt.get<MockSharedPreferences>().setString("customerId", any()))
        .thenAnswer((_) async => true);
    when(() => getIt.get<MockSharedPreferences>().getString("customerId"))
        .thenReturn(userId);

    await tester.enterText(
        find.byKey(const Key("text_field_email_address")), email);
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(const Key("text_field_password")), password);
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.byKey(const Key('outlined_button_login')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('outlined_button_login')));
    await tester.pump();
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text("Loading"), findsOneWidget);

    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text("Alert!"), findsOneWidget);
    expect(find.text("Please check internet connection"), findsOneWidget);

    await tester.tap(find.byKey(const Key('dialog_ok_button')));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsNothing);
  });

  testWidgets('When Click On Login Button And Receive 404',
      (WidgetTester tester) async {
    await tester.pumpWidget(highStreetApparelTest.widget);

    when(() => getIt.get<MockLoginFlowRestClient>().login(any())).thenAnswer((_) async {
      await Future.delayed(const Duration(seconds: 1));

      throw DioException(
        requestOptions: RequestOptions(path: '/login'),
        response: Response(
          requestOptions: RequestOptions(path: '/login'),
          statusCode: 404,
          data: {"message": "Invalid input"},
        ),
      );
    });
    when(() => getIt.get<MockSharedPreferences>().setString("customerId", any()))
        .thenAnswer((_) async => true);
    when(() => getIt.get<MockSharedPreferences>().getString("customerId"))
        .thenReturn(userId);

    await tester.enterText(
        find.byKey(const Key("text_field_email_address")), email);
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(const Key("text_field_password")), password);
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.byKey(const Key('outlined_button_login')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('outlined_button_login')));
    await tester.pump();
    await tester.pump();

    await expectLater(find.byType(AlertDialog), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text("Loading"), findsOneWidget);

    await tester.pumpAndSettle();

    await expectLater(find.byType(AlertDialog), findsOneWidget);
    expect(find.text("Alert!"), findsOneWidget);
    expect(find.text("Invalid input"), findsOneWidget);

    await tester.tap(find.byKey(const Key('dialog_ok_button')));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsNothing);
  });

  testWidgets('When Click On Login Button And Receive 500',
      (WidgetTester tester) async {
    await tester.pumpWidget(highStreetApparelTest.widget);

    when(() => getIt.get<MockLoginFlowRestClient>().login(any())).thenAnswer((_) async {
      await Future.delayed(const Duration(seconds: 1));

      throw DioException(
        requestOptions: RequestOptions(path: '/login'),
        response: Response(
            requestOptions: RequestOptions(path: '/login'), statusCode: 500),
      );
    });
    when(() => getIt.get<MockSharedPreferences>().setString("customerId", any()))
        .thenAnswer((_) async => true);
    when(() => getIt.get<MockSharedPreferences>().getString("customerId"))
        .thenReturn(userId);

    await tester.enterText(
        find.byKey(const Key("text_field_email_address")), email);
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(const Key("text_field_password")), password);
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.byKey(const Key('outlined_button_login')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('outlined_button_login')));
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

  testWidgets('When Click On Login Button And Receive Success',
      (WidgetTester tester) async {
    await tester.pumpWidget(highStreetApparelTest.widget);

    when(() => getIt.get<MockLoginFlowRestClient>().login(any())).thenAnswer((_) async {
      await Future.delayed(const Duration(seconds: 1));

      return const LoginResponse(userId);
    });
    when(() => getIt.get<MockSharedPreferences>().setString("customerId", any()))
        .thenAnswer((_) async => true);
    when(() => getIt.get<MockSharedPreferences>().getString("customerId"))
        .thenReturn(userId);

    await tester.enterText(
        find.byKey(const Key("text_field_email_address")), email);
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(const Key("text_field_password")), password);
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.byKey(const Key('outlined_button_login')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('outlined_button_login')));
    await tester.pump();
    await tester.pump();

    await expectLater(find.byType(AlertDialog), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text("Loading"), findsOneWidget);

    await tester.pumpAndSettle();

    expect(highStreetApparelTest.router.state?.uri.toString(),
        const HomeRoute(customerId: userId).location);
  });

  testWidgets('When Click On Forgot Password', (WidgetTester tester) async {
    await tester.pumpWidget(highStreetApparelTest.widget);

    await tester.tap(find.byKey(const Key('gesture_detector_forgot_password')));
    await tester.pump();

    expect(highStreetApparelTest.router.state?.path, ForgotPasswordRoute().location);
  });

  testWidgets('When Click On Sign Up', (WidgetTester tester) async {
    await tester.pumpWidget(highStreetApparelTest.widget);

    await tester.tap(find.byKey(const Key('gesture_detector_sign_up')));
    await tester.pump();

    expect(highStreetApparelTest.router.state?.path, SignUpRoute().location);
  });
}
