import 'package:flutter_test/flutter_test.dart';
import 'package:highstyleapparel/login/bloc/login_flow_bloc.dart';
import 'package:highstyleapparel/login/contract.dart';
import 'package:highstyleapparel/result.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'login_bloc_unit_test.mocks.dart';

@GenerateMocks([LoginFlowRepository])
void main() {
  late MockLoginFlowRepository mockLoginFlowRepository;
  late LoginFlowBloc loginBloc;

  setUp(() {
    mockLoginFlowRepository = MockLoginFlowRepository();
    loginBloc = LoginFlowBloc(mockLoginFlowRepository);
  });

  group('login', () {
    test('when email address is null', () async {
      final stream = loginBloc.login(null, null);
      final emittedValues = await stream.toList();
      expect(emittedValues[0], isA<Loading>());
      expect(emittedValues[1], isA<Error>());
      final result = emittedValues[1] as Error;
      final invalidEmailException =
          result.exception as InvalidEmailAddressException;
      expect(
          invalidEmailException.cause, "Please enter a valid email address.");
    });

    test('when email address is empty', () async {
      final stream = loginBloc.login("", null);
      final emittedValues = await stream.toList();
      expect(emittedValues[0], isA<Loading>());
      expect(emittedValues[1], isA<Error>());
      final result = emittedValues[1] as Error;
      final invalidEmailException =
          result.exception as InvalidEmailAddressException;
      expect(
          invalidEmailException.cause, "Please enter a valid email address.");
    });

    test('when email address is invalid', () async {
      final stream = loginBloc.login("test@", null);
      final emittedValues = await stream.toList();
      expect(emittedValues[0], isA<Loading>());
      expect(emittedValues[1], isA<Error>());
      final result = emittedValues[1] as Error;
      final invalidEmailException =
          result.exception as InvalidEmailAddressException;
      expect(
          invalidEmailException.cause, "Please enter a valid email address.");
    });

    test('when email address is invalid', () async {
      final stream = loginBloc.login("test@gmail", null);
      final emittedValues = await stream.toList();
      expect(emittedValues[0], isA<Loading>());
      expect(emittedValues[1], isA<Error>());
      final result = emittedValues[1] as Error;
      final invalidEmailException =
          result.exception as InvalidEmailAddressException;
      expect(
          invalidEmailException.cause, "Please enter a valid email address.");
    });

    test('when password is null', () async {
      final stream = loginBloc.login("test@gmail.com", null);
      final emittedValues = await stream.toList();
      expect(emittedValues[0], isA<Loading>());
      expect(emittedValues[1], isA<Error>());
      final result = emittedValues[1] as Error;
      final invalidPasswordException =
          result.exception as InvalidPasswordException;
      expect(invalidPasswordException.cause, "Please enter a valid password.");
    });

    test('when password is empty', () async {
      final stream = loginBloc.login("test@gmail.com", "");
      final emittedValues = await stream.toList();
      expect(emittedValues[0], isA<Loading>());
      expect(emittedValues[1], isA<Error>());
      final result = emittedValues[1] as Error;
      final invalidPasswordException =
          result.exception as InvalidPasswordException;
      expect(invalidPasswordException.cause, "Please enter a valid password.");
    });

    test('when repository throws exception', () async {
      when(mockLoginFlowRepository.login(any, any)).thenThrow(Exception());
      final stream = loginBloc.login("test@gmail.com", "123456");
      final emittedValues = await stream.toList();
      expect(emittedValues[0], isA<Loading>());
      expect(emittedValues[1], isA<Error>());
      final result = emittedValues[1] as Error;
      final exception = result.exception as SomethingWentWrongException;
      expect(exception.cause, "Oops! Something went wrong.");
    });

    test('when repository provide success', () async {
      when(mockLoginFlowRepository.login(any, any)).thenReturn(Success(null));
      final stream = loginBloc.login("test@gmail.com", "123456");
      final emittedValues = await stream.toList();
      expect(emittedValues[0], isA<Loading>());
      expect(emittedValues[1], isA<Success>());
    });
  });

  group('signup', () {
    test('when first name is null', () async {
      final stream = loginBloc.signup(null, null, null, null, null, null);
      final emittedValues = await stream.toList();
      expect(emittedValues[0], isA<Loading>());
      expect(emittedValues[1], isA<Error>());
      final result = emittedValues[1] as Error;
      final invalidFirstNameException =
          result.exception as InvalidFirstNameException;
      expect(
          invalidFirstNameException.cause, "Please enter a valid first name.");
    });

    test('when first name is empty', () async {
      final stream = loginBloc.signup("", null, null, null, null, null);
      final emittedValues = await stream.toList();
      expect(emittedValues[0], isA<Loading>());
      expect(emittedValues[1], isA<Error>());
      final result = emittedValues[1] as Error;
      final invalidFirstNameException =
          result.exception as InvalidFirstNameException;
      expect(
          invalidFirstNameException.cause, "Please enter a valid first name.");
    });

    test('when email address is null', () async {
      final stream = loginBloc.signup("krunal", null, null, null, null, null);
      final emittedValues = await stream.toList();
      expect(emittedValues[0], isA<Loading>());
      expect(emittedValues[1], isA<Error>());
      final result = emittedValues[1] as Error;
      final invalidEmailException =
          result.exception as InvalidEmailAddressException;
      expect(
          invalidEmailException.cause, "Please enter a valid email address.");
    });

    test('when email address is empty', () async {
      final stream = loginBloc.signup("krunal", null, "", null, null, null);
      final emittedValues = await stream.toList();
      expect(emittedValues[0], isA<Loading>());
      expect(emittedValues[1], isA<Error>());
      final result = emittedValues[1] as Error;
      final invalidEmailException =
          result.exception as InvalidEmailAddressException;
      expect(
          invalidEmailException.cause, "Please enter a valid email address.");
    });

    test('when email address is invalid', () async {
      final stream =
          loginBloc.signup("krunal", null, "test@", null, null, null);
      final emittedValues = await stream.toList();
      expect(emittedValues[0], isA<Loading>());
      expect(emittedValues[1], isA<Error>());
      final result = emittedValues[1] as Error;
      final invalidEmailException =
          result.exception as InvalidEmailAddressException;
      expect(
          invalidEmailException.cause, "Please enter a valid email address.");
    });

    test('when email address is invalid', () async {
      final stream =
          loginBloc.signup("krunal", null, "test@gmail", null, null, null);
      final emittedValues = await stream.toList();
      expect(emittedValues[0], isA<Loading>());
      expect(emittedValues[1], isA<Error>());
      final result = emittedValues[1] as Error;
      final invalidEmailException =
          result.exception as InvalidEmailAddressException;
      expect(
          invalidEmailException.cause, "Please enter a valid email address.");
    });

    test('when password is null', () async {
      final stream =
          loginBloc.signup("krunal", null, "test@gmail.com", null, null, null);
      final emittedValues = await stream.toList();
      expect(emittedValues[0], isA<Loading>());
      expect(emittedValues[1], isA<Error>());
      final result = emittedValues[1] as Error;
      final invalidPasswordException =
          result.exception as InvalidPasswordException;
      expect(invalidPasswordException.cause, "Please enter a valid password.");
    });

    test('when password is empty', () async {
      final stream =
          loginBloc.signup("krunal", null, "test@gmail.com", "", null, null);
      final emittedValues = await stream.toList();
      expect(emittedValues[0], isA<Loading>());
      expect(emittedValues[1], isA<Error>());
      final result = emittedValues[1] as Error;
      final invalidPasswordException =
          result.exception as InvalidPasswordException;
      expect(invalidPasswordException.cause, "Please enter a valid password.");
    });

    test('when confirm password is null', () async {
      final stream =
          loginBloc.signup("krunal", null, "test@gmail.com", "123", null, null);
      final emittedValues = await stream.toList();
      expect(emittedValues[0], isA<Loading>());
      expect(emittedValues[1], isA<Error>());
      final result = emittedValues[1] as Error;
      final invalidConfirmPasswordException =
          result.exception as InvalidConfirmPasswordException;
      expect(invalidConfirmPasswordException.cause,
          "Please enter a valid confirm password.");
    });

    test('when confirm password is empty', () async {
      final stream =
          loginBloc.signup("krunal", null, "test@gmail.com", "123", "", null);
      final emittedValues = await stream.toList();
      expect(emittedValues[0], isA<Loading>());
      expect(emittedValues[1], isA<Error>());
      final result = emittedValues[1] as Error;
      final invalidConfirmPasswordException =
          result.exception as InvalidConfirmPasswordException;
      expect(invalidConfirmPasswordException.cause,
          "Please enter a valid confirm password.");
    });

    test('when confirm password mismatch', () async {
      final stream = loginBloc.signup(
          "krunal", null, "test@gmail.com", "123", "1234", null);
      final emittedValues = await stream.toList();
      expect(emittedValues[0], isA<Loading>());
      expect(emittedValues[1], isA<Error>());
      final result = emittedValues[1] as Error;
      final passwordMisMatchException =
          result.exception as PasswordMisMatchException;
      expect(passwordMisMatchException.cause,
          "Mismatch detected! Please re-enter the correct confirm password.");
    });

    test('when mobile number is null', () async {
      final stream = loginBloc.signup(
          "krunal", null, "test@gmail.com", "123", "123", null);
      final emittedValues = await stream.toList();
      expect(emittedValues[0], isA<Loading>());
      expect(emittedValues[1], isA<Error>());
      final result = emittedValues[1] as Error;
      final invalidMobileNumberException =
          result.exception as InvalidMobileNumberException;
      expect(invalidMobileNumberException.cause,
          "Please enter a valid mobile number.");
    });

    test('when mobile number is empty', () async {
      final stream =
          loginBloc.signup("krunal", null, "test@gmail.com", "123", "123", "");
      final emittedValues = await stream.toList();
      expect(emittedValues[0], isA<Loading>());
      expect(emittedValues[1], isA<Error>());
      final result = emittedValues[1] as Error;
      final invalidMobileNumberException =
          result.exception as InvalidMobileNumberException;
      expect(invalidMobileNumberException.cause,
          "Please enter a valid mobile number.");
    });

    test('when mobile number is not having valid length', () async {
      final stream = loginBloc.signup(
          "krunal", null, "test@gmail.com", "123", "123", "8806");
      final emittedValues = await stream.toList();
      expect(emittedValues[0], isA<Loading>());
      expect(emittedValues[1], isA<Error>());
      final result = emittedValues[1] as Error;
      final invalidMobileNumberException =
          result.exception as InvalidMobileNumberException;
      expect(invalidMobileNumberException.cause,
          "Please enter a valid mobile number.");
    });

    test('when repository throws exception', () async {
      when(mockLoginFlowRepository.signup(any, any, any, any, any, any))
          .thenThrow(Exception());
      final stream = loginBloc.signup(
          "krunal", null, "test@gmail.com", "123", "123", "8806616913");
      final emittedValues = await stream.toList();
      expect(emittedValues[0], isA<Loading>());
      expect(emittedValues[1], isA<Error>());
      final result = emittedValues[1] as Error;
      final exception = result.exception as SomethingWentWrongException;
      expect(exception.cause, "Oops! Something went wrong.");
    });
  });

  group('forgotPassword', () {
    test('when email address is null', () async {
      final stream = loginBloc.forgotPassword(null);
      final emittedValues = await stream.toList();
      expect(emittedValues[0], isA<Loading>());
      expect(emittedValues[1], isA<Error>());
      final result = emittedValues[1] as Error;
      final invalidEmailException =
          result.exception as InvalidEmailAddressException;
      expect(
          invalidEmailException.cause, "Please enter a valid email address.");
    });

    test('when email address is empty', () async {
      final stream = loginBloc.forgotPassword("");
      final emittedValues = await stream.toList();
      expect(emittedValues[0], isA<Loading>());
      expect(emittedValues[1], isA<Error>());
      final result = emittedValues[1] as Error;
      final invalidEmailException =
          result.exception as InvalidEmailAddressException;
      expect(
          invalidEmailException.cause, "Please enter a valid email address.");
    });

    test('when email address is invalid', () async {
      final stream = loginBloc.forgotPassword("test@");
      final emittedValues = await stream.toList();
      expect(emittedValues[0], isA<Loading>());
      expect(emittedValues[1], isA<Error>());
      final result = emittedValues[1] as Error;
      final invalidEmailException =
          result.exception as InvalidEmailAddressException;
      expect(
          invalidEmailException.cause, "Please enter a valid email address.");
    });

    test('when email address is invalid', () async {
      final stream = loginBloc.forgotPassword("test@gmail");
      final emittedValues = await stream.toList();
      expect(emittedValues[0], isA<Loading>());
      expect(emittedValues[1], isA<Error>());
      final result = emittedValues[1] as Error;
      final invalidEmailException =
          result.exception as InvalidEmailAddressException;
      expect(
          invalidEmailException.cause, "Please enter a valid email address.");
    });

    test('when repository throws exception', () async {
      when(mockLoginFlowRepository.forgotPassword(any))
          .thenThrow(Exception());
      final stream = loginBloc.forgotPassword("test@gmail.com");
      final emittedValues = await stream.toList();
      expect(emittedValues[0], isA<Loading>());
      expect(emittedValues[1], isA<Error>());
      final result = emittedValues[1] as Error;
      final exception = result.exception as SomethingWentWrongException;
      expect(exception.cause, "Oops! Something went wrong.");
    });

  });

  group('createNewPassword', () {
    test('when password is null', () async {
      final stream =
      loginBloc.createNewPassword(null, null);
      final emittedValues = await stream.toList();
      expect(emittedValues[0], isA<Loading>());
      expect(emittedValues[1], isA<Error>());
      final result = emittedValues[1] as Error;
      final invalidPasswordException =
      result.exception as InvalidPasswordException;
      expect(invalidPasswordException.cause, "Please enter a valid password.");
    });

    test('when password is empty', () async {
      final stream =
      loginBloc.createNewPassword("", null);
      final emittedValues = await stream.toList();
      expect(emittedValues[0], isA<Loading>());
      expect(emittedValues[1], isA<Error>());
      final result = emittedValues[1] as Error;
      final invalidPasswordException =
      result.exception as InvalidPasswordException;
      expect(invalidPasswordException.cause, "Please enter a valid password.");
    });

    test('when confirm password is null', () async {
      final stream =
      loginBloc.createNewPassword("123", null);
      final emittedValues = await stream.toList();
      expect(emittedValues[0], isA<Loading>());
      expect(emittedValues[1], isA<Error>());
      final result = emittedValues[1] as Error;
      final invalidConfirmPasswordException =
      result.exception as InvalidConfirmPasswordException;
      expect(invalidConfirmPasswordException.cause,
          "Please enter a valid confirm password.");
    });

    test('when confirm password is empty', () async {
      final stream =
      loginBloc.createNewPassword("123", "");
      final emittedValues = await stream.toList();
      expect(emittedValues[0], isA<Loading>());
      expect(emittedValues[1], isA<Error>());
      final result = emittedValues[1] as Error;
      final invalidConfirmPasswordException =
      result.exception as InvalidConfirmPasswordException;
      expect(invalidConfirmPasswordException.cause,
          "Please enter a valid confirm password.");
    });

    test('when confirm password mismatch', () async {
      final stream = loginBloc.createNewPassword("123", "1234");
      final emittedValues = await stream.toList();
      expect(emittedValues[0], isA<Loading>());
      expect(emittedValues[1], isA<Error>());
      final result = emittedValues[1] as Error;
      final passwordMisMatchException =
      result.exception as PasswordMisMatchException;
      expect(passwordMisMatchException.cause,
          "Mismatch detected! Please re-enter the correct confirm password.");
    });

    test('when repository throws exception', () async {
      when(mockLoginFlowRepository.createNewPassword(any, any))
          .thenThrow(Exception());
      final stream = loginBloc.createNewPassword("123", "123");
      final emittedValues = await stream.toList();
      expect(emittedValues[0], isA<Loading>());
      expect(emittedValues[1], isA<Error>());
      final result = emittedValues[1] as Error;
      final exception = result.exception as SomethingWentWrongException;
      expect(exception.cause, "Oops! Something went wrong.");
    });

  });

  group('verifyOtp', () {
    test('when otp is null', () async {
      final stream =
      loginBloc.verifyOtp(null);
      final emittedValues = await stream.toList();
      expect(emittedValues[0], isA<Loading>());
      expect(emittedValues[1], isA<Error>());
      final result = emittedValues[1] as Error;
      final invalidOTPException =
      result.exception as InvalidOTPException;
      expect(invalidOTPException.cause, "Please enter a valid otp.");
    });

    test('when otp is empty', () async {
      final stream =
      loginBloc.verifyOtp("");
      final emittedValues = await stream.toList();
      expect(emittedValues[0], isA<Loading>());
      expect(emittedValues[1], isA<Error>());
      final result = emittedValues[1] as Error;
      final invalidOTPException =
      result.exception as InvalidOTPException;
      expect(invalidOTPException.cause, "Please enter a valid otp.");
    });

    test('when otp do not match length', () async {
      final stream =
      loginBloc.verifyOtp("1234");
      final emittedValues = await stream.toList();
      expect(emittedValues[0], isA<Loading>());
      expect(emittedValues[1], isA<Error>());
      final result = emittedValues[1] as Error;
      final invalidOTPException =
      result.exception as InvalidOTPException;
      expect(invalidOTPException.cause, "Please enter a valid otp.");
    });

    test('when repository throws exception', () async {
      when(mockLoginFlowRepository.verifyCode(any))
          .thenThrow(Exception());
      final stream = loginBloc.verifyOtp("123456");
      final emittedValues = await stream.toList();
      expect(emittedValues[0], isA<Loading>());
      expect(emittedValues[1], isA<Error>());
      final result = emittedValues[1] as Error;
      final exception = result.exception as SomethingWentWrongException;
      expect(exception.cause, "Oops! Something went wrong.");
    });

  });

}
