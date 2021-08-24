import 'package:json_annotation/json_annotation.dart';
part 'data_tags.g.dart';
@JsonSerializable()
class DataTags {
  int id;
  String name;

  DataTags({required this.id,required  this.name});

  factory DataTags.fromJson(Map<String, dynamic> json) => _$DataTagsFromJson(json);
  Map<String, dynamic> toJson() => _$DataTagsToJson(this);
}