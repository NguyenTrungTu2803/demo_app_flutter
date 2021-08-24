// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginModel _$LoginModelFromJson(Map<String, dynamic> json) {
  return LoginModel(
    status: json['_status'] as int,
    data: DataLogin.fromJson(json['_data'] as Map<String, dynamic>),
    extraLogin: ExtraLogin.fromJson(json['_extra'] as Map<String, dynamic>),
    messages: json['_messages'] as List<dynamic>,
  );
}

Map<String, dynamic> _$LoginModelToJson(LoginModel instance) =>
    <String, dynamic>{
      '_status': instance.status,
      '_data': instance.data,
      '_messages': instance.messages,
      '_extra': instance.extraLogin,
    };
