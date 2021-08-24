import 'package:json_annotation/json_annotation.dart';
part 'data_user_follows.g.dart';
@JsonSerializable()
class DataUserFollow{
  int id;
  var name;
  String email;

  DataUserFollow({required this.id, required this.name, required this.email});

  factory DataUserFollow.fromJson(Map<String, dynamic> json) =>_$DataUserFollowFromJson(json);
  Map<String, dynamic> toJson() => _$DataUserFollowToJson(this);
}