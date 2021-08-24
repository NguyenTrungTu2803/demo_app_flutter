import 'package:json_annotation/json_annotation.dart';

part 'data_login.g.dart';
@JsonSerializable()
class DataLogin{
  String token;
  String token_expired_at;
  int token_expired_at_timestamp;

  DataLogin({required this.token, required this.token_expired_at, required this.token_expired_at_timestamp});

  factory DataLogin.fromJson(Map<String, dynamic> json) => _$DataLoginFromJson(json);
  Map<String, dynamic> toJson() => _$DataLoginToJson(this);
}