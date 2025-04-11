import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:highstyleapparel/login/entity/register_request.dart';
import 'package:highstyleapparel/login/entity/register_response.dart';
import 'package:highstyleapparel/navigations.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import '../../dependencies.dart';
import '../../high_street_apparel.dart';
import '../repository/datasource/network/mock_login_flow_rest_client.dart';
import '../repository/datasource/sharedpref/mock_shared_preferences.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late GetIt getIt;
  late HighStreetApparelTest highStreetApparelTest;

  const String userId = "12345";
  const String firstName = "John";
  const String lastName = "Doe";
  const String email = "test@example.com";
  const String password = "password123";
  const int phone = 9890352190;

  setUp(() {
    getIt = initTestDependencies();
    registerFallbackValue(const RegisterRequest(
      firstName,
      lastName,
      email,
      password,
      phone,
    ));
    highStreetApparelTest = HighStreetApparelTest(SignUpRoute().location);
  });

  tearDown(() {
    getIt.reset();
  });

  testWidgets('When First Name Is Empty', (tester) async {
    await tester.pumpWidget(highStreetApparelTest.widget);

    await tester
        .ensureVisible(find.byKey(const Key('outlined_button_sign_up')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('outlined_button_sign_up')));
    await tester.pumpAndSettle();

    Finder textFieldFirstNameFinder =
        find.byKey(const Key("text_field_first_name"));
    expect(textFieldFirstNameFinder, findsOneWidget);
    final textFieldFirstName =
        tester.widget<TextField>(textFieldFirstNameFinder);
    expect(textFieldFirstName.decoration?.hintText, 'First name*');
    expect(textFieldFirstName.decoration?.errorText,
        'Please enter a valid first name.');
  });

  testWidgets('When Email Address Is Empty', (tester) async {
    await tester.pumpWidget(highStreetApparelTest.widget);

    await tester.enterText(
        find.byKey(const Key("text_field_first_name")), firstName);
    await tester.pumpAndSettle();

    await tester
        .ensureVisible(find.byKey(const Key('outlined_button_sign_up')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('outlined_button_sign_up')));
    await tester.pumpAndSettle();

    Finder textFieldEmailAddressFinder =
        find.byKey(const Key("text_field_email_address"));
    expect(textFieldEmailAddressFinder, findsOneWidget);
    final textFieldEmailAddress =
        tester.widget<TextField>(textFieldEmailAddressFinder);
    expect(textFieldEmailAddress.decoration?.hintText, 'Email address*');
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
          find.byKey(const Key("text_field_first_name")), firstName);
      await tester.pumpAndSettle();

      await tester.enterText(
          find.byKey(const Key("text_field_email_address")), email);
      await tester.pumpAndSettle();

      await tester
          .ensureVisible(find.byKey(const Key('outlined_button_sign_up')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('outlined_button_sign_up')));
      await tester.pumpAndSettle();

      Finder textFieldEmailAddressFinder =
          find.byKey(const Key("text_field_email_address"));
      expect(textFieldEmailAddressFinder, findsOneWidget);
      final textFieldEmailAddress =
          tester.widget<TextField>(textFieldEmailAddressFinder);
      expect(textFieldEmailAddress.decoration?.hintText, 'Email address*');
      expect(textFieldEmailAddress.decoration?.errorText,
          'Please enter a valid email address.');
    }
  });

  testWidgets('When Password Is Empty', (tester) async {
    await tester.pumpWidget(highStreetApparelTest.widget);

    await tester.enterText(
        find.byKey(const Key("text_field_first_name")), firstName);
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(const Key("text_field_email_address")), email);
    await tester.pumpAndSettle();

    await tester
        .ensureVisible(find.byKey(const Key('outlined_button_sign_up')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('outlined_button_sign_up')));
    await tester.pumpAndSettle();

    Finder textFieldPasswordFinder =
        find.byKey(const Key("text_field_password"));
    expect(textFieldPasswordFinder, findsOneWidget);
    final textFieldPassword = tester.widget<TextField>(textFieldPasswordFinder);
    expect(textFieldPassword.decoration?.hintText, 'Password*');
    expect(textFieldPassword.decoration?.errorText,
        'Please enter a valid password.');
  });

  testWidgets('When Confirm Password Is Empty', (tester) async {
    await tester.pumpWidget(highStreetApparelTest.widget);

    await tester.enterText(
        find.byKey(const Key("text_field_first_name")), firstName);
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(const Key("text_field_email_address")), email);
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(const Key("text_field_password")), password);
    await tester.pumpAndSettle();

    await tester
        .ensureVisible(find.byKey(const Key('outlined_button_sign_up')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('outlined_button_sign_up')));
    await tester.pumpAndSettle();

    Finder textFieldConfirmPasswordFinder =
        find.byKey(const Key("text_field_confirm_password"));
    expect(textFieldConfirmPasswordFinder, findsOneWidget);
    final textFieldConfirmPassword =
        tester.widget<TextField>(textFieldConfirmPasswordFinder);
    expect(textFieldConfirmPassword.decoration?.hintText, 'Confirm password*');
    expect(textFieldConfirmPassword.decoration?.errorText,
        'Please enter a valid confirm password.');
  });

  testWidgets('When Password and Confirm Password Is Mismatched',
      (tester) async {
    await tester.pumpWidget(highStreetApparelTest.widget);

    await tester.enterText(
        find.byKey(const Key("text_field_first_name")), firstName);
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(const Key("text_field_email_address")), email);
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(const Key("text_field_password")), password);
    await tester.pumpAndSettle();

    const confirmPassword = "123";

    await tester.enterText(
        find.byKey(const Key("text_field_confirm_password")), confirmPassword);
    await tester.pumpAndSettle();

    await tester
        .ensureVisible(find.byKey(const Key('outlined_button_sign_up')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('outlined_button_sign_up')));
    await tester.pumpAndSettle();

    Finder textFieldConfirmPasswordFinder =
        find.byKey(const Key("text_field_confirm_password"));
    expect(textFieldConfirmPasswordFinder, findsOneWidget);
    final textFieldConfirmPassword =
        tester.widget<TextField>(textFieldConfirmPasswordFinder);
    expect(textFieldConfirmPassword.decoration?.hintText, 'Confirm password*');
    expect(textFieldConfirmPassword.decoration?.errorText,
        'Mismatch detected! Please re-enter the correct confirm password.');
  });

  testWidgets('When Mobile Number Is Empty', (tester) async {
    await tester.pumpWidget(highStreetApparelTest.widget);

    await tester.enterText(
        find.byKey(const Key("text_field_first_name")), firstName);
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(const Key("text_field_email_address")), email);
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(const Key("text_field_password")), password);
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(const Key("text_field_confirm_password")), password);
    await tester.pumpAndSettle();

    await tester
        .ensureVisible(find.byKey(const Key('outlined_button_sign_up')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('outlined_button_sign_up')));
    await tester.pumpAndSettle();

    Finder textFieldMobileNumberFinder =
        find.byKey(const Key("text_field_mobile_number"));
    expect(textFieldMobileNumberFinder, findsOneWidget);
    final textFieldMobileNumber =
        tester.widget<TextField>(textFieldMobileNumberFinder);
    expect(textFieldMobileNumber.decoration?.hintText, 'Enter mobile number*');
    expect(textFieldMobileNumber.decoration?.errorText,
        'Please enter a valid mobile number.');
  });

  testWidgets('When Mobile Number Is Invalid', (tester) async {
    await tester.pumpWidget(highStreetApparelTest.widget);

    List<String> invalidMobileNumbers = [
      '1234567890', // Invalid (does not start with 6-9)
      '98765432', // Too short
      '98765432101', // Too long
      'abcdefghij', // Contains letters
      '98765-43210', // Contains special characters
      '0987654321', // Starts with 0
    ];

    for (var mobileNumber in invalidMobileNumbers) {
      await tester.enterText(
          find.byKey(const Key("text_field_first_name")), firstName);
      await tester.pumpAndSettle();

      await tester.enterText(
          find.byKey(const Key("text_field_email_address")), email);
      await tester.pumpAndSettle();

      await tester.enterText(
          find.byKey(const Key("text_field_password")), password);
      await tester.pumpAndSettle();

      await tester.enterText(
          find.byKey(const Key("text_field_confirm_password")), password);
      await tester.pumpAndSettle();

      await tester.enterText(
          find.byKey(const Key("text_field_mobile_number")), mobileNumber);
      await tester.pumpAndSettle();

      await tester
          .ensureVisible(find.byKey(const Key('outlined_button_sign_up')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('outlined_button_sign_up')));
      await tester.pumpAndSettle();

      Finder textFieldMobileNumberFinder =
          find.byKey(const Key("text_field_mobile_number"));
      expect(textFieldMobileNumberFinder, findsOneWidget);
      final textFieldMobileNumber =
          tester.widget<TextField>(textFieldMobileNumberFinder);
      expect(
          textFieldMobileNumber.decoration?.hintText, 'Enter mobile number*');
      expect(textFieldMobileNumber.decoration?.errorText,
          'Please enter a valid mobile number.');
    }
  });

  testWidgets('When Click On SIGN UP Button And Receive No Internet Exception',
      (WidgetTester tester) async {
    await tester.pumpWidget(highStreetApparelTest.widget);

    when(() => getIt.get<MockLoginFlowRestClient>().register(any()))
        .thenAnswer((_) async {
      await Future.delayed(const Duration(seconds: 1));

      throw DioException(
        requestOptions: RequestOptions(path: '/register'),
        type: DioExceptionType.connectionError,
      );
    });
    when(() => getIt.get<MockSharedPreferences>().setString("customerId", any()))
        .thenAnswer((_) async => true);
    when(() => getIt.get<MockSharedPreferences>().getString("customerId"))
        .thenReturn(userId);

    await tester.enterText(
        find.byKey(const Key("text_field_first_name")), firstName);
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(const Key("text_field_last_name")), lastName);
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(const Key("text_field_email_address")), email);
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(const Key("text_field_password")), password);
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(const Key("text_field_confirm_password")), password);
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(const Key("text_field_mobile_number")), phone.toString());
    await tester.pumpAndSettle();

    await tester
        .ensureVisible(find.byKey(const Key('outlined_button_sign_up')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('outlined_button_sign_up')));
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

  testWidgets('When Click On SIGN UP Button And Receive 400',
      (WidgetTester tester) async {
    await tester.pumpWidget(highStreetApparelTest.widget);

    when(() => getIt.get<MockLoginFlowRestClient>().register(any()))
        .thenAnswer((_) async {
      await Future.delayed(const Duration(seconds: 1));

      throw DioException(
        requestOptions: RequestOptions(path: '/register'),
        response: Response(
          requestOptions: RequestOptions(path: '/register'),
          statusCode: 400,
          data: {"message": "Invalid input"},
        ),
      );
    });
    when(() => getIt.get<MockSharedPreferences>().setString("customerId", any()))
        .thenAnswer((_) async => true);
    when(() => getIt.get<MockSharedPreferences>().getString("customerId"))
        .thenReturn(userId);

    await tester.enterText(
        find.byKey(const Key("text_field_first_name")), firstName);
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(const Key("text_field_last_name")), lastName);
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(const Key("text_field_email_address")), email);
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(const Key("text_field_password")), password);
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(const Key("text_field_confirm_password")), password);
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(const Key("text_field_mobile_number")), phone.toString());
    await tester.pumpAndSettle();

    await tester
        .ensureVisible(find.byKey(const Key('outlined_button_sign_up')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('outlined_button_sign_up')));
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

  testWidgets('When Click On SIGN UP Button And Receive 500',
      (WidgetTester tester) async {
    await tester.pumpWidget(highStreetApparelTest.widget);

    when(() => getIt.get<MockLoginFlowRestClient>().register(any()))
        .thenAnswer((_) async {
      await Future.delayed(const Duration(seconds: 1));

      throw DioException(
        requestOptions: RequestOptions(path: '/register'),
        response: Response(
            requestOptions: RequestOptions(path: '/register'), statusCode: 500),
      );
    });
    when(() => getIt.get<MockSharedPreferences>().setString("customerId", any()))
        .thenAnswer((_) async => true);
    when(() => getIt.get<MockSharedPreferences>().getString("customerId"))
        .thenReturn(userId);

    await tester.enterText(
        find.byKey(const Key("text_field_first_name")), firstName);
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(const Key("text_field_last_name")), lastName);
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(const Key("text_field_email_address")), email);
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(const Key("text_field_password")), password);
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(const Key("text_field_confirm_password")), password);
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(const Key("text_field_mobile_number")), phone.toString());
    await tester.pumpAndSettle();

    await tester
        .ensureVisible(find.byKey(const Key('outlined_button_sign_up')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('outlined_button_sign_up')));
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

  testWidgets('When Click On SIGN UP Button And Receive Success',
      (WidgetTester tester) async {
    await tester.pumpWidget(highStreetApparelTest.widget);

    when(() => getIt.get<MockLoginFlowRestClient>().register(any()))
        .thenAnswer((_) async {
      await Future.delayed(const Duration(seconds: 1));

      return const RegisterResponse(userId);
    });
    when(() => getIt.get<MockSharedPreferences>().setString("customerId", any()))
        .thenAnswer((_) async => true);
    when(() => getIt.get<MockSharedPreferences>().getString("customerId"))
        .thenReturn(userId);

    await tester.enterText(
        find.byKey(const Key("text_field_first_name")), firstName);
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(const Key("text_field_last_name")), lastName);
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(const Key("text_field_email_address")), email);
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(const Key("text_field_password")), password);
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(const Key("text_field_confirm_password")), password);
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(const Key("text_field_mobile_number")), phone.toString());
    await tester.pumpAndSettle();

    await tester
        .ensureVisible(find.byKey(const Key('outlined_button_sign_up')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('outlined_button_sign_up')));
    await tester.pump();
    await tester.pump();

    await expectLater(find.byType(AlertDialog), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text("Loading"), findsOneWidget);

    await tester.pumpAndSettle();

    expect(highStreetApparelTest.router.state?.uri.toString(),
        const HomeRoute(customerId: userId).location);
  });

  testWidgets('When Click On Login', (WidgetTester tester) async {
    await tester.pumpWidget(highStreetApparelTest.widget);

    await tester.ensureVisible(find.byKey(const Key('gesture_detector_login')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('gesture_detector_login')));
    await tester.pumpAndSettle();

    expect(highStreetApparelTest.router.state?.path, LoginRoute().location);
  });
}
