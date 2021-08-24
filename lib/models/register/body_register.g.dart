// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'body_register.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BodyRegister _$BodyRegisterFromJson(Map<String, dynamic> json) {
  return BodyRegister(
    name: json['name'] as String,
    email: json['email'] as String,
    password: json['password'] as String,
    password_confirmation: json['password_confirmation'] as String,
  );
}

Map<String, dynamic> _$BodyRegisterToJson(BodyRegister instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'password_confirmation': instance.password_confirmation,
    };
