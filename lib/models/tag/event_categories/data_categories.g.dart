// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_categories.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataCategories _$DataCategoriesFromJson(Map<String, dynamic> json) {
  return DataCategories(
    id: json['id'] as int,
    name: json['name'] as String,
    slug: json['slug'] as String,
  );
}

Map<String, dynamic> _$DataCategoriesToJson(DataCategories instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
    };
