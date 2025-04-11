// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `HighStyleApparel`
  String get title_app_title {
    return Intl.message(
      'HighStyleApparel',
      name: 'title_app_title',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to \n High Style Apparel`
  String get title_welcome_screen_title {
    return Intl.message(
      'Welcome to \n High Style Apparel',
      name: 'title_welcome_screen_title',
      desc: '',
      args: [],
    );
  }

  /// `The home for a highstyleapparel`
  String get title_welcome_screen_sub_title {
    return Intl.message(
      'The home for a highstyleapparel',
      name: 'title_welcome_screen_sub_title',
      desc: '',
      args: [],
    );
  }

  /// `LOG IN`
  String get title_login_uppercase {
    return Intl.message(
      'LOG IN',
      name: 'title_login_uppercase',
      desc: '',
      args: [],
    );
  }

  /// `SIGN UP`
  String get title_signup_uppercase {
    return Intl.message(
      'SIGN UP',
      name: 'title_signup_uppercase',
      desc: '',
      args: [],
    );
  }

  /// `Log into\nyour account`
  String get title_login_screen_title {
    return Intl.message(
      'Log into\nyour account',
      name: 'title_login_screen_title',
      desc: '',
      args: [],
    );
  }

  /// `Email address`
  String get title_login_screen_email_address_hint {
    return Intl.message(
      'Email address',
      name: 'title_login_screen_email_address_hint',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get title_password_hint {
    return Intl.message(
      'Password',
      name: 'title_password_hint',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get title_forgot_password {
    return Intl.message(
      'Forgot password?',
      name: 'title_forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Don’t have an account?`
  String get title_dont_have_account {
    return Intl.message(
      'Don’t have an account?',
      name: 'title_dont_have_account',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get title_signup_title_case {
    return Intl.message(
      'Sign Up',
      name: 'title_signup_title_case',
      desc: '',
      args: [],
    );
  }

  /// `Create New Account`
  String get title_create_new_account {
    return Intl.message(
      'Create New Account',
      name: 'title_create_new_account',
      desc: '',
      args: [],
    );
  }

  /// `First name*`
  String get title_first_name_hint {
    return Intl.message(
      'First name*',
      name: 'title_first_name_hint',
      desc: '',
      args: [],
    );
  }

  /// `Last name`
  String get title_last_name_hint {
    return Intl.message(
      'Last name',
      name: 'title_last_name_hint',
      desc: '',
      args: [],
    );
  }

  /// `Email address*`
  String get title_email_address_hint {
    return Intl.message(
      'Email address*',
      name: 'title_email_address_hint',
      desc: '',
      args: [],
    );
  }

  /// `Password*`
  String get title_password_hint_required {
    return Intl.message(
      'Password*',
      name: 'title_password_hint_required',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password*`
  String get title_confirm_password_hint_required {
    return Intl.message(
      'Confirm password*',
      name: 'title_confirm_password_hint_required',
      desc: '',
      args: [],
    );
  }

  /// `Enter mobile number*`
  String get title_mobile_number_hint {
    return Intl.message(
      'Enter mobile number*',
      name: 'title_mobile_number_hint',
      desc: '',
      args: [],
    );
  }

  /// `Already have account?`
  String get title_already_have_account {
    return Intl.message(
      'Already have account?',
      name: 'title_already_have_account',
      desc: '',
      args: [],
    );
  }

  /// `Log In`
  String get title_login {
    return Intl.message(
      'Log In',
      name: 'title_login',
      desc: '',
      args: [],
    );
  }

  /// `Verification code`
  String get title_verification_code_tite {
    return Intl.message(
      'Verification code',
      name: 'title_verification_code_tite',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the verification code we sent\nto your email address`
  String get title_verification_code_sub_title {
    return Intl.message(
      'Please enter the verification code we sent\nto your email address',
      name: 'title_verification_code_sub_title',
      desc: '',
      args: [],
    );
  }

  /// `Resend in `
  String get title_resend_in {
    return Intl.message(
      'Resend in ',
      name: 'title_resend_in',
      desc: '',
      args: [],
    );
  }

  /// `Resend Now`
  String get title_resend {
    return Intl.message(
      'Resend Now',
      name: 'title_resend',
      desc: '',
      args: [],
    );
  }

  /// `Enter email associated with your account and we’ll send and email with intructions to reset your password`
  String get title_forgot_password_screen_sub_title {
    return Intl.message(
      'Enter email associated with your account and we’ll send and email with intructions to reset your password',
      name: 'title_forgot_password_screen_sub_title',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email here`
  String get title_forgot_password_screen_email_address_hint {
    return Intl.message(
      'Enter your email here',
      name: 'title_forgot_password_screen_email_address_hint',
      desc: '',
      args: [],
    );
  }

  /// `Create new password`
  String get title_create_newpassword_screen_title {
    return Intl.message(
      'Create new password',
      name: 'title_create_newpassword_screen_title',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get title_new_password_hint {
    return Intl.message(
      'New Password',
      name: 'title_new_password_hint',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get title_confirm_password_hint {
    return Intl.message(
      'Confirm Password',
      name: 'title_confirm_password_hint',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get title_confirm {
    return Intl.message(
      'Confirm',
      name: 'title_confirm',
      desc: '',
      args: [],
    );
  }

  /// `Loading`
  String get title_loading {
    return Intl.message(
      'Loading',
      name: 'title_loading',
      desc: '',
      args: [],
    );
  }

  /// `Alert!`
  String get title_alert {
    return Intl.message(
      'Alert!',
      name: 'title_alert',
      desc: '',
      args: [],
    );
  }

  /// `Okay`
  String get title_okay {
    return Intl.message(
      'Okay',
      name: 'title_okay',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
