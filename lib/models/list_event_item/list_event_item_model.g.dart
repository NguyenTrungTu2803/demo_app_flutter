// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_event_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListEventItemModel _$ListEventItemModelFromJson(Map<String, dynamic> json) {
  return ListEventItemModel(
    status: json['_status'] as int,
    dataListEvent: (json['_data'] as List<dynamic>)
        .map((e) => DataListEvent.fromJson(e as Map<String, dynamic>))
        .toList(),
    extra: Extra.fromJson(json['_extra'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ListEventItemModelToJson(ListEventItemModel instance) =>
    <String, dynamic>{
      '_status': instance.status,
      '_data': instance.dataListEvent,
      '_extra': instance.extra,
    };
