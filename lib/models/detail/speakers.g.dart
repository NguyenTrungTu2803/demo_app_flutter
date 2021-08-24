// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speakers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Speakers _$SpeakersFromJson(Map<String, dynamic> json) {
  return Speakers(
    gender: json['gender'] as String,
    id: json['id'] as int,
    name: json['name'] as String,
    dob: json['dob'] as String,
    follow: json['follow'] as int,
    description: json['description'] as String,
    title: json['title'] as String,
    avatar: json['avatar'] as String,
  );
}

Map<String, dynamic> _$SpeakersToJson(Speakers instance) => <String, dynamic>{
      'id': instance.id,
      'avatar': instance.avatar,
      'title': instance.title,
      'name': instance.name,
      'dob': instance.dob,
      'description': instance.description,
      'follow': instance.follow,
      'gender': instance.gender,
    };
