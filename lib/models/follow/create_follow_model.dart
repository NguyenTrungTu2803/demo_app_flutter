import 'package:json_annotation/json_annotation.dart';
part 'create_follow_model.g.dart';
@JsonSerializable()
class CreateFollowModel{
  @JsonKey(name: '_status')
  int status;

  CreateFollowModel({required this.status});
  factory CreateFollowModel.fromJson(Map<String, dynamic> json) => _$CreateFollowModelFromJson(json);
  Map<String, dynamic> toJson() => _$CreateFollowModelToJson(this);
}