import 'package:json_annotation/json_annotation.dart';
part 'data_categories.g.dart';
@JsonSerializable()
class DataCategories {
  int id;
  String name;
  String slug;

  DataCategories({required this.id, required this.name,required  this.slug});

  factory DataCategories.fromJson(Map<String, dynamic> json) => _$DataCategoriesFromJson(json);
  Map<String, dynamic> toJson() => _$DataCategoriesToJson(this);
}