// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_user_follows.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataUserFollow _$DataUserFollowFromJson(Map<String, dynamic> json) {
  return DataUserFollow(
    id: json['id'] as int,
    name: json['name'],
    email: json['email'] as String,
  );
}

Map<String, dynamic> _$DataUserFollowToJson(DataUserFollow instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
    };
