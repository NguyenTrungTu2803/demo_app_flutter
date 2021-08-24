import 'package:flutter_app_beats/models/model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'extra.g.dart';
@JsonSerializable()
class Extra{
  @JsonKey(name: "_pagination")
  DataExtra pagination;

  Extra({required this.pagination});
  factory Extra.fromJson(Map<String, dynamic> json) => _$ExtraFromJson(json);
  Map<String, dynamic> toJson() => _$ExtraToJson(this);
}