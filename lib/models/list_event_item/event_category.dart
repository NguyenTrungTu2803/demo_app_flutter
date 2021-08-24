import 'package:json_annotation/json_annotation.dart';
part 'event_category.g.dart';
@JsonSerializable()
class EventCategory{
  String name;
  String slug;

  EventCategory({required this.name,required  this.slug});
  factory EventCategory.fromJson(Map<String, dynamic> json) => _$EventCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$EventCategoryToJson(this);
}