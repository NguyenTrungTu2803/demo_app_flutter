import 'package:json_annotation/json_annotation.dart';
part 'data_place.g.dart';
@JsonSerializable()
class DataPlace{
  String address;
  String slug;
  String lat;
  String long;
  DataPlace({required this.address,required  this.slug,required  this.lat,required  this.long});
  factory DataPlace.fromJson(Map<String, dynamic> json) => _$DataPlaceFromJson(json);
  Map<String, dynamic> toJson() => _$DataPlaceToJson(this);
}