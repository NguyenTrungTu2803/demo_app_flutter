import 'package:json_annotation/json_annotation.dart';
part 'register_model.g.dart';
@JsonSerializable()
class RegisterModel{
  @JsonKey(name: "_status")
  int status;

  RegisterModel({required this.status});
  factory RegisterModel.fromJson(Map<String, dynamic> json) => _$RegisterModelFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterModelToJson(this);
}