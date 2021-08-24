import 'package:json_annotation/json_annotation.dart';
part 'body_login.g.dart';
@JsonSerializable()
class BodyLogin {
  String email;
  String password;

  BodyLogin({required this.email, required this.password});
  factory BodyLogin.fromJson(Map<String, dynamic> json) => _$BodyLoginFromJson(json);
  Map<String, dynamic> toJson() =>_$BodyLoginToJson(this);
}
