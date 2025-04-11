import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:highstyleapparel/login/entity/send_otp_request.dart';
import 'package:highstyleapparel/login/entity/send_otp_response.dart';
import 'package:highstyleapparel/login/entity/verify_otp_request.dart';
import 'package:highstyleapparel/login/entity/verify_otp_response.dart';
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

  const String sessionId = "12345rjfghfjdghuerjegbjdfbjbfggjh";
  const String verifyCode = "123456";
  const String email = "test@example.com";

  setUp(() {
    getIt = initTestDependencies();
    registerFallbackValue(const VerifyOtpRequest(sessionId, verifyCode));
    registerFallbackValue(const SendOtpRequest(email));
  });

  tearDown(() {
    getIt.reset();
  });

  testWidgets('After Submitting OTP Receive No Internet Exception',
      (WidgetTester tester) async {
    HighStyleCountDownTimerHelper mockHighStyleCountDownTimer =
        getIt.get<HighStyleCountDownTimerHelper>();

    when(() => mockHighStyleCountDownTimer.endTime())
        .thenReturn(StopWatchTimer.getMilliSecFromMinute(0));

    highStreetApparelTest = HighStreetApparelTest(
        const VerificationCodeRoute(sessionId: sessionId, emailId: email)
            .location);

    await tester.pumpWidget(highStreetApparelTest.widget);

    when(() => getIt.get<MockLoginFlowRestClient>().verifyCode(any()))
        .thenAnswer((_) async {
      await Future.delayed(const Duration(seconds: 1));

      throw DioException(
        requestOptions: RequestOptions(path: '/verify-reset-otp'),
        type: DioExceptionType.connectionError,
      );
    });

    await tester.enterText(find.byKey(const Key("pin_input_otp")), verifyCode);
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

  testWidgets('After Submitting OTP Receive 404', (WidgetTester tester) async {
    HighStyleCountDownTimerHelper mockHighStyleCountDownTimer =
        getIt.get<HighStyleCountDownTimerHelper>();

    when(() => mockHighStyleCountDownTimer.endTime())
        .thenReturn(StopWatchTimer.getMilliSecFromMinute(0));

    highStreetApparelTest = HighStreetApparelTest(
        const VerificationCodeRoute(sessionId: sessionId, emailId: email)
            .location);

    await tester.pumpWidget(highStreetApparelTest.widget);

    when(() => getIt.get<MockLoginFlowRestClient>().verifyCode(any()))
        .thenAnswer((_) async {
      await Future.delayed(const Duration(seconds: 1));

      throw DioException(
        requestOptions: RequestOptions(path: '/verify-reset-otp'),
        response: Response(
          requestOptions: RequestOptions(path: '/verify-reset-otp'),
          statusCode: 404,
          data: {"message": "Invalid input"},
        ),
      );
    });

    await tester.enterText(find.byKey(const Key("pin_input_otp")), verifyCode);
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

  testWidgets('After Submitting OTP Receive 500', (WidgetTester tester) async {
    HighStyleCountDownTimerHelper mockHighStyleCountDownTimer =
        getIt.get<HighStyleCountDownTimerHelper>();

    when(() => mockHighStyleCountDownTimer.endTime())
        .thenReturn(StopWatchTimer.getMilliSecFromMinute(0));

    highStreetApparelTest = HighStreetApparelTest(
        const VerificationCodeRoute(sessionId: sessionId, emailId: email)
            .location);

    await tester.pumpWidget(highStreetApparelTest.widget);

    when(() => getIt.get<MockLoginFlowRestClient>().verifyCode(any()))
        .thenAnswer((_) async {
      await Future.delayed(const Duration(seconds: 1));

      throw DioException(
        requestOptions: RequestOptions(path: '/verify-reset-otp'),
        response: Response(
            requestOptions: RequestOptions(path: '/verify-reset-otp'),
            statusCode: 500),
      );
    });

    await tester.enterText(find.byKey(const Key("pin_input_otp")), verifyCode);
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

    highStreetApparelTest = HighStreetApparelTest(
        const VerificationCodeRoute(sessionId: sessionId, emailId: email)
            .location);

    await tester.pumpWidget(highStreetApparelTest.widget);

    when(() => getIt.get<MockLoginFlowRestClient>().verifyCode(any()))
        .thenAnswer((_) async {
      await Future.delayed(const Duration(seconds: 1));

      return const VerifyOtpResponse("");
    });

    await tester.enterText(find.byKey(const Key("pin_input_otp")), verifyCode);
    await tester.pump();
    await tester.pump();

    await expectLater(find.byType(AlertDialog), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text("Loading"), findsOneWidget);

    await tester.pumpAndSettle();

    expect(highStreetApparelTest.router.state?.uri.toString(),
        const CreateNewPasswordRoute(sessionId: sessionId).location);
  });

  testWidgets(
      'When Click On Resend Now Button And Receive No Internet Exception',
      (WidgetTester tester) async {
    HighStyleCountDownTimerHelper mockHighStyleCountDownTimer =
        getIt.get<HighStyleCountDownTimerHelper>();

    when(() => mockHighStyleCountDownTimer.endTime())
        .thenReturn(StopWatchTimer.getMilliSecFromMinute(0));

    highStreetApparelTest = HighStreetApparelTest(
        const VerificationCodeRoute(sessionId: sessionId, emailId: email)
            .location);

    await tester.pumpWidget(highStreetApparelTest.widget);

    when(() => getIt.get<MockLoginFlowRestClient>().sendOtpRequest(any()))
        .thenAnswer((_) async {
      await Future.delayed(const Duration(seconds: 1));

      throw DioException(
        requestOptions: RequestOptions(path: '/send-reset-otp'),
        type: DioExceptionType.connectionError,
      );
    });

    await tester.pump(const Duration(seconds: 2));
    await tester.tap(find.byKey(const Key('resend_now')));

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

  testWidgets('When Click On Resend Now Button And Receive 404',
      (WidgetTester tester) async {
    HighStyleCountDownTimerHelper mockHighStyleCountDownTimer =
        getIt.get<HighStyleCountDownTimerHelper>();

    when(() => mockHighStyleCountDownTimer.endTime())
        .thenReturn(StopWatchTimer.getMilliSecFromMinute(0));

    highStreetApparelTest = HighStreetApparelTest(
        const VerificationCodeRoute(sessionId: sessionId, emailId: email)
            .location);

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

    await tester.pump(const Duration(seconds: 2));
    await tester.tap(find.byKey(const Key('resend_now')));

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

  testWidgets('When Click On Resend Now Button And Receive 500',
      (WidgetTester tester) async {
    HighStyleCountDownTimerHelper mockHighStyleCountDownTimer =
        getIt.get<HighStyleCountDownTimerHelper>();

    when(() => mockHighStyleCountDownTimer.endTime())
        .thenReturn(StopWatchTimer.getMilliSecFromMinute(0));

    highStreetApparelTest = HighStreetApparelTest(
        const VerificationCodeRoute(sessionId: sessionId, emailId: email)
            .location);

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

    await tester.tap(find.byKey(const Key('resend_now')));

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

  testWidgets('When Click On Resend Now Button And Receive Success',
      (WidgetTester tester) async {
    HighStyleCountDownTimerHelper mockHighStyleCountDownTimer =
        getIt.get<HighStyleCountDownTimerHelper>();

    when(() => mockHighStyleCountDownTimer.endTime())
        .thenReturn(StopWatchTimer.getMilliSecFromMinute(0));

    highStreetApparelTest = HighStreetApparelTest(
        const VerificationCodeRoute(sessionId: sessionId, emailId: email)
            .location);

    await tester.pumpWidget(highStreetApparelTest.widget);

    when(() => getIt.get<MockLoginFlowRestClient>().sendOtpRequest(any()))
        .thenAnswer((_) async {
      await Future.delayed(const Duration(seconds: 1));

      return const SendOtpResponse(
          "OTP send successfully on your email", sessionId);
    });

    await tester.tap(find.byKey(const Key('resend_now')));

    await tester.pump();
    await tester.pump();

    await expectLater(find.byType(AlertDialog), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text("Loading"), findsOneWidget);

    await tester.pumpAndSettle();

    expect(find.byType(SnackBar), findsOneWidget);
    final snackBar = tester.widget<SnackBar>(find.byType(SnackBar));
    final snackBarContent = snackBar.content as Text;
    expect(snackBarContent.data, equals('OTP send successfully on your email'));
  });

  testWidgets('When Click On Resend Now Button And Receive Success',
      (WidgetTester tester) async {
    HighStyleCountDownTimerHelper mockHighStyleCountDownTimer =
        getIt.get<HighStyleCountDownTimerHelper>();

    when(() => mockHighStyleCountDownTimer.endTime())
        .thenReturn(StopWatchTimer.getMilliSecFromMinute(0));

    highStreetApparelTest = HighStreetApparelTest(
        const VerificationCodeRoute(sessionId: sessionId, emailId: email)
            .location);

    await tester.pumpWidget(highStreetApparelTest.widget);

    when(() => getIt.get<MockLoginFlowRestClient>().sendOtpRequest(any()))
        .thenAnswer((_) async {
      await Future.delayed(const Duration(seconds: 1));

      return const SendOtpResponse(
          "OTP send successfully on your email", sessionId);
    });

    await tester.tap(find.byKey(const Key('resend_now')));

    await tester.pump();
    await tester.pump();

    await expectLater(find.byType(AlertDialog), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text("Loading"), findsOneWidget);

    await tester.pumpAndSettle();

    expect(find.byType(SnackBar), findsOneWidget);
    final snackBar = tester.widget<SnackBar>(find.byType(SnackBar));
    final snackBarContent = snackBar.content as Text;
    expect(snackBarContent.data, equals('OTP send successfully on your email'));
  });

  testWidgets('When Timer Is Greater Than Zero', (WidgetTester tester) async {
    HighStyleCountDownTimerHelper mockHighStyleCountDownTimer =
        getIt.get<HighStyleCountDownTimerHelper>();

    when(() => mockHighStyleCountDownTimer.endTime())
        .thenReturn(StopWatchTimer.getMilliSecFromSecond(1));

    highStreetApparelTest = HighStreetApparelTest(
        const VerificationCodeRoute(sessionId: sessionId, emailId: email)
            .location);

    await tester.pumpWidget(highStreetApparelTest.widget);

    final textFinder = find.byKey(const Key('count_down_timer'));

    expect(textFinder, findsOneWidget);

    final widget = tester.widget(textFinder);
    expect(widget, isA<Text>());

    final textWidget = widget as Text;
    expect(textWidget.data, 'Resend in 00:01'); // Or use your expected string
  });

  testWidgets('When Timer Is Greater Than Zero And Restart Timer',
      (WidgetTester tester) async {
    HighStyleCountDownTimerHelper mockHighStyleCountDownTimer =
        getIt.get<HighStyleCountDownTimerHelper>();

    when(() => mockHighStyleCountDownTimer.endTime())
        .thenReturn(StopWatchTimer.getMilliSecFromSecond(1));

    highStreetApparelTest = HighStreetApparelTest(
        const VerificationCodeRoute(sessionId: sessionId, emailId: email)
            .location);

    await tester.pumpWidget(highStreetApparelTest.widget);

    when(() => getIt.get<MockLoginFlowRestClient>().sendOtpRequest(any()))
        .thenAnswer((_) async {
      return const SendOtpResponse(
          "OTP send successfully on your email", sessionId);
    });

    await tester.pump(const Duration(seconds: 2));

    await tester.tap(find.byKey(const Key('resend_now')));

    await tester.pumpAndSettle();

    final textFinder = find.byKey(const Key('count_down_timer'));

    expect(textFinder, findsOneWidget);

    final widget = tester.widget(textFinder);
    expect(widget, isA<Text>());
  });
}
