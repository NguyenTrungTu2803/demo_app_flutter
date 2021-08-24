import 'package:flutter_app_beats/models/tag/event_categories/data_categories.dart';
import 'package:json_annotation/json_annotation.dart';
part 'event_categories_model.g.dart';
@JsonSerializable()
class EventCategoriesModel{
  @JsonKey(name: '_status')
  int status;
  @JsonKey(name: '_data')
  List<DataCategories> data;

  EventCategoriesModel({required this.status, required this.data});
  factory EventCategoriesModel.fromJson(Map<String, dynamic> json) => _$EventCategoriesModelFromJson(json);
  Map<String, dynamic> toJson() => _$EventCategoriesModelToJson(this);
}