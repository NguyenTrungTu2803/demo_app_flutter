// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_categories_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventCategoriesModel _$EventCategoriesModelFromJson(Map<String, dynamic> json) {
  return EventCategoriesModel(
    status: json['_status'] as int,
    data: (json['_data'] as List<dynamic>)
        .map((e) => DataCategories.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$EventCategoriesModelToJson(
        EventCategoriesModel instance) =>
    <String, dynamic>{
      '_status': instance.status,
      '_data': instance.data,
    };
