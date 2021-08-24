import 'package:json_annotation/json_annotation.dart';
part 'data_extra.g.dart';
@JsonSerializable()
class DataExtra{
  @JsonKey(name: "_total")
  int total;
  @JsonKey(name: "_limit")
  int limit;

  DataExtra({required this.total,required  this.limit});
  factory DataExtra.fromJson(Map<String, dynamic> json) => _$DataExtraFromJson(json);
  Map<String, dynamic> toJson()=> _$DataExtraToJson(this);
}