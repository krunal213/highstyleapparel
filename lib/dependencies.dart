import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

initObjects(){
  GetIt getIt = GetIt.I;
  final dio = getIt.registerSingleton<Dio>(Dio());
  final sharedPreferences = SharedPreferences.getInstance();
}

