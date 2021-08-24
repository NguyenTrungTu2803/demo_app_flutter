// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'body_login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BodyLogin _$BodyLoginFromJson(Map<String, dynamic> json) {
  return BodyLogin(
    email: json['email'] as String,
    password: json['password'] as String,
  );
}

Map<String, dynamic> _$BodyLoginToJson(BodyLogin instance) => <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };
