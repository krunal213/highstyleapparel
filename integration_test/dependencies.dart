import 'package:get_it/get_it.dart';

// Blocs
import 'package:highstyleapparel/login/bloc/create_new_password_bloc.dart';
import 'package:highstyleapparel/login/bloc/forgot_password_bloc.dart';
import 'package:highstyleapparel/login/bloc/login_bloc.dart';
import 'package:highstyleapparel/login/bloc/signup_bloc.dart';
import 'package:highstyleapparel/login/bloc/splash_bloc.dart';
import 'package:highstyleapparel/login/bloc/verification_code_bloc.dart';
import 'package:highstyleapparel/login/high_style_count_down_timer_helper.dart';

// Data Sources & Repository
import 'package:highstyleapparel/login/repository/datasource/network/login_flow_network_datasource.dart';
import 'package:highstyleapparel/login/repository/datasource/sharedpref/login_flow_disc_datasource.dart';
import 'package:highstyleapparel/login/repository/login_flow_repository.dart';

import 'login/mock_high_style_count_down_timer_helper.dart';
import 'login/repository/datasource/network/mock_login_flow_rest_client.dart';
import 'login/repository/datasource/sharedpref/mock_shared_preferences.dart';

GetIt initTestDependencies() {
  final getIt = GetIt.I; // Placed inside the function

  getIt.registerSingleton<HighStyleCountDownTimerHelper>(
      MockHighStyleCountDownTimer());

  // Register SharedPreferences as Singleton
  getIt.registerSingleton<MockSharedPreferences>(MockSharedPreferences());

  // Register Retrofit Client as Singleton
  getIt.registerSingleton<MockLoginFlowRestClient>(MockLoginFlowRestClient());

  // Register Data Sources as Factories
  getIt.registerFactory<LoginFlowDiscDataSourceImpl>(
      () => LoginFlowDiscDataSourceImpl(getIt<MockSharedPreferences>()));

  getIt.registerFactory<LoginFlowNetworkDataSourceImpl>(
      () => LoginFlowNetworkDataSourceImpl(getIt<MockLoginFlowRestClient>()));

  // Register Repository as Factory
  getIt.registerFactory<LoginRepositoryImpl>(() => LoginRepositoryImpl(
        getIt<LoginFlowDiscDataSourceImpl>(),
        getIt<LoginFlowNetworkDataSourceImpl>(),
      ));

  // Register Blocs as Factories
  getIt.registerFactory<SplashBloc>(
      () => SplashBloc(getIt<LoginRepositoryImpl>()));
  getIt.registerFactory<LoginBloc>(
      () => LoginBloc(getIt<LoginRepositoryImpl>()));
  getIt.registerFactory<SignUpBloc>(
      () => SignUpBloc(getIt<LoginRepositoryImpl>()));
  getIt.registerFactory<ForgotPasswordBloc>(
      () => ForgotPasswordBloc(getIt<LoginRepositoryImpl>()));
  getIt.registerFactory<VerificationCodeBloc>(
      () => VerificationCodeBloc(getIt<LoginRepositoryImpl>()));
  getIt.registerFactory<CreateNewPasswordBloc>(
      () => CreateNewPasswordBloc(getIt<LoginRepositoryImpl>()));

  return getIt;
}
