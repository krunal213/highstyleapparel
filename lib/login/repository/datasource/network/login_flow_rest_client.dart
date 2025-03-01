import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'login_flow_rest_client.g.dart';

//https://pub.dev/packages/retrofit
@RestApi(baseUrl: "https://reqres.in/")
abstract class LoginFlowRestClient {
  factory LoginFlowRestClient(Dio dio, {String baseUrl}) = _LoginFlowRestClient;

}
