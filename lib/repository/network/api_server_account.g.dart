// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_server_account.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ApiServerAccount implements ApiServerAccount {
  _ApiServerAccount(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://user.bcard.mobifocuz.com/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<LoginModel> getLogin(bodyLogin) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(bodyLogin.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<LoginModel>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, 'api/v1/auth/login',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = LoginModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<RegisterModel> fetchRegister(bodyRegister) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(bodyRegister.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<RegisterModel>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, 'api/v1/auth/register',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = RegisterModel.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
