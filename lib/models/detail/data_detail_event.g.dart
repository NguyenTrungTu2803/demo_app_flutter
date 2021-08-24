// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_detail_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataDetailEvent _$DataDetailEventFromJson(Map<String, dynamic> json) {
  return DataDetailEvent(
    id: json['id'] as int,
    name: json['name'] as String,
    description: json['description'] as String,
    poster: json['poster'] as String,
    place: DataPlace.fromJson(json['place'] as Map<String, dynamic>),
    duration: json['duration'] as int,
    discount: json['discount'] as int,
    eventCategory:
        EventCategory.fromJson(json['event_category'] as Map<String, dynamic>),
    speakers: (json['speakers'] as List<dynamic>)
        .map((e) => Speakers.fromJson(e as Map<String, dynamic>))
        .toList(),
    listTickets: (json['tickets'] as List<dynamic>)
        .map((e) => DataTickets.fromJson(e as Map<String, dynamic>))
        .toList(),
    hostedAt: json['hosted_at'] as String,
    endedAt: json['ended_at'] as String,
    userFollows: (json['user_follows'] as List<dynamic>)
        .map((e) => DataUserFollow.fromJson(e as Map<String, dynamic>))
        .toList(),
    discountedFrom: json['discounted_from'] as String,
    discountedTo: json['discounted_to'] as String,
  );
}

Map<String, dynamic> _$DataDetailEventToJson(DataDetailEvent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'poster': instance.poster,
      'place': instance.place,
      'duration': instance.duration,
      'discount': instance.discount,
      'event_category': instance.eventCategory,
      'tickets': instance.listTickets,
      'hosted_at': instance.hostedAt,
      'ended_at': instance.endedAt,
      'discounted_from': instance.discountedFrom,
      'discounted_to': instance.discountedTo,
      'speakers': instance.speakers,
      'user_follows': instance.userFollows,
    };
