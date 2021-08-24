// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailEventModel _$DetailEventModelFromJson(Map<String, dynamic> json) {
  return DetailEventModel(
    status: json['_status'] as int,
    dataDetailEvent:
        DataDetailEvent.fromJson(json['_data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DetailEventModelToJson(DetailEventModel instance) =>
    <String, dynamic>{
      '_status': instance.status,
      '_data': instance.dataDetailEvent,
    };
