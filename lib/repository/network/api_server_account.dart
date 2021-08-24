import 'package:dio/dio.dart';
import 'package:flutter_app_beats/config/app_config.dart';
import 'package:flutter_app_beats/models/model.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/http.dart';
part 'api_server_account.g.dart';

@RestApi(baseUrl: AppConfig.urlAccount)
abstract class ApiServerAccount {
  factory ApiServerAccount(Dio dio, {String baseUrl}) = _ApiServerAccount;
  static ApiServerAccount create() {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
    return ApiServerAccount(dio);
  }

  @POST("${AppConfig.prefix}/auth/login")
  Future<LoginModel> getLogin(@Body() BodyLogin bodyLogin);

  @POST("${AppConfig.prefix}/auth/register")
  Future<RegisterModel> fetchRegister(@Body() BodyRegister bodyRegister);
}