import 'package:json_annotation/json_annotation.dart';
part 'speakers.g.dart';
@JsonSerializable()
class Speakers{
  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'avatar')
  String avatar;
  @JsonKey(name:  'title')
  String title;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'dob')
  String dob;
  @JsonKey(name: 'description')
  String description;
  int follow;
  String gender;
  Speakers(
      {required this.gender,required this.id,required  this.name, required this.dob,required this.follow, required this.description, required this.title, required this.avatar});
  factory Speakers.fromJson(Map<String, dynamic> json) => _$SpeakersFromJson(json);
  Map<String ,dynamic> toJson() => _$SpeakersToJson(this);
}