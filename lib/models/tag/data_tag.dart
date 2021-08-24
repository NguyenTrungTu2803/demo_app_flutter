import 'package:json_annotation/json_annotation.dart';

part 'data_tag.g.dart';
@JsonSerializable()
class DataTag{
  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'name')
  String name;

  DataTag({required this.id,required  this.name});
  factory DataTag.fromJson(Map<String, dynamic> json) => _$DataTagFromJson(json);
  Map<String, dynamic> toJson() => _$DataTagToJson(this);
}