// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataEvent _$DataEventFromJson(Map<String, dynamic> json) {
  return DataEvent(
    id: json['id'] as int,
    name: json['name'] as String,
    description: json['description'] as String,
    poster: json['poster'] as String,
    duration: json['duration'] as int,
    discount: json['discount'] as int,
    hostedAt: json['hosted_at'] as String,
    endedAt: json['ended_at'] as String,
    discountedFrom: json['discounted_from'] as String,
    discountedTo: json['discounted_to'] as String,
  );
}

Map<String, dynamic> _$DataEventToJson(DataEvent instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'poster': instance.poster,
      'duration': instance.duration,
      'discount': instance.discount,
      'hosted_at': instance.hostedAt,
      'ended_at': instance.endedAt,
      'discounted_from': instance.discountedFrom,
      'discounted_to': instance.discountedTo,
    };
