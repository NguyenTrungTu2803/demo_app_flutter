// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventCategory _$EventCategoryFromJson(Map<String, dynamic> json) {
  return EventCategory(
    name: json['name'] as String,
    slug: json['slug'] as String,
  );
}

Map<String, dynamic> _$EventCategoryToJson(EventCategory instance) =>
    <String, dynamic>{
      'name': instance.name,
      'slug': instance.slug,
    };
