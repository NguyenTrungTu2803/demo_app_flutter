// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataLogin _$DataLoginFromJson(Map<String, dynamic> json) {
  return DataLogin(
    token: json['token'] as String,
    token_expired_at: json['token_expired_at'] as String,
    token_expired_at_timestamp: json['token_expired_at_timestamp'] as int,
  );
}

Map<String, dynamic> _$DataLoginToJson(DataLogin instance) => <String, dynamic>{
      'token': instance.token,
      'token_expired_at': instance.token_expired_at,
      'token_expired_at_timestamp': instance.token_expired_at_timestamp,
    };
