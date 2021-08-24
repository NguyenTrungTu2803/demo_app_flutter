import 'package:flutter_app_beats/models/model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'tag_model.g.dart';
@JsonSerializable()
class TagModel {
  @JsonKey(name: '_status')
  int status;
  @JsonKey(name: '_data')
  List<DataTag> dataTag;

  TagModel({required this.status, required this.dataTag});
  factory TagModel.fromJson(Map<String, dynamic> json) => _$TagModelFromJson(json);
  Map<String, dynamic> toJson() => _$TagModelToJson(this);
}