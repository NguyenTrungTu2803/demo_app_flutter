import 'package:json_annotation/json_annotation.dart';

part 'extra_login.g.dart';

@JsonSerializable()
class ExtraLogin {
  @JsonKey(name: "_block")
  var block;

  ExtraLogin({this.block});
  factory ExtraLogin.fromJson(Map<String, dynamic> json) =>
      _$ExtraLoginFromJson(json);
  Map<String, dynamic> toJson() => _$ExtraLoginToJson(this);
}
