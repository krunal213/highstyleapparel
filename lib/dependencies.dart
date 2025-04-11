import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Blocs
import 'package:highstyleapparel/login/bloc/create_new_password_bloc.dart';
import 'package:highstyleapparel/login/bloc/forgot_password_bloc.dart';
import 'package:highstyleapparel/login/bloc/login_bloc.dart';
import 'package:highstyleapparel/login/bloc/signup_bloc.dart';
import 'package:highstyleapparel/login/bloc/splash_bloc.dart';
import 'package:highstyleapparel/login/bloc/verification_code_bloc.dart';

// Data Sources & Repository
import 'package:highstyleapparel/login/repository/datasource/network/login_flow_network_datasource.dart';
import 'package:highstyleapparel/login/repository/datasource/network/login_flow_rest_client.dart';
import 'package:highstyleapparel/login/repository/datasource/sharedpref/login_flow_disc_datasource.dart';
import 'package:highstyleapparel/login/repository/login_flow_repository.dart';

import 'login/high_style_count_down_timer_helper.dart';

Future<void> initDependencies() async {
  final getIt = GetIt.I; // Placed inside the function

  getIt.registerSingleton<HighStyleCountDownTimerHelper>(
      HighStyleCountDownTimerHelperImpl());

  // Register SharedPreferences as Singleton
  getIt.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());

  // Register Retrofit Client as Singleton
  getIt.registerSingleton<LoginFlowRestClient>(LoginFlowRestClient(Dio()));

  // Register Data Sources as Factories
  getIt.registerFactory<LoginFlowDiscDataSourceImpl>(
      () => LoginFlowDiscDataSourceImpl(getIt<SharedPreferences>()));

  getIt.registerFactory<LoginFlowNetworkDataSourceImpl>(
      () => LoginFlowNetworkDataSourceImpl(getIt<LoginFlowRestClient>()));

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
}
