import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:highstyleapparel/login/entity/send_otp_request.dart';
import 'package:highstyleapparel/login/entity/send_otp_response.dart';
import 'package:highstyleapparel/login/high_style_count_down_timer_helper.dart';
import 'package:highstyleapparel/navigations.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import '../../dependencies.dart';
import '../../high_street_apparel.dart';
import '../repository/datasource/network/mock_login_flow_rest_client.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late GetIt getIt;
  late HighStreetApparelTest highStreetApparelTest;

  const String sessionId = "12345";
  const String email = "test@example.com";

  setUp(() {
    getIt = initTestDependencies();
    registerFallbackValue(const SendOtpRequest(email));
    highStreetApparelTest =
        HighStreetApparelTest(ForgotPasswordRoute().location);
  });

  tearDown(() {
    getIt.reset();
  });

  testWidgets('When Email Address Is Empty', (tester) async {
    await tester.pumpWidget(highStreetApparelTest.widget);

    await tester.tap(find.byKey(const Key("text_field_email_address")));
    await tester.pumpAndSettle();

    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();

    Finder textFieldEmailAddressFinder =
        find.byKey(const Key("text_field_email_address"));
    expect(textFieldEmailAddressFinder, findsOneWidget);

    final textFieldEmailAddress =
        tester.widget<TextField>(textFieldEmailAddressFinder);
    expect(textFieldEmailAddress.decoration?.hintText, 'Enter your email here');
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
      await tester.tap(find.byKey(const Key("text_field_email_address")));
      await tester.pumpAndSettle();

      await tester.enterText(
          find.byKey(const Key("text_field_email_address")), email);
      await tester.pumpAndSettle();

      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      Finder textFieldEmailAddressFinder =
          find.byKey(const Key("text_field_email_address"));
      expect(textFieldEmailAddressFinder, findsOneWidget);
      final textFieldEmailAddress =
          tester.widget<TextField>(textFieldEmailAddressFinder);
      expect(
          textFieldEmailAddress.decoration?.hintText, 'Enter your email here');
      expect(textFieldEmailAddress.decoration?.errorText,
          'Please enter a valid email address.');
    }
  });

  testWidgets(
      'When Click On System Ok Button And Receive No Internet Exception',
      (WidgetTester tester) async {
    await tester.pumpWidget(highStreetApparelTest.widget);

    when(() => getIt.get<MockLoginFlowRestClient>().sendOtpRequest(any()))
        .thenAnswer((_) async {
      await Future.delayed(const Duration(seconds: 1));

      throw DioException(
        requestOptions: RequestOptions(path: '/send-reset-otp'),
        type: DioExceptionType.connectionError,
      );
    });

    await tester.enterText(
        find.byKey(const Key("text_field_email_address")), email);
    await tester.pumpAndSettle();

    await tester.testTextInput.receiveAction(TextInputAction.done);
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

  testWidgets('When Click On System Ok Button And Receive 404',
      (WidgetTester tester) async {
    await tester.pumpWidget(highStreetApparelTest.widget);

    when(() => getIt.get<MockLoginFlowRestClient>().sendOtpRequest(any()))
        .thenAnswer((_) async {
      await Future.delayed(const Duration(seconds: 1));

      throw DioException(
        requestOptions: RequestOptions(path: '/send-reset-otp'),
        response: Response(
          requestOptions: RequestOptions(path: '/send-reset-otp'),
          statusCode: 404,
          data: {"message": "Invalid input"},
        ),
      );
    });

    await tester.enterText(
        find.byKey(const Key("text_field_email_address")), email);
    await tester.pumpAndSettle();

    await tester.testTextInput.receiveAction(TextInputAction.done);
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

  testWidgets('When Click On System Ok Button And Receive 500',
      (WidgetTester tester) async {
    await tester.pumpWidget(highStreetApparelTest.widget);

    when(() => getIt.get<MockLoginFlowRestClient>().sendOtpRequest(any()))
        .thenAnswer((_) async {
      await Future.delayed(const Duration(seconds: 1));

      throw DioException(
        requestOptions: RequestOptions(path: '/send-reset-otp'),
        response: Response(
            requestOptions: RequestOptions(path: '/send-reset-otp'),
            statusCode: 500),
      );
    });

    await tester.enterText(
        find.byKey(const Key("text_field_email_address")), email);
    await tester.pumpAndSettle();

    await tester.testTextInput.receiveAction(TextInputAction.done);
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

  testWidgets('When Email Is Valid And Receive Success',
      (WidgetTester tester) async {
    HighStyleCountDownTimerHelper mockHighStyleCountDownTimer =
        getIt.get<HighStyleCountDownTimerHelper>();

    when(() => mockHighStyleCountDownTimer.endTime())
        .thenReturn(StopWatchTimer.getMilliSecFromMinute(0));

    await tester.pumpWidget(highStreetApparelTest.widget);

    when(() => getIt.get<MockLoginFlowRestClient>().sendOtpRequest(any()))
        .thenAnswer((_) async {
      await Future.delayed(const Duration(seconds: 1));

      return const SendOtpResponse("", sessionId);
    });

    await tester.enterText(
        find.byKey(const Key("text_field_email_address")), email);
    await tester.pumpAndSettle();

    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();
    await tester.pump();

    await expectLater(find.byType(AlertDialog), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text("Loading"), findsOneWidget);

    await tester.pumpAndSettle();

    expect(
        highStreetApparelTest.router.state?.uri.toString(),
        const VerificationCodeRoute(sessionId: sessionId, emailId: email)
            .location);
  });
}
