// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_list_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataListEvent _$DataListEventFromJson(Map<String, dynamic> json) {
  return DataListEvent(
    id: json['id'] as int,
    name: json['name'] as String,
    description: json['description'] as String,
    duration: json['duration'] as int,
    eventCategory:
        EventCategory.fromJson(json['event_category'] as Map<String, dynamic>),
    discountedFrom: json['discounted_from'] as String,
    discountedTo: json['discounted_to'] as String,
    endedAt: json['ended_at'] as String,
    hostedAt: json['hosted_at'] as String,
    poster: json['poster'] as String,
    place: DataPlace.fromJson(json['place'] as Map<String, dynamic>),
    dataTags: (json['tags'] as List<dynamic>)
        .map((e) => DataTags.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$DataListEventToJson(DataListEvent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'duration': instance.duration,
      'event_category': instance.eventCategory,
      'poster': instance.poster,
      'hosted_at': instance.hostedAt,
      'ended_at': instance.endedAt,
      'discounted_from': instance.discountedFrom,
      'discounted_to': instance.discountedTo,
      'place': instance.place,
      'tags': instance.dataTags,
    };
