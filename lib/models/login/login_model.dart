import 'package:json_annotation/json_annotation.dart';
import 'data_login.dart';
import 'extra_login.dart';
part 'login_model.g.dart';
@JsonSerializable()
class LoginModel{
  @JsonKey(name: "_status")
  int status;
  @JsonKey(name: "_data")
  DataLogin data;
  @JsonKey(name: "_messages")
  List<dynamic> messages;
  @JsonKey(name: "_extra")
  ExtraLogin extraLogin;
  LoginModel({required this.status, required this.data, required this.extraLogin,required  this.messages});
  factory LoginModel.fromJson(Map<String, dynamic> json) => _$LoginModelFromJson(json);
  Map<String, dynamic> toJson() => _$LoginModelToJson(this);
}

