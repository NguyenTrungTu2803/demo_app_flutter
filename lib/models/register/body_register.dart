import 'package:json_annotation/json_annotation.dart';

part 'body_register.g.dart';
@JsonSerializable()

class BodyRegister{
  String name;
  String email;
  String password;
  String password_confirmation;

  BodyRegister(
      {required this.name,required  this.email,required  this.password,required  this.password_confirmation});
  factory BodyRegister.fromJson(Map<String, dynamic> json) => _$BodyRegisterFromJson(json);
  Map<String, dynamic> toJson() => _$BodyRegisterToJson(this);
}