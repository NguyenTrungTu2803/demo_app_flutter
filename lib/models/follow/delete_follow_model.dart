import 'package:json_annotation/json_annotation.dart';
part 'delete_follow_model.g.dart';
@JsonSerializable()
class DeleteFollowModel {
  @JsonKey(name: '_status')
  int status;

  DeleteFollowModel({required this.status});
  factory DeleteFollowModel.fromJson(Map<String, dynamic> json) => _$DeleteFollowModelFromJson(json);
  Map<String, dynamic> toJson() => _$DeleteFollowModelToJson(this);

}